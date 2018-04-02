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

:- ['domain-task21.pl'].		% Replace with the domain for this problem




% --- Definition of the initial state ---------------------------------

% Map:
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

% Taxi:
taxi(agent).
at(agent,a,s0).

% Passenger:
passenger(p).
at(p,a,s0).
reqdest(p,h).




% --- Goal condition that the planner will try to reach ---------------

goal(S) :- arrived(p,S).					% fill in the goal definition




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
