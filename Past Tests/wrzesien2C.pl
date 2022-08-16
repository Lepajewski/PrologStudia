minX([[X,_]],X).
minX([[H,_]|T],M) :- minX(T,M), H > M, !.
minX([[H,_]|_],H).
minY([[_,Y]],Y).
minY([[_,H]|T],M) :- minY(T,M), H > M, !.
minY([[_,H]|_],H).
maxX([[X,_]],X).
maxX([[H,_]|T],M) :- maxX(T,M), H < M, !.
maxX([[H,_]|_],H).
maxY([[_,Y]],Y).
maxY([[_,H]|T],M) :- maxY(T,M), H < M, !.
maxY([[_,H]|_],H).
dopelnienie(_,[],[]).
dopelnienie(O,[O|T],L) :- dopelnienie(O,T,L), !.
dopelnienie(O,[H|T],[H|L]) :- dopelnienie(O,T,L).
lista_dopelnien([],_,[]).
lista_dopelnien([H1|T1],L,[R|T2]) :- dopelnienie(H1,L,R), lista_dopelnien(T1,L,T2), !.
centrum(L,[X,Y]) :- maxX(L,MaxX), maxY(L,MaxY), minX(L,MinX), minY(L,MinY),
		    X is (MinX+MaxX)/2, Y is (MinY+MaxY)/2.
lista_centrow([],[]).
lista_centrow([H1|T1],[C|T2]) :- centrum(H1,C), lista_centrow(T1,T2), !.
roznica([X1,Y1],[X2,Y2],R) :- R is abs(X1-X2) + abs(Y1-Y2).
lista_roznic(_,[],[]).
lista_roznic(C,[H|T1],[R|T2]) :- roznica(C,H,R), lista_roznic(C,T1,T2), !.
max([M],M).
max([H|T],M) :- max(T,M), H < M, !.
max([H|_],H).
idx([X|_],X,0).
idx([_|T],X,I) :- idx(T,X,I1), I is I1 + 1.
%rozwiazanie([[5,7],[-7,7],[5,8],[9,5],[7,3],[-1,2]],X).
rozwiazanie(L,X) :- centrum(L,C),
		    lista_dopelnien(L,L,D), lista_centrow(D,C1),
		    lista_roznic(C,C1,R), max(R,M), idx(R,M,I),
		    idx(L,X,I).
