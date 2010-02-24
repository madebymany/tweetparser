# encoding: UTF-8
$KCODE = "u"
$:.unshift(File.expand_path("../../lib", __FILE__))
require "test/unit"
require "shoulda"
require "tweetparser"
require "yaml"

class ExtractionConformanceTest < Test::Unit::TestCase
  DATA_PATH = File.expand_path("../twitter-text-conformance/extract.yml", __FILE__)

  test_data = YAML.load(File.read(DATA_PATH))["tests"]

  context "when extracting mentions" do
    test_data["mentions"].each do |hash|
      should hash["description"] do
        parts = TweetParser.parse(hash["text"])
        assert_equal hash["expected"], parts.select{ |a| a[0] == :username }.map{ |a| a[1][/^.(.*)/, 1] }
      end
    end
  end

  context "when extracting urls" do
    test_data["urls"].each do |hash|
      should hash["description"] do
        parts = TweetParser.parse(hash["text"])
        assert_equal hash["expected"], parts.select{ |a| a[0] == :url }.map{ |a| a[1] }
      end
    end
  end

  context "when extracting hashtags" do
    test_data["hashtags"].each do |hash|
      should hash["description"] do
        parts = TweetParser.parse(hash["text"])
        assert_equal hash["expected"], parts.select{ |a| a[0] == :hashtag }.map{ |a| a[1][/^.(.*)/, 1] }
      end
    end
  end
end
