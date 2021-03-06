require "rails_helper"
require "generators/upgrow_scaffold/upgrow_scaffold_generator"

class UpgrowScaffoldGeneratorTest < Rails::Generators::TestCase
  tests UpgrowScaffoldGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination
  arguments %w(article title:string body:text)

  test "generator creates only expected files" do
    files_before_generator = Dir.glob("#{destination_root}/**/*").select { |path| File.file?(path) }.map { |path| path.gsub(destination_root.to_s, '').slice(1..-1) }
    run_generator
    files_after_generator = Dir.glob("#{destination_root}/**/*").select { |path| File.file?(path) }.map { |path| path.gsub(destination_root.to_s, '').slice(1..-1) }

    files_created_by_generator = (files_after_generator - files_before_generator).sort
    expected_files_created_by_generator = %w(app/records/article_record.rb)
    assert_equal expected_files_created_by_generator, files_created_by_generator
  end

  test "generator creates app/records/article_record.rb" do
    run_generator

    assert_file 'app/records/article_record.rb' do |generated_content|
      expected_content = <<~EXPECTED_CONTENT
      class ArticleRecord < ApplicationRecord
        self.table_name = 'articles'
      end
      EXPECTED_CONTENT

      assert_equal expected_content, generated_content
    end
  end
end
