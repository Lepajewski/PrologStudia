silnia(1,1).
silnia(N,R) :- silnia(N1,R1), N is N1 + 1, R is R1 * N.
