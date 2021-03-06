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
    expected_files_created_by_generator = %w(
      app/inputs/article_input.rb
      app/models/article.rb
      app/records/article_record.rb
      app/repositories/articles_repository.rb
    )
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

  test "generator creates app/repositories/articles_repository.rb" do
    run_generator

    assert_file 'app/repositories/articles_repository.rb' do |generated_content|
      expected_content = <<~EXPECTED_CONTENT
      class ArticleRepository
        def all
          ArticleRecord.all.map { |record| to_model(record.attributes) }
        end

        def create(input)
          record = ArticleRecord.create!(title: input.title, body: input.body)
          to_model(record.attributes)
        end

        def find(id)
          record = ArticleRecord.find(id)
          to_model(record.attributes)
        end

        def update(id, input)
          record = ArticleRecord.find(id)
          record.update!(title: input.title, body: input.body)
          to_model(record.attributes)
        end

        def delete(id)
          record = ArticleRecord.find(id)
          record.destroy!
        end

        private

        def to_model(attributes)
          Article.new(**attributes.symbolize_keys)
        end
      end
      EXPECTED_CONTENT

      assert_equal expected_content, generated_content
    end
  end

  test "generator creates app/inputs/article_input.rb" do
    run_generator

    assert_file 'app/inputs/article_input.rb' do |generated_content|
      expected_content = <<~EXPECTED_CONTENT
      class ArticleInput
        include ActiveModel::Model

        attr_accessor :title, :body
      end
      EXPECTED_CONTENT

      assert_equal expected_content, generated_content
    end
  end


  test "generator creates app/models/article.rb" do
    run_generator

    assert_file 'app/models/article.rb' do |generated_content|
      expected_content = <<~EXPECTED_CONTENT
      class Article
        attr_reader :id, :title, :body, :created_at, :updated_at

        def initialize(id:, title:, body:, created_at:, updated_at:)
          @id = id
          @title = title
          @body = body
          @created_at = created_at
          @updated_at = updated_at
        end
      end
      EXPECTED_CONTENT

      assert_equal expected_content, generated_content
    end
  end
end
