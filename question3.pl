% Distance represents the raw distance, in a bi nature fastion of the given nodes
node(c1).
node(c2).
node(c3).
node(c4).
node(c5).
node(c6).


% The distances of all nodes respective to c1.
distance(c1,c2,4).
distance(c2,c1,4).
distance(c3,c1,10).
distance(c1,c3,10).
distance(c1,c5,2).
distance(c5,c1,2).
% The distances of all nodes respective to c2.
distance(c2,c6,1).
distance(c6,c2,1).
distance(c2,c4,6).
distance(c4,c2,6).
distance(c2,c5,1).
distance(c5,c2,1).
% The distances of all nodes respective to c3
distance(c4,c3,1).
distance(c3,c4,1).
distance(c3,c5,2).
distance(c5,c3,2).
% Distances of all nodes respective to c4
distance(c4,c5,8).
distance(c5,c4,8).
%
% all_paths(_,End,[End|_]).
% all_paths(Start,End,Generated):-distances(Start,SecondPoint,_),
%                                 \+(member(SecondPoint,Generated)),
%                                 append(SecondPoint,Generated),
%                                 all_paths(SecondPoint,End,Generated).

% routing(FromCity,FromCity,[FromCity]).
%
% routing(FromCity, ToCity, [FromCity,ToCity]) :-
%   distance(FromCity, ToCity,_).
%
% routing(FromCity, ToCity, [FromCity|Connections]) :-
%   distance(FromCity, ToConnection,_),
%   routing(ToConnection, ToCity, Connections).


% paths(Start,Start,_,[Start]):-distance(Start,_,_). % Prevent Cycles
% paths(_,End,[End|GenTail],[End|GenTail]). %Check that the last element in list, is the final answer we were looking for.
% paths(Start,End,[GenHead|GenTail],Answer):-distance(Start,SecondStep,_),
%                                     \+member(SecondStep,[GenHead|GenTail]),
%                                     paths(SecondStep,End,[SecondStep,GenHead|GenTail],Answer).

% Question 3.2.c Solution!
path(Start,End,[End|GenTail],[End|GenTail]):-member(Start,[End|GenTail]). %Check that the last element in list, is the final answer we were looking for.
path(Start,End,[GenHead|GenTail],Answer):-distance(Start,SecondStep,_),
                                    \+member(SecondStep,[GenHead|GenTail]),
                                    path(SecondStep,End,[SecondStep,GenHead|GenTail],Answer).


find_paths(Start,End,Answer):- path(Start,End,[Start],GenAnswer),
                               reverse(GenAnswer,ReversedAnswer),
                               Answer = ReversedAnswer.

% Question 3.2.b Solution!
path_gen(Start,End,[End|GenTail],[End|GenTail],Length,Length):-member(Start,[End|GenTail]). %Check that the last element in list, is the final answer we were looking for.
path_gen(Start,End,[GenHead|GenTail],Answer,OrignalLength,Length):-distance(Start,SecondStep,GeneratedDistance),
                                    \+member(SecondStep,[GenHead|GenTail]),
                                    TotalDistance is OrignalLength+GeneratedDistance,
                                    path_gen(SecondStep,End,[SecondStep,GenHead|GenTail],Answer,TotalDistance,Length).


find_paths_length(Start,End,Answer,Length):- path_gen(Start,End,[Start],GenAnswer,0,Length),
                               reverse(GenAnswer,ReversedAnswer),
                               Answer = ReversedAnswer.

%
% % Currently Working solution, no bidirection.
% oh(1, 2, 1).
% oh(2, 6, 3).
% oh(2, 4, 3).
% oh(4, 5, 3).
% oh(5, 1, 3).
%
% % oh(4, 5, 3).
%
%
% path([B | Rest], B, [B | Rest], Length, Length).
% path([A | Rest], B, Path, CurrentLength, Length) :-
%     oh(A, C, X),
%     \+member(C, [A | Rest]),
%     NewLength is CurrentLength + X,
%     path([C, A | Rest], B, Path, NewLength, Length).
%
% find_paths(A, B) :-
%     path([A], B, Path, 0, Length),
%     reverse(Path, DirectPath),
%     printPath(DirectPath),
%     writef(' with evaluation %d\n', [Length]),
%     fail.
%
% printPath([]).
% printPath([X]) :-
%     !, write(X).
% printPath([X|T]) :-
%     write(X),
%     write(', '),
%     printPath(T).
%
%
%







































% % Currently Working solution, no bidirection.
% oh(0, 1, 1).
% oh(1, 2, 3).
% oh(3, 1, 3).
% oh(2, 3, 3).
% oh(4, 5, 3).
%
%
% path([B | Rest], B, [B | Rest], Length, Length).
% path([A | Rest], B, Path, CurrentLength, Length) :-
%     oh(A, C, X),
%     \+member(C, [A | Rest]),
%     NewLength is CurrentLength + X,
%     path([C, A | Rest], B, Path, NewLength, Length).
%
% find_paths(A, B) :-
%     path([A], B, Path, 0, Length),
%     reverse(Path, DirectPath),
%     printPath(DirectPath),
%     writef(' with evaluation %d\n', [Length]),
%     fail.
%
% printPath([]).
% printPath([X]) :-
%     !, write(X).
% printPath([X|T]) :-
%     write(X),
%     write(', '),
%     printPath(T).



% Question 3 part 2
