new_information :- 
  best_attribute(X),
  answer_about(Y,X),
  is_remembered_for(Y,X).

best_attribute(X) :- list_of_best_attributes(Y), chosen_from(X,Y).

answer_about(Y,X) :- question_about(Z,X), answer_for_question(Y,Z).

is_remembered_for(false,X) :- 
  retract(question_about(_,X)),
  assertz(doesnt_have_the_attribute(object_in_mind,X)).

is_remembered_for(true,X) :- 
  retract(question_about(_,X)),
  assertz(has_the_attribute(object_in_mind,X)).

list_of_best_attributes(Y) :- 
  list_of_unknown_attributes(A),
  list_of_priorities_of(P,A),
  min_list(P,Min),
  attributes_with_priority(Y,Min,A,P).

chosen_from(X,Y) :- 
  length(Y,Z),
  Zs is Z+1,
  random(1,Zs,R),
  nth1(R,Y,X).

list_of_unknown_attributes(L) :-
  bagof(A,Q^question_about(Q,A),L).

list_of_priorities_of([],[]).
list_of_priorities_of([H1|T1],[H2|T2]) :-
  priority_of(H1,H2),
  list_of_priorities_of(T1,T2).

attributes_with_priority(Attr,N,A,P) :-
  attributes_with_priority(Attr,N,A,P,[]),!.

priority_of(P,A) :-
  setof(O,attribute_is_defined_for_the_active_object(A,O),L),
  length(L,Q),
  number_of_active_objects(N),
  P is abs(rdiv(N,2)-Q).

attributes_with_priority(Attr,_,[],[],Attr).
attributes_with_priority(Attr,N,[H1|R1],[N|R2],T) :-
  attributes_with_priority(Attr,N,R1,R2,[H1|T]).
attributes_with_priority(Attr,N,[_|R1],[_|R2],T) :-
  attributes_with_priority(Attr,N,R1,R2,T).

attribute_is_defined_for_the_active_object(A,B) :-
  active(B),
  attribute_is_defined_for(A,B).

number_of_active_objects(N) :-
  bagof(O,active(O),L),
  length(L,N).

attribute_is_defined_for(A,B) :-
  F =.. [A,B],
  database:F,!.

%attributes_nearest_to_the_half_of_the_number_of_objects(Y,A,P) :-
%  distances_from_the_halt_of_the_number_of_objects(D,P),
%  min_list(D,Min),
%  attributes_with_distance_from_the_list(Y,Min,A,D).
%
%distances_from_the_halt_of_the_number_of_objects([],[]) :-
%distances_from_the_halt_of_the_number_of_objects([HD|TD],[HP|TP]) :-
%  number_of_active_objects(N),
%  HD is abs(HP-rdev(N,2)),
%  distances_from_the_halt_of_the_number_of_objects(TD,TP).
% A is an unknown attribute if and only if 
% we didn't asked the question about it yet. 
%unknown_attribute(A) :- question_about(_,A).
%
%known_attribute(A) :- \+ unknown_attribute(A).
%
%sum(N,[]) :- N is 0.
%sum(N,[A|B]) :-
%  sum(M,B), N is M + A.
%
%similar_attribute_with_coefficient(Attribute,Object,1) :-
%  has_the_attribute(object_in_mind,Attribute),
%  attribute_is_defined_for(Attribute,Object).
%
%similar_attribute_with_coefficient(Attribute,Object,0) :-
%  has_the_attribute(object_in_mind,Attribute),
%  \+ attribute_is_defined_for(Attribute,Object).
%
%similar_attribute_with_coefficient(Attribute,Object,1) :-
%  doesnt_have_the_attribute(object_in_mind,Attribute),
%  \+ attribute_is_defined_for(Attribute,Object).
%
%similar_attribute_with_coefficient(Attribute,Object,0) :-
%  doesnt_have_the_attribute(object_in_mind,Attribute),
%  attribute_is_defined_for(Attribute,Object).
%
%similar_to_object_in_mind_with_coefficient(A,N) :- 
%  forall(M,similar_attribute_with_coefficient(A,M),L),
%  sum(N,L).
%
%
%% if it's possible to proove the fact about an object in multiple ways the following code is wrong! BUT, JUST USE A CUT EACH TIME IN THE DATABASE!!!
%is_a_number_of_objects_with_the_attribute(M,X) :-
%  findall(Y,attribute_is_defined_for(X,Y),L),
%  length(L,M).
%
%is_a_number_of_objects_with_some_attribute_of_object_in_mind(M) :-
%  has_the_attribute(object_in_mind,X),
%  is_a_number_of_objects_with_an_attribute(M,X).
%
%is_a_number_of_objects_without_some_attribute_of_object_in_mind(M) :-
%  doesnt_have_the_attribute(object_in_mind,X),
%  is_a_number_of_objects_with_an_attribute(N,X),
%  number_of_objects(P),
%  M is P - N.
