#include <stdio.h>

__global__ void hiWorld() {
    printf("Hi World from the GPU!\n(block.x %d, thread.x %d)\n", blockIdx.x, threadIdx.x);
}

int main(){
    hiWorld<<<4,2>>>();
    //4个网格，每个网格2个线程
    //4*2=8个线程，所以会输出8次
    cudaDeviceSynchronize();
    return 0;
}

/*
结果：

Hi World from the GPU!
(block.x 1, thread.x 0)
Hi World from the GPU!
(block.x 1, thread.x 1)
Hi World from the GPU!
(block.x 0, thread.x 0)
Hi World from the GPU!
(block.x 0, thread.x 1)
Hi World from the GPU!
(block.x 2, thread.x 0)
Hi World from the GPU!
(block.x 2, thread.x 1)
Hi World from the GPU!
(block.x 3, thread.x 0)
Hi World from the GPU!
(block.x 3, thread.x 1)

*/
