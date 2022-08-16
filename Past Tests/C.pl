number_to_list(0,[]).
number_to_list(N,L) :- Nmod10 is N mod 10, Ndiv10 is N div 10,
	append(L1,[Nmod10],L), number_to_list(Ndiv10,L1), !.
test1(X) :- number_to_list(2137,X).

del(X,[X|T],T).
del(X,[H1,H2|T1],[H1|T2]) :- del(X,[H2|T1],T2).
test2(X) :- del(2,[1,2,3,4,5],X).


list_of_lists([],[]).
list_of_lists([H|T],[Hl|Tl]) :- number_to_list(H,Hl), list_of_lists(T,Tl).
test3(X) :- list_of_lists([12,13,24,231],X).

convert(_,[],[]).
convert(N,List,Res) :- del(N,List,L1), list_of_lists(L1,Res).
test4(X) :- convert(2137,[22,4434,343,2137,42],X).

single_list([],[]).
single_list([[H]|T1],[H|T2]) :- single_list(T1,T2), !.
single_list([[H|T1]|T2],[H|T3]) :- single_list([T1|T2],T3), !.
test5(X) :- single_list([[1,2,3],[4,5,6]],X).

count([],_,N) :- N is 0.
count([X|T],X,N1) :- count(T,X,N), N1 is N+1, !.
count([_|T],X,N) :- count(T,X,N).

repetition([],_,[]).
repetition([H1|T1],L,[N|Tres]) :- count(L,H1,N), repetition(T1,L,Tres), !.
test6(X) :- repetition([2,7,1],[5,1,2,3,1,6,7,1,4,6,2,8,3,1,2,0],X).

sum_list([],Res) :- Res is 0.
sum_list([H|T],Res1) :- sum_list(T,Res), Res1 is Res + H.
len_list([],X) :- X is 0.
len_list([_|T],X) :- len_list(T,Y), X is Y + 1.

avg(L,Res) :- sum_list(L,Sum), len_list(L,Len), Res is Sum / Len.
test7(X) :- avg([1,2,3,4,5],X).

min_in_list([X],X).
min_in_list([H|T],X) :- min_in_list(T,X), H > X, !.
min_in_list([H|_],H).
test8(X) :- min_in_list([3,2,6,4,65,3,4,1,5,4],X).

convert_all([],_,[]).
convert_all([H|T],L,[Res|T1]) :- convert(H,L,Res), convert_all(T,L,T1).
test9(X) :- convert_all([271,5123,167],[271,5123,167],X).

single([],[]).
single([H|T],[Hres|Tres]) :- single_list(H,Hres), single(T,Tres).

nums_digi([],[]).
nums_digi([H|T],[Res|Tres]) :- number_to_list(H,Res), nums_digi(T,Tres).

repets([],[],[]).
repets([H1|T1],[H2|T2],[Hres|Tres]) :- repetition(H1,H2,Hres), repets(T1,T2,Tres).

average([],[]).
average([H1|T1],[Hres|Tres]) :- avg(H1,Hres), average(T1,Tres).

pos_in_list([X|_],X,Pos) :- Pos is 0.
pos_in_list([_|T],X,Pos) :- pos_in_list(T,X,Pos1), Pos is Pos1 + 1, !.

final_element([Res|_],0,Res).
final_element([_|T],Pos,Res) :- Pos1 is Pos - 1, final_element(T,Pos1,Res).

solution(L,X) :- convert_all(L,L,ResConv), single(ResConv,ResSingle),
	nums_digi(L,Digi), repets(Digi,ResSingle,Counted),
	average(Counted,AvgList), min_in_list(AvgList,Min),
	pos_in_list(AvgList,Min,Pos), final_element(L,Pos,X).
