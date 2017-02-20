%%%-------------------------------------------------------------------
%%% @author madalin
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Feb 2017 10:26 PM
%%%-------------------------------------------------------------------
-author("madalin").

-define(EDB_ETS_TAB_KEYSPACES_INFO, 	edb_keyspaces_info).
-define(EDB_ETS_TAB_KEYSPACES_NODES, 	edb_keyspaces_nodes).

-define(EDB_ETS_TAB_QUERIES_CACHE, 		edb_queries_cache).

-define(EDB_CONSISTENCY_ANY_ONE, 			1).
-define(EDB_CONSISTENCY_ANY_TWO, 			2).
-define(EDB_CONSISTENCY_ANY_THREE, 			3).
-define(EDB_CONSISTENCY_ANY_QUORUM, 		4).

-define(EDB_CONSISTENCY_CLOUD_ONE, 			5).
-define(EDB_CONSISTENCY_CLOUD_TWO, 			6).
-define(EDB_CONSISTENCY_CLOUD_THREE, 		7).
-define(EDB_CONSISTENCY_CLOUD_QUORUM, 		8).

-define(EDB_CONSISTENCY_SUPERCLUSTER_ONE, 	9).
-define(EDB_CONSISTENCY_SUPERCLUSTER_TWO, 	10).
-define(EDB_CONSISTENCY_SUPERCLUSTER_THREE, 11).
-define(EDB_CONSISTENCY_SUPERCLUSTER_QUORUM,12).

-define(EDB_CONSISTENCY_ALL_AVAILLABLE, 	13).
-define(EDB_CONSISTENCY_ALL, 				14).

-record(edb_schema_keyspace, {
  name        = undefined :: undefined | binary(),
  nodes       = undefined :: undefined | list()
}).

-record(edb_query, {
  command       = undefined,
  keyspace      = undefined,
  consistency   = ?EDB_CONSISTENCY_ANY_ONE,
  cache         = false :: false | {success, integer()} | {failure, integer()} | {both, integer()},
  from_cache    = false :: false | {success, integer()} | {failure, integer()} | {both, integer()},
  params        = []
}).
