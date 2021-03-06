require "rails_helper"
require "generators/upgrow_scaffold/upgrow_scaffold_generator"

class UpgrowScaffoldGeneratorTest < Rails::Generators::TestCase
  tests UpgrowScaffoldGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
