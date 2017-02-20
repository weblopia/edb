%%%-------------------------------------------------------------------
%%% @author madalin
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Feb 2017 3:04 PM
%%%-------------------------------------------------------------------
-module(edb_lib).
-author("madalin").

-include("../include/qedb.hrl").

%% API
-export([query/1]).

-export([result_rows/1]).
-export([result_size/1]).
-export([result_head/1]).
-export([result_tail/1]).

-export([keyspace_exists/1, keyspace_exists/2]).
-export([keyspace_create/2, keyspace_create/3]).
-export([keyspace_alter/2, keyspace_alter/3]).
-export([keyspace_drop/1, keyspace_drop/2]).
-export([keyspace_get_nodes/1, keyspace_get_nodes/2]).
-export([keyspace_get_info/1, keyspace_get_info/2]).

-export([table_exists/1, table_exists/2]).
-export([table_create/2, table_create/3]).
-export([table_alter/2, table_alter/3]).
-export([table_drop/1, table_drop/2]).
-export([table_get_info/1, table_get_info/2]).

-export([insert/1]).
-export([select/1]).
-export([delete/1]).
-export([exists/1]).
-export([count/1]result_rows).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% query
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% @doc Execute the specified query
query(Query = #edb_query{from_cache = UseCache}) ->

  %% Get query nodes (acording to the specified consistency)
  Nodes = query_nodes(Query),

  %% Map query
  case query_map(Nodes, Query) of
    [] -> {error, error};
    QueryMapResult ->

      %% Reduce the query result
      query_reduce(QueryMapResult, Query)

  end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% @doc Returns the rows in the specified query result
result_rows(#qedb_query_result{rows = Rows}) -> Rows.

%% @doc Returns the number of rows in the specified query result
result_size(#qedb_query_result{size = undefined, rows = Data}) -> erlang:length(Data);
result_size(#qedb_query_result{size = Size}) -> Size.

%% @doc Returns the head (the first row) of the specified result rows
result_head(#qedb_query_result{rows = []}) -> empty;
result_head(#qedb_query_result{rows = [H|_]}) -> H.

%% @doc Returns the tail of the specified result rows
result_tail(#qedb_query_result{rows = []}) -> empty;
result_tail(#qedb_query_result{rows = [_|T]}) -> T.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% keyspace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% @doc Keyspace exists
keyspace_exists(Keyspace) -> keyspace_exists(Keyspace, ?EDB_CONSISTENCY_ANY_ONE).

%% @doc Keyspace exists
%% Interogate local node (?QEDB_CONSISTENCY_ANY_ONE)
keyspace_exists(Keyspace, ?EDB_CONSISTENCY_ANY_ONE) -> qedb_lib_schema:keyspace_exists(Keyspace);
keyspace_exists(Keyspace, ?EDB_CONSISTENCY_ANY_ONE) -> qedb_lib_schema:keyspace_exists(Keyspace);
keyspace_exists(Keyspace, Options) ->
  qedb_lib_schema:query(keyspace_exists, [Keyspace, Specifications], Options).

%% @doc Creates keyspace
keyspace_create(Keyspace, Specifications) ->
  keyspace_create(Keyspace, Specifications, [{consistency, ?EDB_CONSISTENCY_ALL_AVAILLABLE}]).

%% @doc Creates keyspace
keyspace_create(Keyspace, Specifications, Options) ->
  qedb_lib_schema:query(keyspace_create, [Keyspace, Specifications], Options).

%% @doc Alter keyspace
keyspace_alter(Keyspace, Specifications) ->
  keyspace_alter(Keyspace, Specifications, [{consistency, ?EDB_CONSISTENCY_ALL_AVAILLABLE}]).

%% @doc Alter keyspace
keyspace_alter(Keyspace, Specifications, Options) ->
  qedb_lib_schema:query(keyspace_alter, [Keyspace, Specifications], Options).

%% @doc Drop keyspace
keyspace_drop(Keyspace) ->
  keyspace_drop(Keyspace, [{consistency, ?EDB_CONSISTENCY_ALL_AVAILLABLE}]).

%% @doc Drop keyspace
keyspace_drop(Keyspace, Options) ->
  qedb_lib_schema:query(keyspace_drop, [Keyspace], Options).

%% @doc Returns specified keyspace info
keyspace_get_nodes(Keyspace) ->
  keyspace_get_nodes(Keyspace, [{consistency, ?EDB_CONSISTENCY_ANY_ONE}]).

%% @doc Returns specified keyspace info
keyspace_get_nodes(Keyspace, Options) ->
  qedb_lib_schema:query(keyspace_get_nodes, [Keyspace], Options).

%% @doc Returns specified keyspace info
keyspace_get_info(Keyspace) ->
  keyspace_get_info(Keyspace, [{consistency, ?EDB_CONSISTENCY_ANY_ONE}]).

%% @doc Returns specified keyspace info
keyspace_get_info(Keyspace, Options) ->
  qedb_lib_schema:query(keyspace_get_info, [Keyspace], Options).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



