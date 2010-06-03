PROJECT_NAME = 'irc2murmur'
VERSION_NUM = '0.1.0'

%w[rubygems rake rake/clean].each { |f| require f }

desc "Run all the specs, separately"
task :spec do
  count = 0
  Dir.new(File.dirname(__FILE__) + '/spec').each do |file|
    unless ['.', '..'].include? file
      if file.include? '_spec.rb'
        puts "Running the specs in spec/#{file}"
        system("spec spec/#{file}")
        count += 1
      end
    end
  end
  puts "----------------------------------"
  puts "Ran specs in #{count} files"
end
