rozdziel([],_,[],[]).
rozdziel([H|T1],X,[H|T2],W) :- H =< X, rozdziel(T1,X,T2,W).
rozdziel([H|T1],X,M,[H|T2]) :- H > X, rozdziel(T1,X,M,T2).
qsort([],[]).
qsort([H|T],R) :- rozdziel(T,H,M,W), qsort(M,M1), qsort(W,W1), append(M1,[H|W1],R).

len([],0).
len([_|T],N) :- len(T,N1), N is N1 + 1.
idx([X|_],X,0).
idx([_|T],X,I) :- idx(T,X,I1), I is I1 + 1.
srodek(L,X) :- idx(L,X,I), len(L,A), I =:= A // 2.

rotacja([H|T],L) :- append(T,[H],L).
obracaj(L,L,X) :- srodek(L,X).
obracaj(L,R,X) :- rotacja(L,R1), obracaj(R1,R,X).
ostatni([X],X).
ostatni([_|T],X) :- ostatni(T,X).

usun_ostatni([_],[]).
usun_ostatni([H1|T1],[H1|T2]) :- usun_ostatni(T1,T2).

para([],[]).
para(L,[X,Y]) :- len(L,Len), idx(L,X,Ix), idx(L,Y,Iy), Ix < Iy, Ix =:= Len - Iy - 1,!.
lista_par([_],[]).
lista_par([H|T],R) :- para([H|T],R1), usun_ostatni(T,T1),
		      lista_par(T1,R2), append([R1],R2,R), !.
popraw_przedzialy([],[]).
popraw_przedzialy([[X,Y]|T1],[[Y,X]|T2]) :- X > Y, popraw_przedzialy(T1,T2), !.
popraw_przedzialy([[X,Y]|T1],[[X,Y]|T2]) :- popraw_przedzialy(T1,T2).

srodek_przedzialu([X,Y],S) :- S is (X+Y)/2.
lista_srodkow([],[]).
lista_srodkow([H|T1],[S|T2]) :- srodek_przedzialu(H,S), lista_srodkow(T1,T2).
roznica([],_,[]).
roznica([H|T1],M,[R|T2]) :- R is abs(M-H), roznica(T1,M,T2).

min([M],M).
min([H|T],M) :- min(T,M), H > M, !.
min([H|_],H).

%rozwiazanie([17,9,-7,20,-3,4,1,12,6],X).
rozwiazanie(L,X) :- qsort(L,S), srodek(S,M), obracaj(L,O,M), lista_par(O,P), popraw_przedzialy(P,P1),
	            lista_srodkow(P1,Ls), roznica(Ls,M,R), min(R,Q), idx(R,Q,I), idx(P1,X,I), !.
