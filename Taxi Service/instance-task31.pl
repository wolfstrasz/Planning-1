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

:- ['domain-task31.pl'].		% Replace with the domain for this problem




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


taxi(taxi1).
parkedtaxi(taxi1,a,s0). % Plan steps 19; Time: 2 min (worst case 10 tests)
% at(taxi1,a,s0). 	% Plan steps 18; Time: 1 min 45 secs (worst case 10 tests)

% tested on flip screen at FH 3 D.01
% exchange the parkedtaxi(taxi1,a,s0) with at(taxi1,a,s0) to make the shorter
% there are also smaller goals for testing.

passenger(p1).
at(p1,g,s0).
reqdest(p1,d).

passenger(p2).
at(p2,h,s0).
reqdest(p2,e).

passenger(p3).
at(p3,c,s0).
reqdest(p3,b).



% !!!!!!!!!!!!!!!%
% Plan is in 19 STEPS.
% Dispatch,Move,Pickup,Move,Move,Drop,Transport
% Move,Pickup,Move,Move,Drop,Transport
% Move,Move,Pickup,Move,Drop,Transport



% --- Goal condition that the planner will try to reach ---------------

goal(S) :- arrived(p1,S),arrived(p2,S),arrived(p3,S).
%goal(S) :- full(taxi1,S).
%goal(S) :- at(taxi1,b,S).
%goal(S) :- arrived(p1,S),arrived(p2,S).					% fill in the goal definition




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
