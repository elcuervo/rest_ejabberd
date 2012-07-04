require 'rake/testtask'

namespace :test do
  Rake::TestTask.new :all do |t|
    t.pattern = "test/**/*_test.rb"
    t.libs = ["lib", "test"]
  end
end

task :test => ["test:all"]
task default: :test
