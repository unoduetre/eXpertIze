:- module(interface,[
  line_read/1,
  line_written/1,
  answer_for_question/2,
  show_list/1
  ]).
:- use_module(loader).

:- load_files_from_the_directory('interface').

