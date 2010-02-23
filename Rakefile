require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"

task :default => :test

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

spec = Gem::Specification.new do |s|

  # Change these as appropriate
  s.name              = "tweetparser"
  s.version           = "0.1.0"
  s.summary           = "Extract content from tweets"
  s.author            = "Paul Battley"
  s.email             = "pbattley@gmail.com"
  s.homepage          = "http://github.com/madebymany/tweetparser"

  s.has_rdoc          = false

  s.files             = %w() + Dir.glob("{test,lib}/**/*")

  s.require_paths     = ["lib"]

  s.add_dependency("treetop", "~> 1.4.2")
  s.add_dependency("polyglot", "~> 0.2.9")

  s.add_development_dependency("shoulda")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
