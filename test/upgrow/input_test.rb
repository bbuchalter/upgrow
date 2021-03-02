# frozen_string_literal: true

require 'test_helper'
require 'action_controller/metal/strong_parameters'

module Upgrow
  class InputTest < ActiveSupport::TestCase
    class SampleInput < Input
      attribute :title
      attribute :body

      validates :title, presence: true
    end

    test '#errors is an empty Active Model Errors' do
      input = Input.new
      errors = input.errors
      assert_empty errors
    end

    test '.new accepts individual arguments' do
      input = SampleInput.new(title: 'volmer', body: 'hello')

      assert_equal 'volmer', input.title
      assert_equal 'hello', input.body
    end

    test '.new accepts a Hash of Symbols' do
      args = { title: 'volmer', body: 'hello' }
      input = SampleInput.new(args)

      assert_equal 'volmer', input.title
      assert_equal 'hello', input.body
    end

    test '.new accepts a Hash of Strings' do
      args = { 'title' => 'volmer', 'body' => 'hello' }
      input = SampleInput.new(args)

      assert_equal 'volmer', input.title
      assert_equal 'hello', input.body
    end

    test '.new accepts Action Controller parameters' do
      args = ActionController::Parameters.new(
        'title' => 'volmer', 'body' => 'hello'
      ).permit(:title, :body)

      input = SampleInput.new(args)

      assert_equal 'volmer', input.title
      assert_equal 'hello', input.body
    end

    test '.valid? is true when validation passes' do
      input = SampleInput.new(title: 'volmer')
      assert_predicate input, :valid?
    end

    test '.valid? is false when validation fails' do
      input = SampleInput.new
      refute_predicate input, :valid?
    end
  end
end
