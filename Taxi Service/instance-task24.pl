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

% For this problem we can pick multiple goals in order for the plan to touch
% every location on the map. To make sure the agent travels over all locations
% we need to use the one way streets efficiently. There are 2 circles that can
% be done 1) A->G->H->D->B->A and 2) A->G->H->F->C->B->A
% However our agent will not pass through E, so we need either passenger to be
% at E or ReqDest(passenger,E).
% If ReqDest(passenger,E) and our passenger is on the way to E, the agent does
% not pass through {D,C,B}, however his only escape from E<->F is through C, so
% for his next goal will be for him to reach D, thus traveling through B and C.

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
at(p,e,s0).
reqdest(p,f).




% --- Goal condition that the planner will try to reach ---------------

goal(S) :- arrived(p,S),at(agent,d,S).					% fill in the goal definition




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
