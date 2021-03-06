% TestCase: cross_the_river(Moves).
% Solution: [1,1], [0, 1], [0, 3], [0, 2], [2,2], [1,1], [3,1], [3,0], [3,2], [3,1], [3,3].

% Missionary and cannibal 
cross([M, C, _], [New_M, New_C, 'boat on east shore'], Counter):-
  is_even(Counter),
  C < 3,
  M < 3,
  New_C is C + 1,
  New_M is M + 1.

cross([M, C, _], [New_M, New_C, 'boat on west shore'], Counter):-
  \+ is_even(Counter),
  C > 0,
  M > 0,
  New_C is C - 1,
  New_M is M - 1.

% Missionary crosses the river alone
cross([M, C, _], [New_M, C, 'boat on east shore'], Counter):-
  is_even(Counter),
  M < 3,
  New_M is M + 1.

cross([M, C, _], [New_M, C, 'boat on west shore'], Counter):-
  \+ is_even(Counter),
  M > 0,
  New_M is M - 1.

% 2-Missionaries cross the river
cross([M, C, _], [New_M, C, 'boat on east shore'], Counter):-
  is_even(Counter),
  M < 2,
  New_M is M + 2.

cross([M, C, _], [New_M, C, 'boat on west shore'], Counter):-
  \+ is_even(Counter),
  M > 1,
  New_M is M - 2.

%  Cannibal crosses the river alone
cross([M, C, _], [M, New_C, 'boat on east shore'], Counter):-
  is_even(Counter),  
  C < 3,
  New_C is C + 1.

cross([M, C, _], [M, New_C, 'boat on west shore'], Counter):-
  \+ is_even(Counter),
  C > 0,
  New_C is C - 1.

%  Cannibal crosses the river
cross([M, C, _], [M, New_C, 'boat on east shore'], Counter):-
  is_even(Counter),
  C < 2,
  New_C is C + 2.

cross([M, C, _], [M, New_C, 'boat on west shore'], Counter):-
  \+ is_even(Counter),
  C > 1,
  New_C is C - 2.

unsafe([M, C, _]):-
  M \= 3,
  M \= 0,
  M =\= C.

moves([3,3, _], _, Moves, Moves).
moves(CurState, Counter, Visited, Moves):-
  cross(CurState, NewState, Counter),
  \+ unsafe(NewState),
  \+ member(NewState, Visited),
  Counter1 is Counter + 1,
  moves(NewState, Counter1, [NewState|Visited], Moves).

% Reverse a list
reverse_list(L, R) :-  
  reverse_list(L, R, []).
reverse_list([], Temp, Temp) :-
  !.
reverse_list([H|T], R, Temp) :- 
  reverse_list(T, R, [H|Temp]). 

% Check whether the given value is even or not
is_even(N):- 
  mod(N, 2) =:= 0.

cross_the_river(Moves):-
  moves([0, 0, X], 0, [[0, 0, 'boat on west shore']], Reversed_Moves),
  reverse_list(Reversed_Moves, Moves).
