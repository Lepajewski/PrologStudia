len([],0).
len([_|T],N) :- len(T,N1), N is N1 + 1, !.

okno(_,0,[]).
okno([H|T1],N,[H|T2]) :- N1 is N - 1, okno(T1,N1,T2), !.

lista_okien([],_,_) :- !.
lista_okien(L,N,[L]) :- len(L,N).
lista_okien([H|T],N,[R1|R]) :- len([H|T],X), X >= N, okno([H|T],N,R1),
			  lista_okien(T,N,R), !.

dopelnienie(_,[],[]).
dopelnienie(O,[H|T],L) :- member(H,O), dopelnienie(O,T,L), !.
dopelnienie(O,[H|T],[H|L]) :- dopelnienie(O,T,L).

lista_dopelnien([],_,[]).
lista_dopelnien([H1|T1],L,[R|T2]) :- dopelnienie(H1,L,R), lista_dopelnien(T1,L,T2), !.

suma([],0).
suma([H|T],S) :- suma(T,S1), S is S1 + H, !.
srednia(L,X) :- len(L,A), suma(L,S), X is S / A.
lista_srednich([],[]).
lista_srednich([H|T],[R1|R]) :- srednia(H,R1), lista_srednich(T,R), !.

lista_roznic([],_,[]).
lista_roznic([H|T],N,[R|R1]) :- R is abs(N-H), lista_roznic(T,N,R1), !.

min([M],M).
min([H|T],M) :- min(T,M), M < H, !.
min([H|_],H).

idx([H|_],H,0).
idx([_|T],X,N) :- idx(T,X,N1), N is N1 + 1.

%rozwiazanie([-3,25,-9,12,5,-24,2,0],3,X).
rozwiazanie(L,N,X) :- lista_okien(L,N,O), lista_dopelnien(O,L,D),
		      lista_srednich(D,Sd), srednia(L,S),
		      lista_roznic(Sd,S,A), min(A,M),
		      idx(A,M,B), idx(O,X,B).
