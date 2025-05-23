#!/usr/bin/tcc -run
/* content/src/find-equil-index/find_equil_index.c
 * ============================================================================
 * Usage:
 *   $ SRCS=https://rgolubtsov.github.io/srcs; \
       curl -sOk ${SRCS}/find-equil-index/find_equil_index.c   && \
       chmod 700 find_equil_index.c;    ./find_equil_index.c;  echo $?
 * ============================================================================
 * This is a demo script. It has to be run as a C script using TCC
 * (Fabrice Bellard's Tiny C Compiler). Tested and known to run exactly
 * the same way on modern versions of OpenBSD/amd64, Ubuntu Server LTS x86-64,
 * and Arch Linux operating systems.
 * Note: On OpenBSD one may need to symlink
 *       `/usr/local/bin/tcc` to `/usr/bin/tcc` first,
 *       e.g. `$ sudo ln -sfn /usr/local/bin/tcc /usr/bin/tcc` since their
 *       domestic `env` utility doesn't have the `-S` option and therefore
 *       cannot be used in shebang to invoke TCC in the form like this:
 *       `#!/usr/bin/env -S tcc -run`, though it can be used on Linux.
 *
 * A zero-indexed array A consisting of N integers is given. An equilibrium
 * index of this array is any integer P such that 0 <= P < N and the sum
 * of elements of lower indices is equal to the sum of elements of higher
 * indices, i.e.
 *
 *     A[0] + A[1] + ... + A[P-1] = A[P+1] + ... + A[N-2] + A[N-1].
 *
 * Sum of zero elements is assumed to be equal to 0. This can happen if P = 0
 * or if P = N-1.
 *
 * For example, consider the following array A consisting of N = 8 elements:
 *
 *     A[0] = -1
 *     A[1] =  3
 *     A[2] = -4
 *     A[3] =  5
 *     A[4] =  1
 *     A[5] = -6
 *     A[6] =  2
 *     A[7] =  1
 *
 * P = 1 is an equilibrium index of this array, because:
 *
 *     A[0] = -1 = A[2] + A[3] + A[4] + A[5] + A[6] + A[7]
 *
 * P = 3 is an equilibrium index of this array, because:
 *
 *     A[0] + A[1] + A[2] = -2 = A[4] + A[5] + A[6] + A[7]
 *
 * P = 7 is also an equilibrium index, because:
 *
 *     A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] = 0
 *
 * and there are no elements with indices greater than 7.
 *
 * P = 8 is not an equilibrium index, because it does not fulfill
 * the condition 0 <= P < N.
 *
 * Write a function:
 *
 *     function solution(A);
 *
 * that, given a zero-indexed array A consisting of N integers, returns any
 * of its equilibrium indices. The function should return -1 if no equilibrium
 * index exists.
 *
 * For example, given array A shown above, the function may return 1, 3 or 7,
 * as explained above.
 *
 * Assume that:
 *
 *     N is an integer within the range [0..100,000];
 *     each element of array A is an integer within the range
 *     [-2,147,483,648..2,147,483,647].
 *
 * Complexity:
 *
 *     expected worst-case time complexity is O(N);
 *     expected worst-case space complexity is O(N), beyond input storage
 *     (not counting the storage required for input arguments).
 *
 * Elements of input arrays can be modified.
 * ============================================================================
 * Copyright (C) 2017-2025 Radislav (Radicchio) Golubtsov
 *
 * (See the LICENSE file at the top of the source tree.)
 */

#include <stdio.h>
#include <stdlib.h>

/* Helper constants. */
#define NEW_LINE        "\n"
#define EQUIL_INDEX_MSG "==> The equilibrium index of A is %d"

/* The solution function. */
int solution(const int *A, const int num_of_A) {
    int i;

    int sum_of_A   = 0; /* <== The complete sum of elements of A.          */
    int sum_of_A_1 = 0; /* <== The sum of elements of lower  indices of A. */
    int sum_of_A_2 = 0; /* <== The sum of elements of higher indices of A. */

    /* Calculating the complete sum of elements of A. */
    for (i = 0; i < num_of_A; i++) {
        sum_of_A += A[i];
    }

    /* Searching for the equilibrium index of A. */
    for (i = 0; i < num_of_A; i++) {
        sum_of_A_2  = sum_of_A - sum_of_A_1;
        sum_of_A_2 -= A[i];

        printf("==> sum_of_A_1: %d"
              " ==> sum_of_A_2: %d"
              " ==> i: %d"
              " ==> A[%d]: %d" NEW_LINE, sum_of_A_1, sum_of_A_2, i, i, A[i]);

        if (sum_of_A_1 == sum_of_A_2) {
            return i; /* Okay, the equilibrium index found. */
        }

        sum_of_A_1 += A[i];
    }

    return -1; /*Returning -1 if there's no such an equilibrium index exist.*/
}

/* The script entry point. */
int main() {
    const int A[] = {-1, 3, -4, 5, 1, -6, 2, 1};

    int i = solution(A, (sizeof(A) / sizeof(A[0])));

    printf(NEW_LINE EQUIL_INDEX_MSG NEW_LINE NEW_LINE, i);

    return EXIT_SUCCESS;
}

/* vim:set nu et ts=4 sw=4: */
