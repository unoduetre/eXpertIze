load_files_from_the_directory(Directory) :- 
  string_concat(Directory,'/*.pl',Wildcard),
  expand_file_name(Wildcard,FileList),
  load_files_from_the_list(FileList).

load_files_from_the_list([]).
load_files_from_the_list([Head|Tail]) :- 
  ensure_loaded(Head),
  load_files_from_the_list(Tail).

:- load_files_from_the_directory('engine').
:- load_files_from_the_directory('interface').
:- load_files_from_the_directory('database/objects').
:- load_files_from_the_directory('database/relationshps').
