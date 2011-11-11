main_loop :- one_step, main_loop.
%TODO
main_loop :- 
  bagof(Attribute,has_the_attribute(object_in_mind,Attribute),L),
  print(L),
  nl,
  halt.

one_step :- new_information.

