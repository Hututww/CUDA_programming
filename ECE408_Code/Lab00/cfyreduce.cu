#include "error.cuh"
#include <stdio.h>

#ifdef USE_DP
    typedef double real;
#else
    typedef float real;
#endif

const int NUM_REPEATS = 100;
const int N = 100000000;
const int M = sizeof(real) * N;
const int BLOCK_SIZE = 128;

void timing(const real *d_x);

int main(void)
{
    real *h_x = (real*) malloc(M);//这里的h_x还是指向主机内存的
    for (int n = 0; n < N; ++n)
    {
        h_x[n] = 1.23;
    }
    real *d_x;
    CHECK(cudaMalloc(&d_x, M));
    CHECK(cudaMemcpy(d_x, h_x, M, cudaMemcpyHostToDevice));

    printf("\n 原子大王来咯：\n");
    timing(d_x);

    free(h_x);
    CHECK(cudaFree(d_x));
    return 0;
}

void __global__ reduce(const real *d_x, real *d_y, const int N)
{
    const int tid = threadIdx.x;//线程号
    const int bid = blockIdx.x;//块号
    const int n = bid * blockDim.x + tid;//全局线程号
    extern __shared__ real s_y[];//定义共享内存
    s_y[tid] = (n < N) ? d_x[n] : 0.0;//将全局内存中的数据拷贝到共享内存中
    __syncthreads();

    for(int offset = blockDim.x >> 1; offset > 0; offset >>= 1)
    {
        if(tid < offset)
        {
            s_y[tid] = s_y[tid] + s_y[tid + offset];
        }
        __syncthreads();
    }

    if(tid == 0)
    {
        atomicAdd(d_y, s_y[0]);
    }
}

real reduce(const real *d_x)
{
    const int grid_size = (N + BLOCK_SIZE - 1) / BLOCK_SIZE;
    const int smem = sizeof(real) * BLOCK_SIZE;

    real h_y[1] = {0};
    real *d_y;
    CHECK(cudaMalloc(&d_y, sizeof(real)));
    CHECK(cudaMemcpy(d_y, h_y, sizeof(real), cudaMemcpyHostToDevice));

    reduce<<<grid_size, BLOCK_SIZE, smem>>>(d_x, d_y, N);

    CHECK(cudaMemcpy(h_y, d_y, sizeof(real), cudaMemcpyDeviceToHost));
    CHECK(cudaFree(d_y));

    return h_y[0];
}

void timing(const real *d_x)
{
    real sum = 0;

    for(int repeat = 0;repeat < NUM_REPEATS; ++repeat)
    {
        cudaEvent_t start, stop;
        CHECK(cudaEventCreate(&start));
        CHECK(cudaEventCreate(&stop));
        CHECK(cudaEventRecord(start));
        cudaEventQuery(start);

        sum = reduce(d_x);

        CHECK(cudaEventRecord(stop));
        CHECK(cudaEventSynchronize(stop));
        float elapsedTime = 0;
        CHECK(cudaEventElapsedTime(&elapsedTime, start, stop));
        printf("Time = %g ms.\n", elapsedTime);
        CHECK(cudaEventDestroy(start));
        CHECK(cudaEventDestroy(stop));
    }
    printf("Yes!sum = %e\n", sum);
}