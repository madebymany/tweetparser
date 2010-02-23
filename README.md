# tweetparser

Extract content from tweets in the form of an s-expression.

## Usage

    require "tweetparser"
    parser = TweetContentParser.new
    tweet = "Hey @threedaymonk, here is a tweet with #hashtags and a http://example.com/url"
    parser.parse(tweet).content

This gives:

    [[:text, "Hey"], [:space, " "],
     [:atref, "@threedaymonk"], [:text, ","], [:space, " "],
     [:text, "here"], [:space, " "],
     [:text, "is"], [:space, " "],
     [:text, "a"], [:space, " "],
     [:text, "tweet"], [:space, " "],
     [:text, "with"], [:space, " "],
     [:hashtag, "#hashtags"], [:space, " "],
     [:text, "and"], [:space, " "],
     [:text, "a"], [:space, " "],
     [:url, "http://example.com/url"]]

## Dependencies

* treetop
* polyglot
