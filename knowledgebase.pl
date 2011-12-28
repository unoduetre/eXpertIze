:- module(knowledgebase,[question_about/2,possibility_reduction/2,possibility_for/2]).
:- use_module(loader).

:- dynamic(question_about/2).
:- dynamic(possibility_for/2).
:- multifile(question_about/2).
:- multifile(possibility_reduction/2).
:- multifile(possibility_for/2).

:- allow_multifile_predicates_for_the_directory('knowledgebase/relationships').
:- load_files_from_the_directory('knowledgebase/relationships').
:- load_files_from_the_directory('knowledgebase/objects').


