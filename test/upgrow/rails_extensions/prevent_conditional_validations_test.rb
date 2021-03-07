# frozen_string_literal: true

require 'test_helper'

module Upgrow
  module RailsExtensions
    class PreventConditionalValidationsTest < ActiveSupport::TestCase
      class PreventConditionalValidationsTestModel < Upgrow::Input
        attribute :title
        validates :title, presence: true, on: :new
      end

      test 'conditional validations raise an exception' do
        assert_raises(ConditionalValidationsNotPermitted) do
          PreventConditionalValidationsTestModel.new.valid?(:new)
        end
      end
    end
  end
end
