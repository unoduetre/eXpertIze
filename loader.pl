:- module(loader,[
  load_files_from_the_directory/1,
  allow_multifile_predicates_for_the_directory/1,
  activate_objects_in/1,
  level_of_lack_of_possibility_influence/1
  ]).
:- module_transparent 
  load_files_from_the_directory/1,
  load_files_from_the_list/1,
  allow_multifile_predicates_for_the_directory/1,
  allow_multifile_for/1,
  activate_objects_in/1,
  activate_objects_from_files/1,
  level_of_lack_of_possibility_influence/1.

list_of_prolog_files_in_a_directory(Files,Directory) :-
  atom_concat(Directory,'/*.pl',Wildcard),
  expand_file_name(Wildcard,Files).

load_files_from_the_directory(Directory) :- 
  list_of_prolog_files_in_a_directory(Files,Directory),
  load_files_from_the_list(Files).

load_files_from_the_list([]).
load_files_from_the_list([Head|Tail]) :- 
  ensure_loaded(Head),
  load_files_from_the_list(Tail).

allow_multifile_predicates_for_the_directory(Directory) :-
  list_of_prolog_files_in_a_directory(Files,Directory),
  allow_multifile_for(Files).

allow_multifile_for([]).
allow_multifile_for([Path|Paths]) :-
  file_base_name(Path,File),
  file_name_extension(Base,_,File),
  file_name_extension(URelation,SArity,Base),
  downcase_atom(URelation,Relation),
  atom_number(SArity,Arity),
  multifile(Relation/Arity),
  allow_multifile_for(Paths).

activate_objects_in(Directory) :-
  list_of_prolog_files_in_a_directory(Files,Directory),
  activate_objects_from_files(Files).

activate_objects_from_files([]).
activate_objects_from_files([Path|Paths]) :-
  file_base_name(Path,File),
  file_name_extension(Base,_,File),
  downcase_atom(Base,Object),
  asserta(active(Object)),
  asserta(possibility_for(1,Object)),
  activate_objects_from_files(Paths).

level_of_lack_of_possibility_influence(3).
