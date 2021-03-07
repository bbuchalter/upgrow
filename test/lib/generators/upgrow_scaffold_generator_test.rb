# frozen_string_literal: true
require 'rails_helper'
require 'generators/upgrow_scaffold/upgrow_scaffold_generator'

class UpgrowScaffoldGeneratorTest < Rails::Generators::TestCase
  tests UpgrowScaffoldGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination
  arguments ['article', 'title:string', 'body:text']

  def files_expected_to_be_created_by_generator
    [
      'app/actions/create_article_action.rb',
      'app/actions/delete_article_action.rb',
      'app/actions/edit_article_action.rb',
      'app/actions/list_article_action.rb',
      'app/actions/show_article_action.rb',
      'app/actions/update_article_action.rb',
      'app/controllers/articles_controller.rb',
      'app/inputs/article_input.rb',
      'app/models/article.rb',
      'app/records/article_record.rb',
      'app/repositories/article_repository.rb',
    ]
  end

  def test_app_file_content_to_exclude
    {
      'app/inputs/article_input.rb' => "\n\n\
  validates :title, presence: true\n\
  validates :body, presence: true, length: { minimum: 10 }",
    }
  end

  def files_in_generator_destination
    Dir.glob("#{destination_root}/**/*").select do |path|
      File.file?(path)
    end .map do |path|
      path.gsub(destination_root.to_s,
    '').slice(1..-1)
    end
  end

  test 'generator creates only expected files' do
    files_before_generator = files_in_generator_destination
    run_generator
    files_after_generator = files_in_generator_destination

    files_created_by_generator = files_after_generator - files_before_generator
    assert_equal(
      files_expected_to_be_created_by_generator,
      files_created_by_generator.sort
    )
  end

  test 'generator creates same files as the test app' do
    run_generator

    files_expected_to_be_created_by_generator.each do |generated_file_path|
      test_app_file_path = 'test/dummy/' + generated_file_path

      expected_content = File.read(test_app_file_path)
      content_to_exclude = test_app_file_content_to_exclude[generated_file_path]

      if content_to_exclude
        expected_content = expected_content.gsub(content_to_exclude, '')
      end

      assert_file generated_file_path do |generated_content|
        assert_equal expected_content, generated_content
      end
    end
  end
end
