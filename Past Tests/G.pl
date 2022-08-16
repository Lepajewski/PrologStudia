num_to_digits(N,[N]) :- N < 10.
num_to_digits(N,Res) :- Nmod10 is mod(N,10), Ndiv10 is div(N,10),
	                num_to_digits(Ndiv10,Res1), append(Res1,[Nmod10],Res), !.
list_to_digits([],[]).
list_to_digits([H|T],Res) :- num_to_digits(H,Res1), list_to_digits(T,Res2),
	                     append([Res1],Res2,Res), !.

max([M],M).
max([H|T],M) :- max(T,M), H < M, !.
max([H|_],H).
min([M],M).
min([H|T],M) :- min(T,M), H > M, !.
min([H|_],H).
list_of_minmaxes([],[],[]).
list_of_minmaxes([H|T],Maxes,Mins) :- max(H,Max), min(H,Min),
                            list_of_minmaxes(T,Maxes1,Mins1),
	                    append([Max],Maxes1,Maxes), append([Min],Mins1,Mins), !.

len([],0).
len([_|T],N) :- len(T,N1), N is N1 + 1, !.

idx([X|_],X,0).
idx([_|T],X,I) :- idx(T,X,I1), I is I1 + 1.

split(0,L,[],L).
split(N,[H|T1],[H|T2],X) :- N >= 0, M is N-1, split(M,T1,T2,X).

trunc(El,L1,L1) :- len(L1,Len), idx(L1,El,I), J is Len-I-1, J =:= I, !.
trunc(El,L1,L2) :- len(L1,Len), idx(L1,El,I), J is Len-I-1, J < I, D is I-J,
	           split(D,L1,_,L2), !.
trunc(El,L1,L2) :- len(L1,Len), idx(L1,El,I), J is Len-I-1, J > I, D is Len-abs(I-J),
		   split(D,L1,L2,_), !.

%	Digi, Maxes, Mins, Res1,Res2
trunc_list([],[],[],[],[]).
trunc_list([H0|T0],[H1|T1],[H2|T2],Res1,Res2) :- trunc(H1,H0,Res11),
						 trunc(H2,H0,Res21),
				     trunc_list(T0,T1,T2,Res12,Res22),
				     append([Res11],Res12,Res1),
				     append([Res21],Res22,Res2), !.

digi_to_num([],0).
digi_to_num([H|T],N) :- digi_to_num(T,N1), len(T,L), N is N1 + H * 10^L, !.
l_digi_to_l_num([],[]).
l_digi_to_l_num([H|T],R) :- digi_to_num(H,R1), l_digi_to_l_num(T,R2),
			    append([R1],R2,R), !.

abs_list([],[],[]).
abs_list([H1|T1],[H2|T2],R) :- R1 is abs(H1-H2), abs_list(T1,T2,R2),
	                       append([R1],R2,R), !.

solution(L,X) :- list_to_digits(L,Digi), list_of_minmaxes(Digi,Maxes,Mins),
		 trunc_list(Digi,Maxes,Mins,A,B), l_digi_to_l_num(A,C),
		 l_digi_to_l_num(B,D), abs_list(C,D,E), max(E,F),
		 idx(E,F,G), idx(L,X,G).
