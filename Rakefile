require 'rubygems'

#################################### BUNDLER ###################################

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

#################################### JEWELER ###################################

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name        = "boolean"
  gem.homepage    = "http://rubygems.org/gems/boolean"
  gem.license     = "MIT"
  gem.summary     = %Q{Useful methods for working with Booleans}
  gem.description = %Q{This gem extends core classes, adding helpful methods for working with Booleans (such as #to_bool and #parse_bool, and a Boolean type).}
  gem.email       = "git@timothymorgan.info"
  gem.authors     = [ "Tim Morgan" ]
end
Jeweler::RubygemsDotOrgTasks.new

##################################### RSPEC ####################################

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

##################################### YARD #####################################

require 'yard'
YARD::Rake::YardocTask.new do |doc|
  doc.options << "-m" << "textile"
  doc.options << "--protected"
  doc.options << "--no-private"
  doc.options << "-r" << "README.textile"
  doc.options << "-o" << "doc"
  doc.options << "--title" << "Boolean Documentation".inspect

  doc.files = [ 'lib/**/*', 'README.textile' ]
end

desc "Generate API documentation"
task :doc => :yard
