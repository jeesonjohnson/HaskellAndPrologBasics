% Distance represents the raw distance, in a bi nature fastion of the given nodes
% The distances of all nodes respective to c1.
% distance(c1,c2,4).
% % distance(c2,c1,4).
% distance(c3,c1,10).
% % distance(c1,c3,10).
% distance(c1,c5,2).
% % distance(c5,c1,2).
% % The distances of all nodes respective to c2.
% distance(c2,c6,1).
% % distance(c6,c2,1).
% distance(c2,c4,6).
% % distance(c4,c2,6).
% distance(c2,c5,1).
% % distance(c5,c2,1).
% % The distances of all nodes respective to c3
% distance(c4,c3,1).
% % distance(c3,c4,1).
% distance(c3,c5,2).
% % distance(c5,c3,2).
% % Distances of all nodes respective to c4
% distance(c4,c5,8).
% % distance(c5,c4,8).



Currently Working solution, no bidirection.
oh(0, 1, 1).
oh(1, 2, 3).
oh(3, 1, 3).
oh(2, 3, 3).
oh(4, 5, 3).


path([B | Rest], B, [B | Rest], Length, Length).
path([A | Rest], B, Path, CurrentLength, Length) :-
    oh(A, C, X),
    \+member(C, [A | Rest]),
    NewLength is CurrentLength + X,
    path([C, A | Rest], B, Path, NewLength, Length).

find_paths(A, B) :-
    path([A], B, Path, 0, Length),
    reverse(Path, DirectPath),
    printPath(DirectPath),
    writef(' with evaluation %d\n', [Length]),
    fail.

printPath([]).
printPath([X]) :-
    !, write(X).
printPath([X|T]) :-
    write(X),
    write(', '),
    printPath(T).
