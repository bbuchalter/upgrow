# frozen_string_literal: true
class ArticleInput < Upgrow::Input
  attribute :title
  attribute :body

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
