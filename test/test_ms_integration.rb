# frozen_string_literal: true

require_relative "test_helper"

class TestMsIntegration < Minitest::Test
  def test_ms_dispatch
    assert_equal 1000, Ms::Rb.ms("1s")
    assert_equal "1s", Ms::Rb.ms(1000)
  end

  def test_negative
    assert_equal(-1000, Ms::Rb.parse("-1s"))
    assert_equal("-1s", Ms::Rb.format(-1000))
  end
end
