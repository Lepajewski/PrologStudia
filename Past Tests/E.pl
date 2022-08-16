rozdziel([],_,[],[]).
rozdziel([H|T],X,M,[H|W]) :- H > X, rozdziel(T,X,M,W).
rozdziel([H|T],X,[H|M],W) :- H =< X, rozdziel(T,X,M,W).
qsort([],[]).
qsort([H|T],Res) :- rozdziel(T,H,Mniejsze,Wieksze), qsort(Mniejsze,Res1),
		    qsort(Wieksze,Res2), append(Res1,[H|Res2],Res), !.

przedzial([_,_],[],[]).
przedzial([L,P],[H|T],Res) :- H > L, H < P, przedzial([L,P],T,Res1),
			       append([H],Res1,Res), !.
przedzial([L,P],[_|T],Res) :- przedzial([L,P],T,Res).
lista_przedzialow([],_,[]).
lista_przedzialow([H|T],L,Res) :- przedzial(H,L,Res1),
				      lista_przedzialow(T,L,Res2),
				      append([Res1],Res2,Res), !.
granice([],_,[]).
granice([[L,P]|T1],[H|T2],Res) :- granice(T1,T2,Res1), append([L],H,A),
	                          append(A,[P],B), append([B],Res1,Res), !.

srodki([],[]).
srodki([[L,P]|T],Res) :-  Mid is (P+L)/2, append([Mid],Res1,Res), srodki(T,Res1),!.

pary([_],[]).
pary([A,B|T],Res) :- pary([B|T],Res1), append([[A,B]],Res1,Res), !.

lezy_w_srodku([A,B],C) :- C >= A, C =< B.

przedzial_ze_srodkiem(_,[],[]).
przedzial_ze_srodkiem(Srodek,[H|_],H) :- lezy_w_srodku(H,Srodek), !.
przedzial_ze_srodkiem(Srodek,[_|T],X) :- przedzial_ze_srodkiem(Srodek,T,X).

lista(_,[],[]).
lista([H1|T1],[H2|T2],Res) :- pary(H2,Pary), przedzial_ze_srodkiem(H1,Pary,Res1),
	                      lista(T1,T2,Res2), append([Res1],Res2,Res), !.

szerokosc_przedzialu([A,B],Len) :- Len is B - A.

szerokosci([],[]).
szerokosci([H1|T1],Res) :- szerokosc_przedzialu(H1,Res1), szerokosci(T1,Res2),
			   append([Res1],Res2,Res).

abs_szer([],[],[]).
abs_szer([H1|T1],[H2|T2],Res) :- abs_szer(T1,T2,Res2), Res1 is abs(H1-H2),
	                         append([Res1],Res2,Res), !.

max([M],M).
max([H|T],M) :- max(T,M1), M1 > H, M=M1, !.
max([M|_],M).

idx([X|_],X,0).
idx([_|T],X,N) :- idx(T,X,N1), N is N1 + 1, !.

rozwiazanie(X,Przedzialy,L) :- qsort(L,Sorted),
	                       lista_przedzialow(Przedzialy,Sorted,Zbiory),
			       granice(Przedzialy,Zbiory,ZbioryGranice),
			       srodki(Przedzialy,Srodki),
			       lista(Srodki,ZbioryGranice,Pary),
			       szerokosci(Pary,SzerPod),
			       szerokosci(Przedzialy,SzerOrg),
			       abs_szer(SzerOrg,SzerPod,Szer), max(Szer,Max),
			       idx(Szer,Max,Idx), idx(Przedzialy,X,Idx).
% rozwiazanie(X,[[-3,5],[0,7],[2,10],[3,8],[-2,2]],[-4,-1,2,4,5,7,8,9]).
