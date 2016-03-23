Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

RSpec.configure do |config|

  config.expect_with :rspec do |c|
    # disable the 'should' syntax
    c.syntax = :expect
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Our helper from 'support' folder
  config.include Requests::JsonHelpers, type: :request

  config.disable_monkey_patching!

end
