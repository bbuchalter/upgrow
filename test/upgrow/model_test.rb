# frozen_string_literal: true

require 'test_helper'

module Upgrow
  class ModelTest < ActiveSupport::TestCase
    class SampleModel < Model
      attribute :title
      attribute :body
    end

    test '.attribute_names includes :id, :created_at, and :updated_at' do
      expected = [:id, :created_at, :updated_at, :title, :body]
      assert_equal expected, SampleModel.attribute_names
    end

    test '.new requires all attributes' do
      error = assert_raises(KeyError) do
        SampleModel.new(
          title: 'volmer', id: 1, created_at: Time.now, updated_at: Time.now
        )
      end

      assert_equal 'key not found: :body', error.message
    end
  end
end
