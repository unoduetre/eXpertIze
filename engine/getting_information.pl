new_information :- 
  best_attribute(X),
  answer_about(Y,X),
  is_remembered_for(Y,X).

best_attribute(X) :- list_of_best_attributes(Y), chosen_from(X,Y).

answer_about(Y,X) :- question_about(Z,X), answer_for_question(Y,Z).

is_remembered_for(Logical,X) :- 
  retract(question_about(_,X)),
  possibility_changed_for(Logical,X).

list_of_best_attributes(Y) :- 
  list_of_unknown_attributes_with_priorities(A,P),
  min_list(P,Min),
  attributes_with_priority(Y,Min,A,P).

chosen_from(X,Y) :- 
  length(Y,Z),
  Zs is Z+1,
  random(1,Zs,R),
  nth1(R,Y,X).

list_of_unknown_attributes_with_priorities(A,P) :-
  setof(A,Q^question_about(Q,A),L),
  list_of_numbers_of_objects_with_attributes(N,L),
  list_of_relevant_attributes_with_priorities_based_on(A,P,L,N).

list_of_numbers_of_objects_with_attributes([],[]).
list_of_numbers_of_objects_with_attributes([H1|T1],[H2|T2]) :-
  number_of_objects_with_the_attribute(H1,H2),
  list_of_numbers_of_objects_with_attributes(T1,T2).

list_of_relevant_attributes_with_priorities_based_on([],[],[],[]).

list_of_relevant_attributes_with_priorities_based_on(A,P,[X|R1],[Y|R2]) :-
  Y =:= 0,
  retract(question_about(_,X)),
  list_of_relevant_attributes_with_priorities_based_on(A,P,R1,R2).

list_of_relevant_attributes_with_priorities_based_on(A,P,[X|R1],[Y|R2]) :-
  number_of_active_objects(N),
  Y =:= N,
  retract(question_about(_,X)),
  list_of_relevant_attributes_with_priorities_based_on(A,P,R1,R2).

list_of_relevant_attributes_with_priorities_based_on(A,P,[X|R1],[Y|R2]) :-
  possibility_reduction(M,X),
  number_of_active_objects(N),
  possibility_influence(S),
  Y =\= 0,
  Y =\= N,
  Prio is abs(rdiv(N,2)-Y)-S*M,
  A = [X|Rest1],
  P = [Prio|Rest2],
  list_of_relevant_attributes_with_priorities_based_on(Rest1,Rest2,R1,R2).

attributes_with_priority(Attr,N,A,P) :-
  attributes_with_priority(Attr,N,A,P,[]),!.

number_of_objects_with_the_attribute(Q,A) :-
  setof(O,attribute_is_defined_for_the_active_object(A,O),L),
  length(L,Q),
  !.

number_of_objects_with_the_attribute(0,_).

attributes_with_priority(Attr,_,[],[],Attr).
attributes_with_priority(Attr,N,[H1|R1],[N|R2],T) :-
  attributes_with_priority(Attr,N,R1,R2,[H1|T]).
attributes_with_priority(Attr,N,[_|R1],[_|R2],T) :-
  attributes_with_priority(Attr,N,R1,R2,T).

attribute_is_defined_for_the_active_object(A,B) :-
  active(B),
  attribute_is_defined_for(A,B).

attribute_is_undefined_for_the_active_object(A,B) :-
  active(B),
  \+ attribute_is_defined_for(A,B).

number_of_active_objects(N) :-
  setof(O,active(O),L),
  length(L,N).

attribute_is_defined_for(A,B) :-
  F =.. [A,B],
  database:F,
  !.

possibility_changed_for(false,A) :-
  setof(O,attribute_is_defined_for_the_active_object(A,O),L),
  possibility_reduction(R,A),
  possibility_lowered_for_all_in_by(L,R).

possibility_changed_for(true,A) :-
  setof(O,attribute_is_undefined_for_the_active_object(A,O),L),
  possibility_reduction(R,A),
  possibility_lowered_for_all_in_by(L,R).

possibility_lowered_for_all_in_by([],_).
possibility_lowered_for_all_in_by([H|R],P) :-
  possibility_lowered_for_by(H,P),
  possibility_lowered_for_all_in_by(R,P).

possibility_lowered_for_by(O,R) :-
  possibility_for(P,O),
  N is P - R,
  retract(possibility_for(P,O)),
  asserta(possibility_for(N,O)),
  impossible_inactivated(O).

impossible_inactivated(O) :-
  possibility_for(P,O),
  P =< 0,
  retract(active(O)).

impossible_inactivated(O) :-
  possibility_for(P,O),
  P > 0.

