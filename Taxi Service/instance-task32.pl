% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------
%
% Write here you matriculation number (only - your name is not needed)
% Matriculation Number: s1509922
%
%
% ------------------------- Problem Instance --------------------------
% This file is a template for a problem instance: the definition of an
% initial state and of a goal. 

% debug(on).	% need additional debug information at runtime?



% --- Load domain definitions from an external file -------------------

:- ['domain-task32.pl'].		% Replace with the domain for this problem




% --- Definition of the initial state ---------------------------------


passage(a,g).
passage(g,h).
passage(h,f).
passage(f,e).
passage(e,f).
passage(f,c).
passage(c,b).
passage(b,a).
passage(h,d).
passage(d,b).
passage(a,b).
passage(b,c).
passage(h,g).
passage(d,h).


% There are 2 taxies in the garage.
% Instead of adding new conditions in the domain in order
% to point which taxies are working and should be concidered,
% a working taxi will be one which is either parked somewhere,
% or currently AT some place.

% Taxi Station (Garage) with 2 cars
taxi(taxi1).
taxi(taxi2).

% Two taxies are working (parked at A)
parkedtaxi(taxi1,a,s0).
parkedtaxi(taxi2,a,s0).

passenger(p1).
at(p1,a,s0).
reqdest(p1,h).

passenger(p2).
at(p2,h,s0).
reqdest(p2,f).

dependent(p1,p2,s0).

% When 2 taxies at parking it takes 13 steps:
% dispatch(t1),move(t1),move(t1),pickup(t1,p2),move(t1),drop(p2),transport(p2),
% dispatch(t2),pickup(t2,p1),move(t2),mobe(t2),drop(p1),transport(p1).
% which takes a moderate compile time to find.

% If we exchange primitive_action(dispatch) in domain to be the first then the plan will be
% slithly different (3rd action will be dispatch(t2)) and finding the plan is a bit faster.

% If second taxi is not working (parkedtaxi(taxi2,a,s0) commented) 
% then the problem is done with only taxi1 in 15 steps, faster in compilation time than 2 taxies.






% --- Goal condition that the planner will try to reach ---------------

goal(S) :- arrived(p1,S),arrived(p2,S).	% fill in the goal definition
%goal(S) :- full(taxi1,S).
%goal(S) :- at(taxi1,b,S).
%goal(S) :- arrived(p2,S).




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
