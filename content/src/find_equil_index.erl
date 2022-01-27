#!/usr/bin/env escript
% content/src/find_equil_index.erl
% =============================================================================
% Usage:
%   $ curl -sO http://rgolubtsov.github.io/srcs/find_equil_index.erl && \
%     chmod 700                                 find_equil_index.erl && \
%                                             ./find_equil_index.erl; echo $?
% =============================================================================
% This is a demo script. It has to be run in the Erlang/OTP runtime
% environment. Tested and known to run exactly the same way on modern versions
% of OpenBSD/amd64, Ubuntu Server LTS x86-64, Arch Linux / Arch Linux 32
% operating systems.
%
% A zero-indexed array A consisting of N integers is given. An equilibrium
% index of this array is any integer P such that 0 <= P < N and the sum
% of elements of lower indices is equal to the sum of elements of higher
% indices, i.e.
%
%     A[0] + A[1] + ... + A[P-1] = A[P+1] + ... + A[N-2] + A[N-1].
%
% Sum of zero elements is assumed to be equal to 0. This can happen if P = 0
% or if P = N-1.
%
% For example, consider the following array A consisting of N = 8 elements:
%
%     A[0] = -1
%     A[1] =  3
%     A[2] = -4
%     A[3] =  5
%     A[4] =  1
%     A[5] = -6
%     A[6] =  2
%     A[7] =  1
%
% P = 1 is an equilibrium index of this array, because:
%
%     A[0] = -1 = A[2] + A[3] + A[4] + A[5] + A[6] + A[7]
%
% P = 3 is an equilibrium index of this array, because:
%
%     A[0] + A[1] + A[2] = -2 = A[4] + A[5] + A[6] + A[7]
%
% P = 7 is also an equilibrium index, because:
%
%     A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] = 0
%
% and there are no elements with indices greater than 7.
%
% P = 8 is not an equilibrium index, because it does not fulfill
% the condition 0 <= P < N.
%
% Write a function:
%
%     function solution(A);
%
% that, given a zero-indexed array A consisting of N integers, returns any
% of its equilibrium indices. The function should return -1 if no equilibrium
% index exists.
%
% For example, given array A shown above, the function may return 1, 3 or 7,
% as explained above.
%
% Assume that:
%
%     N is an integer within the range [0..100,000];
%     each element of array A is an integer within the range
%     [-2,147,483,648..2,147,483,647].
%
% Complexity:
%
%     expected worst-case time complexity is O(N);
%     expected worst-case space complexity is O(N), beyond input storage
%     (not counting the storage required for input arguments).
%
% Elements of input arrays can be modified.
% =============================================================================
% Copyright (C) 2017-2022 Radislav (Radicchio) Golubtsov
%
% (See the LICENSE file at the top of the source tree.)
%

% Helper constants.
-define(NEW_LINE,        "\n"                                ).
-define(EQUIL_INDEX_MSG, "==> The equilibrium index of A is ").

%% @doc The solution function.
solution(A) ->
    % Calculating the complete sum of elements of A.
    Sum_of_A = lists:sum(A),

    % Searching for the equilibrium index of A.
    try
        lists:foldl(fun(A_, II_) ->
            {I, I_} = II_,

            % Calculating the sum of elements of lower  indices of A.
            Sum_of_A_1 = I_,

            % Calculating the sum of elements of higher indices of A.
            Sum_of_A_2 = (Sum_of_A - Sum_of_A_1) - A_,

            io:put_chars("==> Sum_of_A_1: " ++ integer_to_list(Sum_of_A_1)
                     ++ " ==> Sum_of_A_2: " ++ integer_to_list(Sum_of_A_2)
                     ++ " ==> I: "          ++ integer_to_list(I)
                     ++ " ==> A_: "         ++ integer_to_list(A_)++?NEW_LINE),

            if (Sum_of_A_1 =:= Sum_of_A_2) -> throw(I);
               (true                     ) -> {I + 1, I_ + A_}
            end
        end, {0, 0}, A),

        -1 % Returning -1 if there's no such an equilibrium index exists.
    catch
        throw:I -> I % Okay, the equilibrium index found.
    end.

%% @doc The script entry point.
main(_) ->
    A = [-1, 3, -4, 5, 1, -6, 2, 1],

    I = solution(A),

    io:put_chars(            ?NEW_LINE ++ ?EQUIL_INDEX_MSG
    ++ integer_to_list(I) ++ ?NEW_LINE ++ ?NEW_LINE).

% vim:set nu et ts=4 sw=4:
