{application, worssservice_erlang, [
	{description, "WhiteOps RSS Service"},
	{vsn, "0.1.0"},
	{id, ""},
	{modules, ['hello_handler', 'hello_handler_', 'worssservice_erlang_app', 'worssservice_erlang_sup']},
	{registered, []},
	{applications, [
		kernel,
		stdlib,
		cowboy
	]},
	{mod, {worssservice_erlang_app, []}},
	{env, []}
]}.
