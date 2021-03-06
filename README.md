# worssservice_erlang

A cowboy based web service that performs a word-count on item description for RSS XML sources.

# Details

This is a cowboy web service which accepts a `GET` request with the parameter 'fetch' which contains the URI of an RSS XML file.  The service passes the request onto the `rss_wc` application for processing.  The `rss_wc` service processes the request and returns a word-count in JSON for the top 10 occurring words, and a total of filtered stop-words.  For more detail on the workings of `rss_wc` see: [rss_wc on Github](https://github.com/dkelsey/rss_wc)

# Installation

```bash
mkdir proj && cd proj
git clone https://github.com/dkelsey/worssservice_erlang.git
cd worssservice_erlang/
make deps
cd deps/rss_wc/
make deps
make clean app
make rel
./relx release
cd ../../
make clean app
make rel
./relx release tar
mkdir tmp
cp stopwords.txt tmp/
cd tmp/
gzcat ../_rel/worssservice_erlang_release/worssservice_erlang_release-1.tar.gz | tar xvf -
./bin/worssservice_erlang_release console
Exec: ...
...
...
Erlang/OTP 17 [erts-6.3] [source-f9282c6] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V6.3  (abort with ^G)
(worssservice_erlang@127.0.0.1)1> application:which_applications().
[{worssservice_erlang,"WhiteOps RSS Word Count Service",
                      "0.1.0"},
 {cowboy,"Small, fast, modular HTTP server.","1.0.1"},
 {rss_wc,"RSS Word Count Application","0.1.0"},
 {cowlib,"Support library for manipulating Web protocols.",
         "1.0.1"},
 {jiffy,"JSON Decoder/Encoder.","0.13.3-2-g801f9e7"},
 {xmerl,"XML parser","1.3.7"},
 {inets,"INETS  CXC 138 49","5.10.4"},
 {crypto,"CRYPTO","3.4.2"},
 {ranch,"Socket acceptor pool for TCP protocols.","1.1.0"},
 {stdlib,"ERTS  CXC 138 10","2.3"},
 {kernel,"ERTS  CXC 138 10","3.1"}]
(worssservice_erlang@127.0.0.1)2> q()
```

I've not included the output from the commands above but you will see that this will create a release and package it in a tar: `_rel/worssservice_erlang_release/worssservice_erlang_release-1.tar.gz`.
This can be copied to a location of your choosing, extracted and run.
You will need a [stopwords.txt](https://github.com/dkelsey/worssservice_erlang/blob/master/stopwords.txt) file in the directory from which you start the application.
To start the application run the following command:

```bash
./bin/worssservice_erlang_release console
...
...
Erlang/OTP 17 [erts-6.3] [source-f9282c6] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V6.3  (abort with ^G)
(worssservice_erlang@127.0.0.1)1> 
```
To verify further that the application and all dependencies were started run the following command:
```
(worssservice_erlang@127.0.0.1)1> application:which_applications().
[{worssservice_erlang,"WhiteOps RSS Service","0.1.0"},
 {cowboy,"Small, fast, modular HTTP server.","1.0.1"},
 {rss_wc,"RSS Word Count Application","0.1.0"},
 {cowlib,"Support library for manipulating Web protocols.",
         "1.0.1"},
 {jiffy,"JSON Decoder/Encoder.","0.13.3-2-g801f9e7"},
 {xmerl,"XML parser","1.3.7"},
 {inets,"INETS  CXC 138 49","5.10.4"},
 {crypto,"CRYPTO","3.4.2"},
 {ranch,"Socket acceptor pool for TCP protocols.","1.1.0"},
 {stdlib,"ERTS  CXC 138 10","2.3"},
 {kernel,"ERTS  CXC 138 10","3.1"}]
(worssservice_erlang@127.0.0.1)2> 
```

run `./bin/worssservice_erlang_release` without options to see available startup options.

# Usage

After installing and running the server, in your favourite browser navigate to:
```
http://localhost:8080?fetch=http%3A%2F%2Fdigg.com%2Frss%2Ftop.rss
```
or 
```
http://localhost:8080?fetch=http%3A%2F%2Frss.nytimes.com%2Fservices%2Fxml%2Frss%2Fnyt%2FHomePage.xml
```
you should get back something that looks like:
```json
{
	"words":[
		{
			"word":"new",
			"count":11
		},
		{
			"word":"one",
			"count":10
		},
		{
			"word":"from",
			"count":9
		},
		{
			"word":"has",
			"count":9
		},
		{
			"word":"have",
			"count":8
		},
		{
			"word":"had",
			"count":7
		},
		{
			"word":"so",
			"count":7
		},
		{
			"word":"than",
			"count":7
		},
		{
			"word":"he",
			"count":6
		},
		{
			"word":"other",
			"count":6
		}
	],
	"stopWordsIgnored":463
}
```
or respectively
```json
{
	"words":[
		{
			"word":"border",
			"count":90
		},
		{
			"word":"src",
			"count":90
		},
		{
			"word":"href",
			"count":56
		},
		{
			"word":"\"nofollow\"><img",
			"count":42
		},
		{
			"word":"rel",
			"count":42
		},
		{
			"word":"'1'",
			"count":40
		},
		{
			"word":"height",
			"count":34
		},
		{
			"word":"width",
			"count":34
		},
		{
			"word":"\"0\"/></a><br/><a",
			"count":28
		},
		{
			"word":"\"1\"",
			"count":28
		}
	],
	"stopWordsIgnored":155
}
```

# Todo

* integrate StatsD
* add logging
* perform more thorough testing and fill out unit tests.
* add a basic automated acceptance test : this was started but not completed.
* perform load testing 

# Notes

More detail can be found in [rss_wc](https://github.com/dkelsey/rss_wc)
