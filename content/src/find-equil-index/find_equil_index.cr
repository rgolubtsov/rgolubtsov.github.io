#!/usr/bin/env crystal
# content/src/find-equil-index/find_equil_index.cr
# =============================================================================
# Usage:
#   $ SRCS=https://rgolubtsov.github.io/srcs; \
#     curl -sOk ${SRCS}/find-equil-index/find_equil_index.cr   && \
#     chmod 700 find_equil_index.cr;   ./find_equil_index.cr;  echo $?
# =============================================================================
# This is a demo script. It has to be run as a Crystal script using the Crystal
# tool's runtime facility. Tested and known to run exactly the same way
# on modern versions of OpenBSD/amd64, Ubuntu Server LTS x86-64, and Arch Linux
# operating systems.
#
# A zero-indexed array A consisting of N integers is given. An equilibrium
# index of this array is any integer P such that 0 <= P < N and the sum
# of elements of lower indices is equal to the sum of elements of higher
# indices, i.e.
#
#     A[0] + A[1] + ... + A[P-1] = A[P+1] + ... + A[N-2] + A[N-1].
#
# Sum of zero elements is assumed to be equal to 0. This can happen if P = 0
# or if P = N-1.
#
# For example, consider the following array A consisting of N = 8 elements:
#
#     A[0] = -1
#     A[1] =  3
#     A[2] = -4
#     A[3] =  5
#     A[4] =  1
#     A[5] = -6
#     A[6] =  2
#     A[7] =  1
#
# P = 1 is an equilibrium index of this array, because:
#
#     A[0] = -1 = A[2] + A[3] + A[4] + A[5] + A[6] + A[7]
#
# P = 3 is an equilibrium index of this array, because:
#
#     A[0] + A[1] + A[2] = -2 = A[4] + A[5] + A[6] + A[7]
#
# P = 7 is also an equilibrium index, because:
#
#     A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] = 0
#
# and there are no elements with indices greater than 7.
#
# P = 8 is not an equilibrium index, because it does not fulfill
# the condition 0 <= P < N.
#
# Write a function:
#
#     function solution(A);
#
# that, given a zero-indexed array A consisting of N integers, returns any
# of its equilibrium indices. The function should return -1 if no equilibrium
# index exists.
#
# For example, given array A shown above, the function may return 1, 3 or 7,
# as explained above.
#
# Assume that:
#
#     N is an integer within the range [0..100,000];
#     each element of array A is an integer within the range
#     [-2,147,483,648..2,147,483,647].
#
# Complexity:
#
#     expected worst-case time complexity is O(N);
#     expected worst-case space complexity is O(N), beyond input storage
#     (not counting the storage required for input arguments).
#
# Elements of input arrays can be modified.
# =============================================================================
# Copyright (C) 2025 Radislav (Radicchio) Golubtsov
#
# (See the LICENSE file at the top of the source tree.)
#

# Helper constants.
EQUIL_INDEX_MSG = "==> The equilibrium index of A is "

# The solution function.
def solution(a)
    num_of_A = a.size()

    sum_of_A   = 0 # <== The complete sum of elements of A.
    sum_of_A_1 = 0 # <== The sum of elements of lower  indices of A.
    sum_of_A_2 = 0 # <== The sum of elements of higher indices of A.

    # Calculating the complete sum of elements of A.
    (0 .. (num_of_A - 1)).each() do |i|
        sum_of_A += a[i]
    end

    # Searching for the equilibrium index of A.
    (0 .. (num_of_A - 1)).each() do |i|
        sum_of_A_2  = sum_of_A - sum_of_A_1
        sum_of_A_2 -= a[i]

        puts("==> sum_of_A_1: #{sum_of_A_1}" +
            " ==> sum_of_A_2: #{sum_of_A_2}" +
            " ==> i: #{i}" +
            " ==> A[#{i}]: #{a[i]}")

        if (sum_of_A_1 == sum_of_A_2)
            return i # Okay, the equilibrium index found.
        end

        sum_of_A_1 += a[i]
    end

    return -1 # Returning -1 if there's no such an equilibrium index exist.
end

A = [-1, 3, -4, 5, 1, -6, 2, 1]

i = solution(A)

puts(EOL + EQUIL_INDEX_MSG + "#{i}"); puts()

# vim:set nu et ts=4 sw=4:
