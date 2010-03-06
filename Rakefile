PROJECT_NAME = 'irc2murmur'
MACRO_VERSION = '0.0.1'

%w[rubygems rake rake/clean fileutils spec/rake/spectask].each { |f| require f }

task :test => [:spec]

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

