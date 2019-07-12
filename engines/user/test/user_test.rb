# frozen_string_literal: true

require 'test_helper'

class User::Test < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, User
  end
end
