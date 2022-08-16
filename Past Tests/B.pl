num_to_digi(0,[]).
num_to_digi(N,R) :- Nmod10 is mod(N,10), Ndiv10 is div(N,10),
	            num_to_digi(Ndiv10,R1), append(R1,[Nmod10],R), !.
list_to_digi([],[]).
list_to_digi([H|T],R) :- num_to_digi(H,R1), list_to_digi(T,R2),
	                 append([R1],R2,R), !.

flat([],[]).
flat([H|T],R) :- flat(T,R1), append(H,R1,R).

max([M],M).
max([H|T],M) :- max(T,M), H < M, !.
max([H|_],H).

idx([X|_],X,0).
idx([_|T],X,I) :- idx(T,X,I1), I is I1 + 1.

len([],0).
len([_|T],L) :- len(T,L1), L is L1 + 1.

is_middle(L,X) :- len(L,Len), Imid is div(Len,2), idx(L,X,Xidx), Imid =:= Xidx.

rotate([],[]).
rotate([H|T],L) :- append(T,[H],L).

max_mid(L,X,L) :- is_middle(L,X).
max_mid(L,X,R) :- rotate(L,R1), max_mid(R1,X,R), !.

sub([],[],[]).
sub(L,[H1|T1],[H2|T2]) :- append(H2,L2,L),
				  len(H1,LenH1),
				  len(H2,LenH2),
				  LenH2 =:= LenH1,
				  sub(L2,T1,T2), !.

digi_to_num([],0).
digi_to_num(L,N) :- append(A,[B],L), digi_to_num(A,N1), N is B + N1 * 10, !.

list_digi_to_num([],[]).
list_digi_to_num([H|T],R) :- digi_to_num(H,R1),
			     list_digi_to_num(T,R2), append([R1],R2,R), !.

abs_list([],[],[]).
abs_list([H1|T1],[H2|T2],R) :- R1 is abs(H1-H2), abs_list(T1,T2,R2),
			       append([R1],R2,R), !.

solution(L,X) :- list_to_digi(L,A), flat(A,D), max(D,M), max_mid(D,M,Maxmid),
	         sub(Maxmid,A,B), list_digi_to_num(B,C), abs_list(L,C,E),
		 max(E,F), idx(E,F,G), idx(L,X,G).
