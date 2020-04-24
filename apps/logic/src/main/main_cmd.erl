-module(main_cmd).

%% ===========================API============================
-export([handle/2]).

handle(Cmd, Data) ->
	case get_mod(Cmd) of
		undefined ->
			noreply;
		Mod ->
			Mod:handle(Cmd, Data)
	end.

%% ===========================Internal============================

get_mod(Cmd) ->
	case Cmd div 100 of
		20 ->
			test_cmd;
		_ ->
			undefined
	end.
