#include <stdio.h>

__global__ void hiWorld() {
    const int blockIndexForX = blockIdx.x;
    const int threadIndexForX = threadIdx.x;
    const int threadIndexForY = threadIdx.y;
    const int threadIndexForZ = threadIdx.z;
    printf("Hi World from the GPU!\nfrom block.x %d, thread.( %d, %d, %d)\n", blockIndexForX, threadIndexForY, threadIndexForY, threadIndexForZ);
}

int main(){
    const dim3 block_size(3, 4, 5);
    hiWorld<<<1, block_size>>>();
    cudaDeviceSynchronize(); 
    return 0;
}

/*

结果：共有 3 * 4 * 5 = 60 个线程

Hi World from the GPU!
from block.x 0, thread.( 2, 2, 2)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 2)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 2)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 2)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 3)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 3)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 3)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 3)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 3)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 3)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 3)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 3)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 3)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 3)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 3)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 3)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 4)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 4)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 4)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 4)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 4)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 4)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 4)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 4)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 4)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 4)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 4)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 4)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 0)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 0)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 0)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 0)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 0)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 0)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 0)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 0)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 0)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 0)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 0)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 0)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 1)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 1)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 1)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 1)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 1)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 1)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 1)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 1)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 1)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 1)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 1)
Hi World from the GPU!
from block.x 0, thread.( 3, 3, 1)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 2)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 2)
Hi World from the GPU!
from block.x 0, thread.( 0, 0, 2)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 2)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 2)
Hi World from the GPU!
from block.x 0, thread.( 1, 1, 2)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 2)
Hi World from the GPU!
from block.x 0, thread.( 2, 2, 2)

*/