require "rails_helper"
require "generators/upgrow_scaffold/upgrow_scaffold_generator"

class UpgrowScaffoldGeneratorTest < Rails::Generators::TestCase
  tests UpgrowScaffoldGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination
  arguments %w(article title:string body:text)

  def files_expected_to_be_created_by_generator
    %w(
      app/actions/create_article_action.rb
      app/actions/show_article_action.rb
      app/inputs/article_input.rb
      app/models/article.rb
      app/records/article_record.rb
      app/repositories/article_repository.rb
    )
  end

  def files_in_generator_destination
    Dir.glob("#{destination_root}/**/*").select { |path| File.file?(path) }.map { |path| path.gsub(destination_root.to_s, '').slice(1..-1) }
  end

  test "generator creates only expected files" do
    files_before_generator = files_in_generator_destination
    run_generator
    files_after_generator = files_in_generator_destination

    files_created_by_generator = (files_after_generator - files_before_generator).sort
    assert_equal files_expected_to_be_created_by_generator, files_created_by_generator
  end

  test "generator creates same files as the dummy app" do
    run_generator

    files_expected_to_be_created_by_generator.each do |generated_file_file_path|
      test_dummy_app_file_path = 'test/dummy/' + generated_file_file_path
      expected_content = File.read(test_dummy_app_file_path)

      assert_file generated_file_file_path do |generated_content|
        assert_equal expected_content, generated_content
      end
    end
  end
end
