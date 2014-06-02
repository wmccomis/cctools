include(manual.h)dnl
HEADER(deltadb_collect)

SECTION(NAME)
BOLD(deltadb_collect) - command line tool that returns data generated by the catalog server during a specified time period.

SECTION(SYNOPSIS)
CODE(BOLD(deltadb_collect [source_directory] [starting_point] [ending_point_or_duration]))

SECTION(DESCRIPTION)

BOLD(deltadb_collect) is a tool that returns a log of changes that were applied to the catalog server data during a specified period of time. The results start with the state of each object at the start of the time period represented as changes in the first timestamp of the results. Datetimes are interpreted as local time. It is a part of DeltaDB (described below).

BOLD(deltadb) (prefix 'deltadb_') is a collection of tools designed to operate on data in the format stored by the catalog server (a log of object changes over time). They are designed to be piped together to perform customizable queries on the data. A paper entitled DeltaDB describes the operation of the tools in detail (see reference below).

SECTION(ARGUMENTS)
OPTIONS_BEGIN
OPTION_ITEM(` source_directory') Expects a directory containing the source data sorted into sub-directories based on year.
OPTION_ITEM(` starting_point') Expects the start time to be a timestamp, date and time, or simply date in the format YYYY-MM-DD[-HH-MM-SS].
OPTION_ITEM(` ending_point_or_duration') Expects a timestamp, duration, or date and time of the same format YYYY-MM-DD-HH-MM-SS. The duration can be in seconds (+180 or s180), minutes (m45), hours (h8), days (d16), weeks (w3), or years (y2).
OPTIONS_END

SECTION(EXAMPLES)

To show 1 week worth of history starting on 15 April 2013:

LONGCODE_BEGIN
% deltadb_collect /data/catalog.history 2013-04-15-01-01-01 w1
LONGCODE_END

To show all history after 1 March 2013:

LONGCODE_BEGIN
% deltadb_collect /data/catalog.history 2013-03-01-01-01
LONGCODE_END

To see full results using a chain of multiple deltadb tools:

LONGCODE_BEGIN
% deltadb_collect /data/catalog.history 2013-02-1@00:00:00 d7 | \\
% deltadb_select_static  type=wq_master | \\
% deltadb_reduce_temporal m15 workers,MAX task_running,MAX tasks_running,MAX | \\
% deltadb_reduce_spatial name,CNT workers.MAX,SUM task_running.MAX,SUM tasks_running.MAX,SUM | \\
% deltadb_pivot name.CNT workers.MAX.SUM task_running.MAX.SUM tasks_running.MAX.SUM
LONGCODE_END


SECTION(COPYRIGHT)

COPYRIGHT_BOILERPLATE

SECTION(SEE ALSO)

LIST_BEGIN
LIST_ITEM LINK(The Cooperative Computing Tools,"http://www.nd.edu/~ccl/software/manuals")
LIST_ITEM LINK(DeltaDB User's Manual,"http://www.nd.edu/~ccl/software/manuals/deltadb.html")
LIST_ITEM LINK(DeltaDB paper,"http://www.nd.edu/~ccl/research/papers/pivie-deltadb-2014.pdf")
LIST_ITEM MANPAGE(deltadb_select_static,1)
LIST_ITEM MANPAGE(deltadb_select_dynamic,1)
LIST_ITEM MANPAGE(deltadb_select_complete,1)
LIST_ITEM MANPAGE(deltadb_project,1)
LIST_ITEM MANPAGE(deltadb_reduce_temporal,1)
LIST_ITEM MANPAGE(deltadb_reduce_spatial,1)
LIST_ITEM MANPAGE(deltadb_pivot,1)
LIST_END

FOOTER

