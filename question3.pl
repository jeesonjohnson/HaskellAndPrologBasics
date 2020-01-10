%-----------------------------------------------------------------------------------------
% Question 3.1
%-----------------------------------------------------------------------------------------
%##########################################################################################
% Question 3.1.a
%  Defining translation facts.
%##########################################################################################
%"My name is Jeeson and i love computers. i also love a good chocolate cheescake.""
%The above phrase should be completly convertable
english_french(mad,fou).
english_french(my,ma).
english_french(name,nom).
english_french(is,est).
english_french(and,et).
english_french(i,je).
english_french(love,lamour).
english_french(computers,ordinateurs).
english_french(also,aussi).
english_french(good,bein).
english_french(chocolate,chocolat).
english_french(Undefined,Undefined).
%##########################################################################################
% Question 3.1.b
%  Method for translate between french and english
%##########################################################################################
trans([],Answer,Answer).
trans([WordHead|WordTail],[Main|MainTail],Answer):-
                                   english_french(WordHead,FrenchWord),
                                   trans(WordTail,[FrenchWord,Main|MainTail],Answer).


translate_eng([TransHead|TransTail],[Translated]):-english_french(TransHead,FirstFrenchWord),
                                                 trans(TransTail,[FirstFrenchWord],TransaltedArray),
                                                 reverse(TransaltedArray,ReversedArr),
                                                 atomic_list_concat(ReversedArr,' ',Translated).

%-----------------------------------------------------------------------------------------
% Question 3.2
%-----------------------------------------------------------------------------------------
%##########################################################################################
% Question 3.2.a
%##########################################################################################
% Distance represents the raw distance, in a bi nature fastion of the given nodes
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



%##########################################################################################
% Question 3.2.b
%##########################################################################################
% The bidirectional nature of the graph was fixed, by implmenting a reverse perdicate, that
% represents the opposite direction.
% For example to make c1 to c2 bidirectional, we first define distance(c1,c2,4) and then
% distance(c2,c1,4). But to ensure the below predicates do not become stuck in a loop, we
% need to ensrue that a previously visted node is not met again by the alargorithm.



%##########################################################################################
% Question 3.2.c
%##########################################################################################
path(Start,End,[End|GenTail],[End|GenTail]):-
                          %Check that the last element in list, is the final answer we were looking for.
                          member(Start,[End|GenTail]).
path(Start,End,[GenHead|GenTail],Answer):-
                          distance(Start,SecondStep,_),
                          \+member(SecondStep,[GenHead|GenTail]), % Ensures no loops.
                          path(SecondStep,End,[SecondStep,GenHead|GenTail],Answer).

% ######### Main Function ###############
% Returns to the user the all paths, in an appropriate order.
find_paths(Start,End,Answer):-
                   path(Start,End,[Start],GenAnswer),
                   reverse(GenAnswer,ReversedAnswer),
                   Answer = ReversedAnswer.



%##########################################################################################
% Question 3.2.d
%##########################################################################################
head([H|_], H). %Finds the top element of a list
head((Length,Route),Length,Route). % Sperates the first element of a tuple into 2 elements.

% Generates all paths, along with thier associated lengths, using recursion.
path_gen(Start,End,[End|GenTail],[End|GenTail],Length,Length):-
                                    member(Start,[End|GenTail]).
path_gen(Start,End,[GenHead|GenTail],Answer,OrignalLength,Length):-
                                    distance(Start,SecondStep,GeneratedDistance),
                                    \+member(SecondStep,[GenHead|GenTail]),
                                    TotalDistance is OrignalLength+GeneratedDistance, %Evalutes total path distance
                                    path_gen(SecondStep,End,[SecondStep,GenHead|GenTail],Answer,TotalDistance,Length).

% Finds the appropraite length of each path.
find_paths_length(Start,End,Answer,Length):- path_gen(Start,End,[Start],GenAnswer,0,Length),
                               reverse(GenAnswer,ReversedAnswer),
                               Answer = ReversedAnswer.

% Generates an overall list with the associated lengths and routes.
combine_paths(Start,End,Generated):-
                  findall((Length,Answer),find_paths_length(Start,End,Answer,Length),Generated).

% ######### Main Function ###############
% Appropriatly formates the shortes path output to the user.
shortest_path(Start,End):-
        combine_paths(Start,End,Generated),
        sort(Generated,SortedSolution),
        head(SortedSolution,FirstElement),
        head(FirstElement,Length,Route),
        writef(' The route: %d is shortest with with length: %d', [Route,Length]).


%-----------------------------------------------------------------------------------------
% Question 3.3
%-----------------------------------------------------------------------------------------
%##########################################################################################
% Question 3.3.a
%##########################################################################################
% Defining nationality by house colour.
nationality_house(french,black).
nationality_house(japanese,blue).
nationality_house(spanish,brown).

% Defining pets by nationality
nationality_pet(french,snail).
% nationality_pet(japanese,UNKNOWN). This fact is not known. AS WE CANT MAKE ASSUMPTION ABOUT PET OF japanese HOUSE/
nationality_pet(spanish,jaguar).

% defining house location, with respect ot LEFT OF.
left_house(japanese,french).
left_house(spanish,japanese).
% defining house location, with respect ot RIGHT OF.
left_house(french,japanese).
left_house(japanese,spanish).


%##########################################################################################
% Question 3.3.b
%##########################################################################################
% NOT SURE IF THIS SIMPLE PREDICATE IS ENOUGH FOR 4 MARKS, BUT THIS SOLVES THE QUESTION?
nationality_of_pet_owner(Pet,Nationality):-nationality_pet(Nationality,Pet).
rabbits(X):-nationality_of_pet(rabbits,X).























% https://stackoverflow.com/questions/4716245/solving-logic-puzzle-in-prolog
neigh(Left, Right, List) :-
        List = [Left | [Right | _]];
        List = [_ | [Left | [Right]]].

zebraowner(Houses, ZebraOwner):-
        member([englishman, _, red], Houses),
        member([spanish, jaguar, _], Houses),
        neigh([_, snail, _], [japanese, _, _], Houses),
        neigh([_, snail, _], [_, _, blue], Houses),
        member([ZebraOwner, zebra, _], Houses),
        member([_, _, green], Houses).


zebra(X) :- zebraowner([_, _, _], X).
