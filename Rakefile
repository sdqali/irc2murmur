PROJECT_NAME = 'irc2murmur'
MACRO_VERSION = '0.0.1'

%w[rubygems rake rake/clean fileutils macro_development_toolkit spec/rake/spectask].each { |f| require f }

Dir['tasks/**/*.rake'].each { |t| load t }

task :default => [:test, :versioned_tarball]

task :test => [:spec, 'jspec:run']

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

