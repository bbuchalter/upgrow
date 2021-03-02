# frozen_string_literal: true

require 'test_helper'

module Upgrow
  class ImmutableObjectTest < ActiveSupport::TestCase
    class Sample < ImmutableObject
      attribute :title
      attribute :body
    end

    class SubSample < Sample
      attribute :name
    end

    test '.attribute_names is empty by default' do
      assert_empty ImmutableObject.attribute_names
    end

    test '.attribute_names returns a list of attribute names' do
      assert_equal [:title, :body, :name], SubSample.attribute_names
    end

    test '.new creates a frozen instance with the given attributes' do
      sample = Sample.new(title: 'volmer', body: 'hello')

      assert_equal 'volmer', sample.title
      assert_equal 'hello', sample.body
      assert sample.frozen?
    end

    test 'it does not allow members to be mutated' do
      sample = Sample.new(title: 'volmer', body: 'hello')

      refute sample.respond_to?(:title=)
      refute sample.respond_to?(:body=)
    end

    test '.new rejects attributes that do not exist' do
      error = assert_raises(ArgumentError) do
        Sample.new(title: 'volmer', body: 'hello', fake: 'error')
      end

      assert_equal 'Unknown attribute [:fake]', error.message
    end

    test '.new requires inherited attributes' do
      sub_sample = SubSample.new(title: 'volmer', body: 'hello', name: 'rafael')
      assert_equal 'volmer', sub_sample.title
      assert_equal 'hello', sub_sample.body
      assert_equal 'rafael', sub_sample.name
    end
  end
end
