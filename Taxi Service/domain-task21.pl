% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------
%
% Write here you matriculation number (only - your name is not needed)
% Matriculation Number: s1509922
%
%
% ------------------------- Domain Definition -------------------------
% This file describes a planning domain: a set of predicates and
% fluents that describe the state of the system, a set of actions and
% the axioms related to them. More than one problem can use the same
% domain definition, and therefore include this file


% --- Cross-file definitions ------------------------------------------
% marks the predicates whose definition is spread across two or more
% files.


:-multifile at/3, holding/2, arrived/2, passage/2, reqdest/2, taxi/1, passenger/1.

% --- Primitive control actions ---------------------------------------
% this section defines the name and the number of parameters of the
% actions available to the planner
%
% primitive_action( dosomething(_,_) ).



primitive_action( pickup(_)).
primitive_action( drop(_)).
primitive_action( transport(_)).
primitive_action( move(_,_)).



% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%
% poss( doSomething(...), S ) :- preconditions(..., S).


% PickUp
poss(pickup(Obj),S) :-
	at(agent,Loc,S),
	taxi(agent),
	at(Obj,Loc,S),
	passenger(Obj),
	not(arrived(Obj,S)).


% Move
poss(move(From,To),S) :-
	at(agent,From,S),
	taxi(agent),
	passage(From,To).

% Drop
poss(drop(Obj),S):-
	at(agent,Loc,S),
	taxi(agent),
	passenger(Obj),
	reqdest(Obj,Loc),
	holding(Obj,S).

% Transport
poss(transport(Obj),S):-
	passenger(Obj),
	reqdest(Obj,Loc),
	at(Obj,Loc,S),
	at(agent,Loc,S),
	taxi(agent).




% --- Successor state axioms ------------------------------------------
% describe the value of fluent based on the previous situation and the
% action chosen for the plan. 
%
% fluent(..., result(A,S)) :- positive; previous-state, not(negative)

% SS-axiom for At
at(Obj,Loc,result(A,S)):-
	(
	taxi(Obj),
		(
		(A=move(_,Loc));
		(at(Obj,Loc,S),not(A=move(_,_)))
		)
	);
	(
	passenger(Obj),
		(
		(A=drop(Obj),reqdest(Obj,Loc));
		(at(Obj,Loc,S),not(A=pickup(Obj)))
		)
	).


% SS-axiom for Holding
holding(Obj,result(A,S)):-
	(
	(A=pickup(Obj));
	(holding(Obj,S),not(A=drop(Obj)))
	).

% SS-axiom for Arrived
arrived(Obj,result(A,S)):-
	(
	passenger(Obj),
		(
		(reqdest(Obj,Loc),at(Obj,Loc,S),A=transport(Obj));
		(arrived(Obj,S))
		)
	).


















% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
