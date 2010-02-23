$:.unshift(File.join(File.dirname(__FILE__), "lib"))
require "treetop"
require "polyglot"
require "tweetparser/grammar"

s = %{Another test:  <a href="http://twitpic.com/14vzny" target="_blank"><img src="http://twitpic.com/show/mini/14vzny" /></a>
http://twitpic.com/14vzny 3 http://twitpic.com/14vzny}


parser = TweetContentParser.new
p parser.parse(s).content
