%% @author YouShuxiang
%% @doc @todo Add description to response.


-module(response).

%% ====================================================================
%% API functions
%% ====================================================================
-export([send_to_client/2, send_to_client/3]).
-export([broadcast/3]).
-export([send/2]).

%% ================================================================================
%% API
%% ================================================================================

%% 向客户端发送消息

send_to_client(SockList, Data) when is_list(SockList) ->
    Bin = jsx:encode(Data),
    Msg = {tcp_json_send, Bin},
    lists:foreach(
        fun(RolePID) ->
            RolePID ! Msg
        end, SockList);
send_to_client(Socket, Data) ->
    Bin = jsx:encode(Data),
    Msg = {tcp_json_send, Bin},
    Socket ! Msg.

send_to_client(SockList, Cmd, Data) when is_list(SockList) ->
%%    lager:info("cmd: ~p~n", [Cmd]),
%%    lager:info("Data: ~p~n", [Data]),
	DataStatus = packet:get_data_status(raw),
	{ok, Bin} = packet:pack(Cmd, DataStatus, Data),
	Msg = {tcp_send, Bin},
	lists:foreach(
		fun(RolePID) ->
			RolePID ! Msg
		end, SockList);
send_to_client(Socket, Cmd, Data) ->
%%    lager:info("cmd: ~p~n", [Cmd]),
%%    lager:info("Data: ~p~n", [Data]),
    DataStatus = packet:get_data_status(raw),
    {ok, Bin} = packet:pack(Cmd, DataStatus, Data),
    Msg = {tcp_send, Bin},
    Socket ! Msg.

%%
broadcast(List, Cmd, Data) ->
    DataStatus = packet:get_data_status(raw),
    {ok, Bin} = packet:pack(Cmd, DataStatus, Data),
    lists:foreach(
        fun(RolePID) ->
            RolePID ! {send, Bin}
        end, List).

send(SockPid, Bin) ->
    Msg = {tcp_send, Bin},
    SockPid ! Msg.




%% ================================================================================
%% Internal
%% ================================================================================




