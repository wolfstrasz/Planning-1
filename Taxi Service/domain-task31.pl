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


:-multifile at/3, holding/2, parkedtaxi/3, full/2, arrived/2, passage/2, reqdest/2, taxi/1, passenger/1.

% --- Primitive control actions ---------------------------------------
% this section defines the name and the number of parameters of the
% actions available to the planner
%
% primitive_action( dosomething(_,_) ).



% The domain for task 31 will accommodate use of the agent as a dispatcher,
% who will dispatch the only taxi in the taxi parking that is at location A.
% Resulting in the plan being 19 steps long and taking longer time.

% As our agent is not the taxi and we may have more, each action will have 1 more
% argument preceding the others that will specify which taxi is doing the action.

% We wil have action=dispatch to dispatch our only taxi.
% Currently we do not need the agent to be able to park taxies.

primitive_action( dispatch(_)).    % Dispatches a parked taxi.
primitive_action( pickup(_,_)).    
primitive_action( drop(_,_)).      
primitive_action( transport(_,_)). 
primitive_action( move(_,_,_)).    



% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%
% poss( doSomething(...), S ) :- preconditions(..., S).

% Dispatch
poss(dispatch(Obj),S) :-
parkedtaxi(Obj,Loc,S).

% PickUp
poss(pickup(TaxiObj,Obj),S) :-
at(TaxiObj,Loc,S),
taxi(TaxiObj),
not(full(TaxiObj,S)),
at(Obj,Loc,S),
passenger(Obj),
not(arrived(Obj,S)).


% Move
poss(move(Obj,From,To),S) :-
taxi(Obj),
not(parkedtaxi(Obj,From,S)), % This is not needed as a taxi that is parked is not considered AT any position
at(Obj,From,S),
passage(From,To).

% Drop
poss(drop(TaxiObj,Obj),S):-
at(TaxiObj,Loc,S),
taxi(TaxiObj),
passenger(Obj),
reqdest(Obj,Loc),
holding(TaxiObj,Obj,S).

% Transport
poss(transport(TaxiObj,Obj),S):-
passenger(Obj),
reqdest(Obj,Loc),
at(Obj,Loc,S),
at(TaxiObj,Loc,S),
taxi(TaxiObj).




% --- Successor state axioms ------------------------------------------
% describe the value of fluent based on the previous situation and the
% action chosen for the plan. 
%
% fluent(..., result(A,S)) :- positive; previous-state, not(negative)


% We will be including 2 more SS-axioms {Full,ParkedTaxi}
% SS-axiom for At
at(Obj,Loc,result(A,S)):-
	(
	taxi(Obj),
		(
		(A=move(Obj,_,Loc));
		(at(Obj,Loc,S),not(A=move(Obj,_,_)));
		(A=dispatch(Obj),parkedtaxi(Obj,Loc,S))
		)
	);
	(
	passenger(Obj),
		(
		(A=drop(_,Obj),reqdest(Obj,Loc));
		(at(Obj,Loc,S),not(A=pickup(_,Obj)))
		)
	).


% SS-axiom for Holding
holding(TaxiObj,Obj,result(A,S)):-
	(
	(A=pickup(TaxiObj,Obj));
	(holding(TaxiObj,Obj,S),not(A=drop(TaxiObj,Obj)))
	).

% SS-axiom for Arrived
arrived(Obj,result(A,S)):-
	(
	passenger(Obj),
		(
		(reqdest(Obj,To),at(Obj,To,S),A=transport(_,Obj));
		(arrived(Obj,S))
		)
	).

% SS-axiom for Full -> describes which taxi is with passenger
full(Obj,result(A,S)):-
	(
	taxi(Obj),
		(
		(A=pickup(Obj,_));
		(full(Obj,S),not(A=drop(Obj,_)))
		)
	).

% SS-axiom for ParkedTaxi -> describes which taxi is parked.
parkedtaxi(Obj,Loc,result(A,S)):-
	parkedtaxi(Obj,Loc,S),not(A=dispatch(Obj)).














% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
