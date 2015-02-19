%% Copyright 2014 Erlio GmbH Basel Switzerland (http://erl.io)
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(vmq_graphite_cli).
-export([register/0]).

register() ->
    ConfigKeys =
    ["graphite_interval",
     "graphite_prefix",
     "graphite_port",
     "graphite_host",
     "graphite_api_key"],
    [clique:register_config([Key], fun register_config_callback/3)
     || Key <- ConfigKeys],
    ok = clique:register_config_whitelist(ConfigKeys).

register_config_callback(_, _, _) ->
    Configs = [{vmq_graphite, application:get_all_env(vmq_graphite)}],
    vmq_graphite:change_config(Configs).


