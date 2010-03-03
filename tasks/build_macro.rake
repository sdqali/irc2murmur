require 'rake/clean'

desc "Build a tarball containing lib/*.*, README, init.rb and a "+
     "VERSION file. Substitute version number into all files."
task :versioned_tarball => [:clean, :versioned_files, :tarball]

task :tarball => [:deployable_files, 'tmp', 'out', :project_name_set] do
  sh "tar cz -C tmp -f out/#{tarball} #{PROJECT_NAME}"
end

task :versioned_files => ['tmp', :deployable_files, :macro_version_set] do
  sh "touch tmp/#{version_file}"
  sh "find tmp -type f | xargs sed  -i'.bak' -e 's/%VERSION%/#{macro_version}/'"
  sh "find tmp -name '*.bak' | xargs rm -f "
end

task :deployable_files => ['tmp', :project_name_set]  do
  macro_root = "tmp/#{PROJECT_NAME}"
  mkdir macro_root unless File.exists? macro_root
  cp_r ['lib', 'README'], macro_root
end

task :project_name_set do
  raise "PROJECT_NAME must be set" unless defined? PROJECT_NAME
end

task :macro_version_set do
  raise "MACRO_VERSION must be set" unless defined? MACRO_VERSION
end  

def macro_version
  label = ENV['CRUISE_PIPELINE_LABEL'] || 'dev'
  MACRO_VERSION + '-' + label
end

def tarball
  "#{PROJECT_NAME}-#{macro_version}.tar.gz"
end

def version_file
  "#{PROJECT_NAME}/VERSION-#{macro_version}"
end

def build_dir dir
  directory dir
  CLEAN.include dir
end

build_dir 'tmp'
build_dir 'out'
