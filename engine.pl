:- module(engine,[
  main_loop/0
  ]).
:- use_module(loader).
:- use_module(database).
:- use_module(interface).

:- dynamic(has_the_attribute/2).
:- dynamic(doesnt_have_the_attribute/2).
:- dynamic(active/1).

:- activate_objects_in('database/objects').
:- load_files_from_the_directory('engine').
