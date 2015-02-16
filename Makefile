PROJECT = worssservice_erlang
DEPS = cowboy jiffy rss_wc
dep_jiffy =  git git://github.com/davisp/jiffy.git HEAD
dep_rss_wc = git git@localhost:GIT/rss_wc master
include erlang.mk
