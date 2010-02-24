require "treetop"
require "polyglot"
require "tweetparser/grammar"

module TweetParser
  def self.parse(input)
    kcode = $KCODE
    $KCODE = "n"
    parser = TweetContentParser.new
    parsed = parser.parse(input)
    $KCODE = kcode
    return nil unless parsed
    parsed.content
  end
end
