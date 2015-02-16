-module(rss_handler).
-behaviour(cowboy_http_handler).
-include("global.hrl").

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-record(state, {
}).

init(_, Req, _Opts) ->
	{ok, Req, #state{}}.

handle(Req, State=#state{}) ->
		{Uri, Req2} = cowboy_req:qs_val(<<"fetch">>, Req),
		rss_wc:decode_uri(Uri),
		receive
			{_, {ok, JSON}} -> 
		        {ok, Req3} = cowboy_req:reply(200,
		        [{<<"content-type">>, <<"application/json">>}],
		        [JSON],
		        Req2),
  				{ok, Req3, State}
		end.

terminate(_Reason, _Req, _State) ->
	ok.

a_test() -> ?assertEqual(true, 1 =:= 1).