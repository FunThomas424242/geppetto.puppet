require 'rspec-puppet'
2 
3 fixture_path = File.expand_path(File.join(__FILE__, '..', '..', 'fixtures'))
4 
5 RSpec.configure do |c|
6   c.module_path = File.join(fixture_path, 'modules')
7   c.manifest_dir = File.join(fixture_path, 'manifests')
8 end
