PROJECT = worssservice_erlang
DEPS = cowboy jiffy rss_wc
dep_jiffy =  git git://github.com/davisp/jiffy.git HEAD
dep_rss_wc = git https://github.com/dkelsey/rss_wc.git master
include erlang.mk
