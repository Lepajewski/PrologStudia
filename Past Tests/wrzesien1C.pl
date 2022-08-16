min([M],M).
min([H|T],M) :- min(T,M), H > M, !.
min([H|_],H).
max([M],M).
max([H|T],M) :- max(T,M), H < M, !.
max([H|_],H).
wyrownaj([],[]).
wyrownaj([[L,P]|T1],[L,P|T2]) :- wyrownaj(T1,T2).
rozdziel([],_,[],[]).
rozdziel([H|T1],N,[H|T2],W) :- H =< N, rozdziel(T1,N,T2,W), !.
rozdziel([H|T1],N,M,[H|T2]) :- rozdziel(T1,N,M,T2).
qsort([],[]).
qsort([H|T],R) :- rozdziel(T,H,M,W), qsort(M,M1), qsort(W,W1), append(M1,[H|W1],R).
zasieg([L],L,L).
zasieg([L|R],L,P) :- L1 is L + 1, L1 =< P, zasieg(R,L1,P).
odrzuc_krance([],_,[]).
odrzuc_krance([H|T],L,R) :- member(H,L), odrzuc_krance(T,L,R), !.
odrzuc_krance([H|T],L,[H|R]) :- odrzuc_krance(T,L,R).
nalezy([L,P],X) :- X > L, X < P.
ile_przedzialow([],_,0).
ile_przedzialow([H|T],N,I) :- nalezy(H,N), !, ile_przedzialow(T,N,I1), I is I1 + 1, !.
ile_przedzialow([_|T],N,I) :- ile_przedzialow(T,N,I).
lista_ile(_,[],[]).
lista_ile(L,[H|T],[R1|R]) :- ile_przedzialow(L,H,R1), lista_ile(L,T,R), !.
%rozwiazanie([[-5,2],[0,4],[-4,3],[-2,6],[-8,-1],[-7,-5]],X).
rozwiazanie(L,X) :- wyrownaj(L,A), min(A,M), max(A,W), qsort(A,S),
	            zasieg(Z,M,W), odrzuc_krance(Z,S,K), lista_ile(L,K,R),
		    max(R,X).
