%% @author YouShuxiang
%% @doc @todo Add description to router.


-module(router).

-include("tcp.hrl").
-include("logger.hrl").

%% ====================================================================
%% API functions
%% ====================================================================
-export([rout_msg/2]).

rout_msg(Args, State) ->
	{Cmd, Data} = Args,
	Mod = get_mod(Cmd),
	RolePid = State#tcp_state.player_pid,
	case RolePid of
		undefined ->
			Mod:cmd(Cmd, Data, State);
		_ ->
			Msg = {cmd, {Cmd, Data}},
			gen_server:cast(RolePid, Msg)
	end.

get_mod(Cmd) ->	
	case Cmd div 100 of
		10 ->
			login;
		99 ->
			trade_order;
		_ ->
			player
	end.

