PROJECT_NAME = 'irc2murmur'
VERSION_NUM = '0.1.0'

%w[rubygems rake rake/clean spec/rake/spectask].each { |f| require f }

desc "Run all the specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/*_spec.rb']
end
