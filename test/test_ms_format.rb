# frozen_string_literal: true

require_relative "test_helper"

class TestMsFormat < Minitest::Test
  #
  # format(number, { long: true })
  #
  def test_long_should_not_throw
    assert_silent { Ms::Rb.format(500, long: true) }
  end

  def test_long_supports_milliseconds
    assert_equal "500 ms", Ms::Rb.format(500, long: true)
    assert_equal "-500 ms", Ms::Rb.format(-500, long: true)
  end

  def test_long_supports_seconds
    assert_equal "1 second",  Ms::Rb.format(1000, long: true)
    assert_equal "1 second",  Ms::Rb.format(1200, long: true)
    assert_equal "10 seconds", Ms::Rb.format(10_000, long: true)

    assert_equal "-1 second", Ms::Rb.format(-1000, long: true)
    assert_equal "-1 second", Ms::Rb.format(-1200, long: true)
    assert_equal "-10 seconds", Ms::Rb.format(-10_000, long: true)
  end

  def test_long_supports_minutes
    assert_equal "1 minute", Ms::Rb.format(60 * 1000, long: true)
    assert_equal "1 minute", Ms::Rb.format(60 * 1200, long: true)
    assert_equal "10 minutes", Ms::Rb.format(60 * 10_000, long: true)

    assert_equal "-1 minute", Ms::Rb.format(-1 * 60 * 1000, long: true)
    assert_equal "-1 minute", Ms::Rb.format(-1 * 60 * 1200, long: true)
    assert_equal "-10 minutes", Ms::Rb.format(-1 * 60 * 10_000, long: true)
  end

  def test_long_supports_hours
    assert_equal "1 hour", Ms::Rb.format(60 * 60 * 1000, long: true)
    assert_equal "1 hour", Ms::Rb.format(60 * 60 * 1200, long: true)
    assert_equal "10 hours", Ms::Rb.format(60 * 60 * 10_000, long: true)

    assert_equal "-1 hour", Ms::Rb.format(-1 * 60 * 60 * 1000, long: true)
    assert_equal "-1 hour", Ms::Rb.format(-1 * 60 * 60 * 1200, long: true)
    assert_equal "-10 hours", Ms::Rb.format(-1 * 60 * 60 * 10_000, long: true)
  end

  def test_long_supports_days
    day = 24 * 60 * 60 * 1000

    assert_equal "1 day", Ms::Rb.format(1 * day, long: true)
    assert_equal "1 day", Ms::Rb.format(1 * 24 * 60 * 60 * 1200, long: true)
    assert_equal "6 days", Ms::Rb.format(6 * day, long: true)

    assert_equal "-1 day", Ms::Rb.format(-1 * day, long: true)
    assert_equal "-1 day", Ms::Rb.format(-1 * 24 * 60 * 60 * 1200, long: true)
    assert_equal "-6 days", Ms::Rb.format(-6 * day, long: true)
  end

  def test_long_supports_weeks
    week = 7 * 24 * 60 * 60 * 1000

    assert_equal "1 week", Ms::Rb.format(1 * week, long: true)
    assert_equal "2 weeks", Ms::Rb.format(2 * week, long: true)

    assert_equal "-1 week", Ms::Rb.format(-1 * week, long: true)
    assert_equal "-2 weeks", Ms::Rb.format(-2 * week, long: true)
  end

  def test_long_supports_months
    month_ms = 30.4375 * 24 * 60 * 60 * 1000

    assert_equal "1 month", Ms::Rb.format(month_ms, long: true)
    assert_equal "1 month", Ms::Rb.format(30.4375 * 24 * 60 * 60 * 1200, long: true)
    assert_equal "10 months", Ms::Rb.format(30.4375 * 24 * 60 * 60 * 10_000, long: true)

    assert_equal "-1 month", Ms::Rb.format(-1 * month_ms, long: true)
    assert_equal "-1 month", Ms::Rb.format(-30.4375 * 24 * 60 * 60 * 1200, long: true)
    assert_equal "-10 months", Ms::Rb.format(-30.4375 * 24 * 60 * 60 * 10_000, long: true)
  end

  def test_long_supports_years
    year_ms = 365.25 * 24 * 60 * 60 * 1000

    assert_equal "1 year", Ms::Rb.format(year_ms + 1, long: true)
    assert_equal "1 year", Ms::Rb.format(365.25 * 24 * 60 * 60 * 1200 + 1, long: true)
    assert_equal "10 years", Ms::Rb.format(365.25 * 24 * 60 * 60 * 10_000 + 1, long: true)

    assert_equal "-1 year", Ms::Rb.format(-year_ms - 1, long: true)
    assert_equal "-1 year", Ms::Rb.format(-365.25 * 24 * 60 * 60 * 1200 - 1, long: true)
    assert_equal "-10 years", Ms::Rb.format(-365.25 * 24 * 60 * 60 * 10_000 - 1, long: true)
  end

  def test_long_rounding
    assert_equal "3 days", Ms::Rb.format(234_234_234, long: true)
    assert_equal "-3 days", Ms::Rb.format(-234_234_234, long: true)
  end

  #
  # format(number)
  #
  def test_short_should_not_throw
    assert_silent { Ms::Rb.format(500) }
  end

  def test_short_milliseconds
    assert_equal "500ms", Ms::Rb.format(500)
    assert_equal "-500ms", Ms::Rb.format(-500)
  end

  def test_short_seconds
    assert_equal "1s", Ms::Rb.format(1000)
    assert_equal "10s", Ms::Rb.format(10_000)
    assert_equal "-1s", Ms::Rb.format(-1000)
    assert_equal "-10s", Ms::Rb.format(-10_000)
  end

  def test_short_minutes
    assert_equal "1m", Ms::Rb.format(60 * 1000)
    assert_equal "10m", Ms::Rb.format(60 * 10_000)
    assert_equal "-1m", Ms::Rb.format(-60 * 1000)
    assert_equal "-10m", Ms::Rb.format(-60 * 10_000)
  end

  def test_short_hours
    assert_equal "1h", Ms::Rb.format(60 * 60 * 1000)
    assert_equal "10h", Ms::Rb.format(60 * 60 * 10_000)
    assert_equal "-1h", Ms::Rb.format(-60 * 60 * 1000)
    assert_equal "-10h", Ms::Rb.format(-60 * 60 * 10_000)
  end

  def test_short_days
    day = 24 * 60 * 60 * 1000
    assert_equal "1d", Ms::Rb.format(1 * day)
    assert_equal "6d", Ms::Rb.format(24 * 60 * 60 * 6000)
    assert_equal "-1d", Ms::Rb.format(-1 * day)
    assert_equal "-6d", Ms::Rb.format(-24 * 60 * 60 * 6000)
  end

  def test_short_weeks
    week = 7 * 24 * 60 * 60 * 1000
    assert_equal "1w", Ms::Rb.format(1 * week)
    assert_equal "2w", Ms::Rb.format(2 * week)
    assert_equal "-1w", Ms::Rb.format(-1 * week)
    assert_equal "-2w", Ms::Rb.format(-2 * week)
  end

  def test_short_months
    month_ms = 30.4375 * 24 * 60 * 60 * 1000

    assert_equal "1mo", Ms::Rb.format(month_ms)
    assert_equal "1mo", Ms::Rb.format(30.4375 * 24 * 60 * 60 * 1200)
    assert_equal "10mo", Ms::Rb.format(30.4375 * 24 * 60 * 60 * 10_000)

    assert_equal "-1mo", Ms::Rb.format(-month_ms)
    assert_equal "-1mo", Ms::Rb.format(-30.4375 * 24 * 60 * 60 * 1200)
    assert_equal "-10mo", Ms::Rb.format(-30.4375 * 24 * 60 * 60 * 10_000)
  end

  def test_short_years
    year_ms = 365.25 * 24 * 60 * 60 * 1000

    assert_equal "1y", Ms::Rb.format(year_ms + 1)
    assert_equal "1y", Ms::Rb.format(365.25 * 24 * 60 * 60 * 1200 + 1)
    assert_equal "10y", Ms::Rb.format(365.25 * 24 * 60 * 60 * 10_000 + 1)

    assert_equal "-1y", Ms::Rb.format(-year_ms - 1)
    assert_equal "-1y", Ms::Rb.format(-365.25 * 24 * 60 * 60 * 1200 - 1)
    assert_equal "-10y", Ms::Rb.format(-365.25 * 24 * 60 * 60 * 10_000 - 1)
  end

  def test_short_rounding
    assert_equal "3d", Ms::Rb.format(234_234_234)
    assert_equal "-3d", Ms::Rb.format(-234_234_234)
  end

  #
  # invalid inputs
  #
  def test_format_empty_raises
    assert_raises(ArgumentError) { Ms::Rb.format("") }
  end

  def test_format_nil_raises
    assert_raises(ArgumentError) { Ms::Rb.format(nil) }
  end

  def test_format_array_raises
    assert_raises(ArgumentError) { Ms::Rb.format([]) }
  end

  def test_format_hash_raises
    assert_raises(ArgumentError) { Ms::Rb.format({}) }
  end

  def test_format_nan_raises
    assert_raises(ArgumentError) { Ms::Rb.format(Float::NAN) }
  end

  def test_format_infinity_raises
    assert_raises(ArgumentError) { Ms::Rb.format(Float::INFINITY) }
    assert_raises(ArgumentError) { Ms::Rb.format(-Float::INFINITY) }
  end
end
