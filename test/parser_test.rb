# encoding: UTF-8
$:.unshift(File.expand_path("../../lib", __FILE__))
require "test/unit"
require "shoulda"
require "tweetparser"

class ParserTest < Test::Unit::TestCase

  def setup
    @parser = TweetContentParser.new
  end

  def assert_parses(expected, input)
    actual = @parser.parse(input).content
    assert_equal expected, actual
  end

  should "parse a blank string" do
    assert_parses [], ""
  end

  should "extract url with query string and target" do
    s = "https://mail.google.com/mail/?ui=2&shva=1#inbox"
    assert_parses [[:url, s]], s
  end

  should "extract url with www and no http" do
    s = "www.example.com/mail/?ui=2&shva=1#inbox"
    assert_parses [[:url, s]], s
  end

  should "not extract invalid domain" do
    s = "http://example_com/mail/?ui=2&shva=1#inbox"
    assert_parses [[:text, s]], s
  end

  should "extract hashtag" do
    s = "#HashTag2010"
    assert_parses [[:hashtag, s]], s
  end

  should "extract at-references" do
    s = "@AtRef_3000"
    assert_parses [[:username, s]], s
  end

  should "extract HTML" do
    s = %{<some tag with="http://href.com/">}
    assert_parses [[:html, s]], s
  end

  should "extract a slash comment" do
    s = %{/via}
    assert_parses [[:slash, s]], s
  end

  should "extract a list" do
    s = %{@username/list}
    assert_parses [[:list, s]], s
  end

  should "extract words spaces and new lines" do
    s = "this string\nhas spaces!"
    expected = [[:text, "this"], [:space, " "], [:text, "string"], [:newline],
                [:text, "has"], [:space, " "], [:text, "spaces!"]]
    assert_parses expected, s
  end

  should "extract everything from sample tweet" do
    s = %{Another test:  <a href="http://twitpic.com/14vzny" target="_blank"><img src="http://twitpic.com/show/mini/14vzny" /></a>\nhttp://twitpic.com/14vzny 3 http://twitpic.com/14vzny}
    expected = [[:text, "Another"], [:space, " "], [:text, "test:"], [:space, "  "],
                [:html, "<a href=\"http://twitpic.com/14vzny\" target=\"_blank\">"],
                [:html, "<img src=\"http://twitpic.com/show/mini/14vzny\" />"],
                [:html, "</a>"], [:newline],
                [:url, "http://twitpic.com/14vzny"],
                [:space, " "], [:text, "3"], [:space, " "],
                [:url, "http://twitpic.com/14vzny"]]
    assert_parses expected, s
  end

  should "extract elements from real-world sample" do
    s = %{RT @newsbrooke Tonight’s the night!: Hope you’ll all tune in tonight to watch On Expenses at 9pm on BBC4 http://bit.ly/cgbkmF #mps #uk}
    expected = [[:text, "RT"], [:space, " "], [:username, "@newsbrooke"], [:space, " "],
                [:text, "Tonight’s"], [:space, " "], [:text, "the"], [:space, " "],
                [:text, "night!:"], [:space, " "], [:text, "Hope"], [:space, " "],
                [:text, "you’ll"], [:space, " "], [:text, "all"], [:space, " "],
                [:text, "tune"], [:space, " "], [:text, "in"], [:space, " "],
                [:text, "tonight"], [:space, " "], [:text, "to"], [:space, " "],
                [:text, "watch"], [:space, " "], [:text, "On"], [:space, " "],
                [:text, "Expenses"], [:space, " "], [:text, "at"], [:space, " "],
                [:text, "9pm"], [:space, " "], [:text, "on"], [:space, " "],
                [:text, "BBC4"], [:space, " "], [:url, "http://bit.ly/cgbkmF"], [:space, " "],
                [:hashtag, "#mps"], [:space, " "], [:hashtag, "#uk"]]
    assert_parses expected, s
  end

end

