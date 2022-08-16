rozdziel([],_,[],[]).
rozdziel([H1|T1],X,[H1|T2],W) :- X >= H1, rozdziel(T1,X,T2,W), !.
rozdziel([H1|T1],X,M,[H1|T2]) :- rozdziel(T1,X,M,T2).
qsort([],[]).
qsort([H|T],R) :- rozdziel(T,H,M,W), qsort(M,M1), qsort(W,W1),
	          append(M1,[H|W1],R), !.
len([],0).
len([_|T],L) :- len(T,L1), L is L1 + 1, !.
idx([H|_],H,0).
idx([_|T],X,I) :- idx(T,X,I1), I is I1+ 1.

usun_ostatni([_],[]).
usun_ostatni([H1|T1],[H1|T2]) :- usun_ostatni(T1,T2).

para([],[]).
para(L,[X,Y]) :- len(L,Len), idx(L,X,Ix), idx(L,Y,Iy), Ix < Iy, Ix =:= Len - Iy - 1, !.
lista_par([],[]).
lista_par([H|T],R) :- para([H|T],R1), usun_ostatni(T,T1),
		      lista_par(T1,R2), append([R1],R2,R), !.

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

%rozwiazanie([12,16,11,17,-29,-18,22,23,-19,25],X).
rozwiazanie(L,X) :- qsort(L,S), lista_par(S,P), lista_dopelnien(P,S,D),
	            lista_srednich(D,Ls), srednia(L,Sl), lista_roznic(Ls,Sl,R),
		    min(R,M), idx(R,M,I), idx(P,X,I).
