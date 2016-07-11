%%%-------------------------------------------------------------------
%%% @author lmaselek
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. lip 2014 19:32
%%%-------------------------------------------------------------------
-module(log_record).
-author("lmaselek").

%% API
-export([run/1]).

-include_lib("log_record.hrl").

run(Record) when is_tuple(Record) ->
  io:fwrite("ello3\n"),
  case rec_inf(Record) of
    [] ->
      io:fwrite("a1\n"),
      Record;
    FieldNames ->
      io:fwrite("a2\n"),
      {[RecName], FieldValues} = lists:split(1, tuple_to_list(Record)),
      Content = lists:foldl(
          fun({Key, Value}, Acc) ->
            KeyValue = lists:flatten(io_lib:format("~p = ~p", [Key, Value])),
            case Acc of
              [] -> KeyValue;
              _ -> Acc ++ ", " ++ KeyValue
            end
          end, [], lists:zip(FieldNames, FieldValues)),
      io:fwrite("#~s{~s}", [atom_to_list(RecName), Content])
  end;
run(Any) ->
  Any
.

rec_inf(Record) when is_record(Record, rec)   -> record_info(fields, rec);
rec_inf(Record) when is_record(Record, inny)  -> record_info(fields, inny);
rec_inf(Record) when is_record(Record, inny2) -> record_info(fields, inny2);
rec_inf(_)                                    -> [].