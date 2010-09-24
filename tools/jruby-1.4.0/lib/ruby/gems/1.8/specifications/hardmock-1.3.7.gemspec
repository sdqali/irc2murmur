# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hardmock}
  s.version = "1.3.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Crosby"]
  s.autorequire = %q{hardmock}
  s.date = %q{2009-11-08}
  s.email = %q{crosby@atomicobject.com}
  s.extra_rdoc_files = ["README", "CHANGES", "LICENSE"]
  s.files = ["lib/assert_error.rb", "lib/extend_test_unit.rb", "lib/hardmock/errors.rb", "lib/hardmock/expectation.rb", "lib/hardmock/expectation_builder.rb", "lib/hardmock/expector.rb", "lib/hardmock/method_cleanout.rb", "lib/hardmock/mock.rb", "lib/hardmock/mock_control.rb", "lib/hardmock/stubbing.rb", "lib/hardmock/trapper.rb", "lib/hardmock/utils.rb", "lib/hardmock.rb", "lib/test_unit_before_after.rb", "test/functional/assert_error_test.rb", "test/functional/auto_verify_test.rb", "test/functional/direct_mock_usage_test.rb", "test/functional/hardmock_test.rb", "test/functional/stubbing_test.rb", "test/test_helper.rb", "test/unit/expectation_builder_test.rb", "test/unit/expectation_test.rb", "test/unit/expector_test.rb", "test/unit/method_cleanout_test.rb", "test/unit/mock_control_test.rb", "test/unit/mock_test.rb", "test/unit/test_unit_before_after_test.rb", "test/unit/trapper_test.rb", "test/unit/verify_error_test.rb", "Rakefile", "config/environment.rb", "rake_tasks/rdoc_options.rb", "rake_tasks/rdoc.rake", "rake_tasks/test.rake", "README", "CHANGES", "LICENSE"]
  s.homepage = %q{http://atomicobject.github.com/hardmock}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--main", "README", "--title", "Hardmock"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{hardmock}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A strict, ordered, expectation-oriented mock object library.}
  s.test_files = ["test/functional/assert_error_test.rb", "test/functional/auto_verify_test.rb", "test/functional/direct_mock_usage_test.rb", "test/functional/hardmock_test.rb", "test/functional/stubbing_test.rb", "test/unit/expectation_builder_test.rb", "test/unit/expectation_test.rb", "test/unit/expector_test.rb", "test/unit/method_cleanout_test.rb", "test/unit/mock_control_test.rb", "test/unit/mock_test.rb", "test/unit/test_unit_before_after_test.rb", "test/unit/trapper_test.rb", "test/unit/verify_error_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
