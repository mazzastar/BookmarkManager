ENV["RACK_ENV"] = 'test' # because we need to know what database to work with
require_relative '../server'
require 'database_cleaner'

require 'capybara/rspec'
# require 'signin_helper_spec'
# require 'adding_links_helper_spec'

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234

  config.before(:suite) do
  	DatabaseCleaner.strategy = :truncation
  	DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do 
  	DatabaseCleaner.start
  end
  config.after(:each) do 
  	DatabaseCleaner.clean
  end

  config.order = 'random'

end

