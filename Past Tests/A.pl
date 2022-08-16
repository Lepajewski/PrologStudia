zasieg([L],L,L).
zasieg([L|R],L,P) :- L1 is L + 1, L1 =< P, zasieg(R,L1,P).
podstawy([],0,[]).
podstawy(L,N,R) :- append(_,[B1],L), B1*B1 =< N, append(T2,[B1],R),
                  N1 is N - B1*B1, podstawy(L,N1,T2),!.
podstawy(L,N,R) :- append(T1,[B1],L), B1*B1 > N, podstawy(T1,N,R),!.
lista_list_podstaw([],[]).
lista_list_podstaw([H|T1],[W|T2]) :- zasieg(C,1,H), podstawy(C,H,W),
				      lista_list_podstaw(T1,T2).
len([],0).
len([_|T],L) :- len(T,L1), L is L1 + 1.
suma([],0).
suma([H|T],S) :- suma(T,S1), S is S1 + H.
srednia([],_).
srednia(L,S) :- len(L,Len), suma(L,Suma), S is Suma / Len.
lista_srednich([],[]).
lista_srednich([H|T1],[S|T2]) :- srednia(H,S), lista_srednich(T1,T2), !.
max([M],M).
max([H|T],M) :- max(T,M), M > H, !.
max([H|_],H).
idx([X|_],X,0).
idx([_|T],X,I) :- idx(T,X,I1), I is I1 + 1.
%rozwiazanie([15,20,22,25,33],X).
rozwiazanie(L,X) :- lista_list_podstaw(L,K), lista_srednich(K,S), max(S,M),
		    idx(S,M,I), idx(L,X,I), !.
