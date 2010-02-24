# encoding: UTF-8
$:.unshift(File.expand_path("../../lib", __FILE__))
require "test/unit"
require "shoulda"
require "tweetparser"
require "yaml"
require "cgi"

class AutolinkConformanceTest < Test::Unit::TestCase
  DATA_PATH = File.expand_path("../twitter-text-conformance/autolink.yml", __FILE__)

  def assert_autolink(expected, input)
    sexpr = TweetParser.parse(input)
    assert sexpr, "Failed to parse #{input}"
    actual = sexpr.inject(""){ |output, (type, value)|
      output <<
        case type
        when :username
          at, username = value.scan(/^.|.*/)
          %{#{at}<a class="tweet-url username" href="http://twitter.com/#{username}">#{username}</a>}
        when :list
          at, list = value.scan(/^.|.*/)
          %{#{at}<a class="tweet-url list-slug" href=\"http://twitter.com/#{list}">#{list}</a>}
        when :hashtag
          hash, hashtag = value.scan(/^.|.*/)
          %{<a href="http://twitter.com/search?q=%23#{hashtag}" }+
          %{title="\##{hashtag}" class="tweet-url hashtag">#{value}</a>}
        when :url
          href = value
          href = "http://" + value unless href =~ /^http/i
          %{<a href="#{href}">#{value}</a>}
        else
          value
        end
    }
    assert_equal expected, actual, sexpr.inspect
  end

  YAML.load(File.read(DATA_PATH))["tests"].each do |section, tests|
    context "when testing #{section}" do
      tests.each do |hash|
        should hash["description"] do
          assert_autolink hash["expected"], hash["text"]
        end
      end
    end
  end
end
