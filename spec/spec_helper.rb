require 'stringio'
require 'merchants_guide'

RSpec.configure do |config|
  config.before(:each) { $stdout = StringIO.new }
  config.after(:all)  { $stdin = STDIN }
  config.after(:all)  { $stdout = STDOUT }

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.formatter = :documentation
  config.profile_examples = 10
  config.color = true
  config.order = :random
  Kernel.srand config.seed
end