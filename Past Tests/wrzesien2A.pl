lista_liczb([],[]).
lista_liczb([H|T],R) :- lista_liczb(T,R1), append(H,R1,R), !.

liczba_na_cyfre(X,[X]) :- X < 10.
liczba_na_cyfre(X,R) :- Xmod10 is mod(X,10), Xdiv10 is div(X,10),
	                liczba_na_cyfre(Xdiv10,R1), append(R1,[Xmod10],R), !.
liczby_na_cyfry([],[]).
liczby_na_cyfry([H1|T1],[H2|T2]) :- liczba_na_cyfre(H1,H2), liczby_na_cyfry(T1,T2), !.

zlicz([],_,0).
zlicz([X|T],X,N) :- zlicz(T,X,N1), N is N1 + 1, !.
zlicz([_|T],X,N) :- zlicz(T,X,N).
zlicz_liste(_,[],[]).
zlicz_liste(L,[H|T],R) :- zlicz(L,H,N), N > 1, zlicz_liste(L,T,R1),
	                  append([H],R1,R), !.
zlicz_liste(L,[_|T],R) :- zlicz_liste(L,T,R).

zeruj([],_,[]).
zeruj([H|T],L,R) :- member(H,L), zeruj(T,L,R1), append([0],R1,R), !.
zeruj([H|T],L,R) :- zeruj(T,L,R1), append([H],R1,R).

len([],0).
len([_|T],N) :- len(T,N1), N is N1 + 1.

podlisty([],[],[]).
podlisty(L,[H1|T1],[H2|T2]) :- append(H2,H3,L), len(H1,L1), len(H2,L2), L1 =:= L2,
	                       podlisty(H3,T1,T2), !.

cyfry_na_liczbe([X],X,1).
cyfry_na_liczbe([H|T],X,I) :- cyfry_na_liczbe(T,X1,I1), I is I1*10, X is H*I+X1, !.
lista_cyfr_na_liczby([],[]).
lista_cyfr_na_liczby([H|T],R) :- cyfry_na_liczbe(H,R1,_), lista_cyfr_na_liczby(T,R2),
	                         append([R1],R2,R), !.
na_punkty([],[]).
na_punkty([H1,H2|T1],[[H1,H2]|T2]) :- na_punkty(T1,T2), !.

odleglosc([A,B],[C,D],X) :- X is sqrt((A-C)^2 + (B-D)^2).
lista_odleglosci([],[],[]).
lista_odleglosci([H1|T1],[H2|T2],[H3|T3]) :- odleglosc(H1,H2,H3), lista_odleglosci(T1,T2,T3), !.

max([M],M).
max([H|T],H) :- max(T,M), H > M, !.
max([_|T],M) :- max(T,M).
idx([X|_],X,0).
idx([_|T],X,I) :- idx(T,X,I1), I is I1 + 1.

%rozwiazanie([[17,12],[15,24],[13,8],[621,92]],X).
rozwiazanie(L,X) :- lista_liczb(L,L1), liczby_na_cyfry(L1,L2), lista_liczb(L2,L3),
		    zlicz_liste(L3,L3,L4), zeruj(L3,L4,Z),
		    podlisty(Z,L2,P), lista_cyfr_na_liczby(P,O), na_punkty(O,B),
		    lista_odleglosci(L,B,W), max(W,M), idx(W,M,I), idx(L,X,I).
