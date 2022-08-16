num_to_bin(0,[0]).
num_to_bin(1,[1]).
num_to_bin(N,B) :- N > 0, Nmod2 is mod(N,2), Ndiv2 is div(N,2),
	             num_to_bin(Ndiv2,B1), append(B1,[Nmod2],B), !.

list_to_bin([],[]).
list_to_bin([H|T],Res) :- num_to_bin(H,Hres),
	          list_to_bin(T,L), append([Hres],L,Res), !.
test1(X) :- list_to_bin([19,20,23,33],X).

count([],Ones,Zeros) :- Ones is 0, Zeros is 0.
count([H|T],Ones,Zeros) :- H =:= 1, count(T,Ones1,Zeros), Ones is Ones1 + 1, !.
count([H|T],Ones,Zeros) :- H =:= 0, count(T,Ones,Zeros1), Zeros is Zeros1 + 1, !.

setnumber([],Ones,Zeros) :- Ones is 0, Zeros is 0.
setnumber(L,Ones,Zeros) :- Ones > 0, Ones1 is Ones - 1, setnumber(L1,Ones1,Zeros),
			   append([1],L1,L), !.
setnumber(L,Ones,Zeros) :- Zeros > 0, Zeros1 is Zeros - 1, setnumber(L1,Ones,Zeros1),
			   append([0],L1,L), !.
moveones([],[]).
moveones([H1|T1],Res) :- count(H1,Ones,Zeros), setnumber(Num,Ones,Zeros),
	                 moveones(T1,Res1), append([Num],Res1,Res), !.

equal([],[]).
equal(L1,L2) :- count(L1,Ones,Zeros), Ones =:= Zeros, L2=L1, !.
equal(L1,L2) :- count(L1,Ones,Zeros), Ones > Zeros, append(L1,[0],L3), equal(L3,L2), !.
equal(L1,L2) :- append(L1,[1],L3), equal(L3,L2), !.
equal_lists([],[]).
equal_lists([H1|T1],[H2|T2]) :- equal(H1,H2), equal_lists(T1,T2), !.

len([],N) :- N is 0.
len([_|T],N1) :- len(T,N), N1 is N + 1, !.

bin_to_dec([],_,0).
bin_to_dec([H|T],Len,Res) :- Len1 is Len - 1, bin_to_dec(T,Len1,Res1), Res is Res1 + H * 2^Len, !.

to_dec([],[]).
to_dec([H|T],Res) :- len(H,Len), Len1 is Len - 1, bin_to_dec(H,Len1,Hres),
	             to_dec(T,Res1), append([Hres],Res1,Res), !.

absolute([],[],[]).
absolute([H1|T1],[H2|T2],Res) :- Diff is abs(H1-H2), absolute(T1,T2,Res1), append([Diff],Res1,Res), !.

max([M],M).
max([H|T],M) :- max(T,M), M > H, !.
max([M|_],M).

idx(X,[X|_],0).
idx(X,[_|T],Idx) :-  idx(X,T,Idx1), Idx is Idx1 + 1.

solution(X,L) :- list_to_bin(L,BinList), moveones(BinList,Moved),
	       equal_lists(Moved,Bins), to_dec(Bins,Dec), absolute(Dec,L,Abs), max(Abs,Max),
	       idx(Max,Abs,Idx), idx(X,L,Idx).
