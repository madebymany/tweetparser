# tweetparser

Extract content from tweets in the form of an s-expression.

## Usage

    require "tweetparser"
    tweet = "Hey @threedaymonk, here is a tweet with #hashtags and a http://example.com/url"
    TweetParser.parse(tweet)

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

The full list of tweet parts recognised is as follows:

* `:url` (http://example.com/ or www.example.com)
* `:username` (@username) This was `:atref` in version 0.1.0
* `:list` (@username/listname)
* `:hashtag` (#hashtag)
* `:slash` (/via)
* `:text`
* `:newline`
* `:html` (pre-composed HTML)

## Dependencies

* treetop
* polyglot

After checking out the code via git, you need to fetch the conformance test submodule:

    git submodule init
    git submodule update

## Known bugs

* The maximum length of a username or list is not checked.
* A username etc. immediately following punctuation is not recognised.
* Japanese text is not handled correctly.
* Hashtags containing accents are not supported.
