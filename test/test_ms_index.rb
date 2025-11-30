# frozen_string_literal: true

require_relative "test_helper"

class TestMsIndex < Minitest::Test
  #
  # ms(string)
  #
  def test_string_should_not_throw
    assert_silent { Ms::Rb.ms("1m") }
  end

  def test_preserve_ms
    assert_equal 100, Ms::Rb.ms("100")
  end

  def test_convert_m_to_ms
    assert_equal 60_000, Ms::Rb.ms("1m")
  end

  def test_convert_h_to_ms
    assert_equal 3_600_000, Ms::Rb.ms("1h")
  end

  def test_convert_d_to_ms
    assert_equal 172_800_000, Ms::Rb.ms("2d")
  end

  def test_convert_w_to_ms
    assert_equal 1_814_400_000, Ms::Rb.ms("3w")
  end

  def test_convert_s_to_ms
    assert_equal 1000, Ms::Rb.ms("1s")
  end

  def test_convert_ms_to_ms
    assert_equal 100, Ms::Rb.ms("100ms")
  end

  def test_convert_y_to_ms
    assert_equal 31_557_600_000, Ms::Rb.ms("1y")
  end

  def test_decimal_hours
    assert_equal 5_400_000, Ms::Rb.ms("1.5h")
  end

  def test_multiple_spaces
    assert_equal 1000, Ms::Rb.ms("1   s")
  end

  def test_invalid_returns_nan
    assert Ms::Rb.ms("☃").nan?
    assert Ms::Rb.ms("10-.5").nan?
    assert Ms::Rb.ms("ms").nan?
  end

  def test_case_insensitive
    assert_equal 5_400_000, Ms::Rb.ms("1.5H")
  end

  def test_starting_with_dot
    assert_equal 0.5, Ms::Rb.ms(".5ms")
  end

  def test_negative_integer
    assert_equal(-100, Ms::Rb.ms("-100ms"))
  end

  def test_negative_decimals
    assert_equal(-5_400_000, Ms::Rb.ms("-1.5h"))
    assert_equal(-37_800_000, Ms::Rb.ms("-10.5h"))
  end

  def test_negative_decimal_starting_with_dot
    assert_equal(-1_800_000, Ms::Rb.ms("-.5h"))
  end

  #
  # ms(long string)
  #
  def test_long_string_should_not_throw
    assert_silent { Ms::Rb.ms("53 milliseconds") }
  end

  def test_long_milliseconds
    assert_equal 53, Ms::Rb.ms("53 milliseconds")
  end

  def test_long_msecs
    assert_equal 17, Ms::Rb.ms("17 msecs")
  end

  def test_long_sec
    assert_equal 1000, Ms::Rb.ms("1 sec")
  end

  def test_long_min
    assert_equal 60_000, Ms::Rb.ms("1 min")
  end

  def test_long_hr
    assert_equal 3_600_000, Ms::Rb.ms("1 hr")
  end

  def test_long_days
    assert_equal 172_800_000, Ms::Rb.ms("2 days")
  end

  def test_long_weeks
    assert_equal 604_800_000, Ms::Rb.ms("1 week")
  end

  def test_long_years
    assert_equal 31_557_600_000, Ms::Rb.ms("1 year")
  end

  def test_long_decimal_hours
    assert_equal 5_400_000, Ms::Rb.ms("1.5 hours")
  end

  def test_long_negative_integer
    assert_equal(-100, Ms::Rb.ms("-100 milliseconds"))
  end

  def test_long_negative_decimal
    assert_equal(-5_400_000, Ms::Rb.ms("-1.5 hours"))
  end

  def test_long_negative_decimal_starting_with_dot
    assert_equal(-1_800_000, Ms::Rb.ms("-.5 hr"))
  end

  #
  # ms(number, { long: true })
  #
  def test_number_long_should_not_throw
    assert_silent { Ms::Rb.ms(500, long: true) }
  end

  def test_number_long_milliseconds
    assert_equal "500 ms", Ms::Rb.ms(500, long: true)
    assert_equal "-500 ms", Ms::Rb.ms(-500, long: true)
  end

  def test_number_long_seconds
    assert_equal "1 second", Ms::Rb.ms(1000, long: true)
    assert_equal "1 second", Ms::Rb.ms(1200, long: true)
    assert_equal "10 seconds", Ms::Rb.ms(10_000, long: true)

    assert_equal "-1 second", Ms::Rb.ms(-1000, long: true)
    assert_equal "-1 second", Ms::Rb.ms(-1200, long: true)
    assert_equal "-10 seconds", Ms::Rb.ms(-10_000, long: true)
  end

  def test_number_long_minutes
    assert_equal "1 minute", Ms::Rb.ms(60 * 1000, long: true)
    assert_equal "1 minute", Ms::Rb.ms(60 * 1200, long: true)
    assert_equal "10 minutes", Ms::Rb.ms(60 * 10_000, long: true)

    assert_equal "-1 minute", Ms::Rb.ms(-60 * 1000, long: true)
    assert_equal "-1 minute", Ms::Rb.ms(-60 * 1200, long: true)
    assert_equal "-10 minutes", Ms::Rb.ms(-60 * 10_000, long: true)
  end

  def test_number_long_hours
    assert_equal "1 hour", Ms::Rb.ms(60 * 60 * 1000, long: true)
    assert_equal "1 hour", Ms::Rb.ms(60 * 60 * 1200, long: true)
    assert_equal "10 hours", Ms::Rb.ms(60 * 60 * 10_000, long: true)

    assert_equal "-1 hour", Ms::Rb.ms(-60 * 60 * 1000, long: true)
    assert_equal "-1 hour", Ms::Rb.ms(-60 * 60 * 1200, long: true)
    assert_equal "-10 hours", Ms::Rb.ms(-60 * 60 * 10_000, long: true)
  end

  def test_number_long_days
    day = 24 * 60 * 60 * 1000
    assert_equal "1 day", Ms::Rb.ms(day, long: true)
    assert_equal "1 day", Ms::Rb.ms(1 * 24 * 60 * 60 * 1200, long: true)
    assert_equal "6 days", Ms::Rb.ms(6 * day, long: true)

    assert_equal "-1 day", Ms::Rb.ms(-day, long: true)
    assert_equal "-1 day", Ms::Rb.ms(-1 * 24 * 60 * 60 * 1200, long: true)
    assert_equal "-6 days", Ms::Rb.ms(-6 * day, long: true)
  end

  def test_number_long_weeks
    week = 7 * 24 * 60 * 60 * 1000
    assert_equal "1 week", Ms::Rb.ms(week, long: true)
    assert_equal "2 weeks", Ms::Rb.ms(2 * week, long: true)

    assert_equal "-1 week", Ms::Rb.ms(-week, long: true)
    assert_equal "-2 weeks", Ms::Rb.ms(-2 * week, long: true)
  end

  def test_number_long_months
    month_ms = 30.4375 * 24 * 60 * 60 * 1000

    assert_equal "1 month", Ms::Rb.ms(month_ms, long: true)
    assert_equal "1 month", Ms::Rb.ms(30.4375 * 24 * 60 * 60 * 1200, long: true)
    assert_equal "10 months", Ms::Rb.ms(30.4375 * 24 * 60 * 60 * 10_000, long: true)

    assert_equal "-1 month", Ms::Rb.ms(-month_ms, long: true)
    assert_equal "-1 month", Ms::Rb.ms(-30.4375 * 24 * 60 * 60 * 1200, long: true)
    assert_equal "-10 months", Ms::Rb.ms(-30.4375 * 24 * 60 * 60 * 10_000, long: true)
  end

  def test_number_long_years
    year_ms = 365.25 * 24 * 60 * 60 * 1000

    assert_equal "1 year", Ms::Rb.ms(year_ms + 1, long: true)
    assert_equal "1 year", Ms::Rb.ms(365.25 * 24 * 60 * 60 * 1200 + 1, long: true)
    assert_equal "10 years", Ms::Rb.ms(365.25 * 24 * 60 * 60 * 10_000 + 1, long: true)

    assert_equal "-1 year", Ms::Rb.ms(-year_ms - 1, long: true)
    assert_equal "-1 year", Ms::Rb.ms(-365.25 * 24 * 60 * 60 * 1200 - 1, long: true)
    assert_equal "-10 years", Ms::Rb.ms(-365.25 * 24 * 60 * 60 * 10_000 - 1, long: true)
  end

  def test_number_long_rounding
    assert_equal "3 days", Ms::Rb.ms(234_234_234, long: true)
    assert_equal "-3 days", Ms::Rb.ms(-234_234_234, long: true)
  end

  #
  # ms(number)
  #
  def test_short_number_should_not_throw
    assert_silent { Ms::Rb.ms(500) }
  end

  def test_short_milliseconds
    assert_equal "500ms", Ms::Rb.ms(500)
    assert_equal "-500ms", Ms::Rb.ms(-500)
  end

  def test_short_seconds
    assert_equal "1s", Ms::Rb.ms(1000)
    assert_equal "10s", Ms::Rb.ms(10_000)
    assert_equal "-1s", Ms::Rb.ms(-1000)
    assert_equal "-10s", Ms::Rb.ms(-10_000)
  end

  def test_short_minutes
    assert_equal "1m", Ms::Rb.ms(60 * 1000)
    assert_equal "10m", Ms::Rb.ms(60 * 10_000)
    assert_equal "-1m", Ms::Rb.ms(-60 * 1000)
    assert_equal "-10m", Ms::Rb.ms(-60 * 10_000)
  end

  def test_short_hours
    assert_equal "1h", Ms::Rb.ms(60 * 60 * 1000)
    assert_equal "10h", Ms::Rb.ms(60 * 60 * 10_000)
    assert_equal "-1h", Ms::Rb.ms(-60 * 60 * 1000)
    assert_equal "-10h", Ms::Rb.ms(-60 * 60 * 10_000)
  end

  def test_short_days
    day = 24 * 60 * 60 * 1000
    assert_equal "1d", Ms::Rb.ms(day)
    assert_equal "6d", Ms::Rb.ms(24 * 60 * 60 * 6000)
    assert_equal "-1d", Ms::Rb.ms(-day)
    assert_equal "-6d", Ms::Rb.ms(-24 * 60 * 60 * 6000)
  end

  def test_short_weeks
    week = 7 * 24 * 60 * 60 * 1000
    assert_equal "1w", Ms::Rb.ms(week)
    assert_equal "2w", Ms::Rb.ms(2 * week)
    assert_equal "-1w", Ms::Rb.ms(-1 * week)
    assert_equal "-2w", Ms::Rb.ms(-2 * week)
  end

  def test_short_months
    month_ms = 30.4375 * 24 * 60 * 60 * 1000

    assert_equal "1mo", Ms::Rb.ms(month_ms)
    assert_equal "1mo", Ms::Rb.ms(30.4375 * 24 * 60 * 60 * 1200)
    assert_equal "10mo", Ms::Rb.ms(30.4375 * 24 * 60 * 60 * 10_000)

    assert_equal "-1mo", Ms::Rb.ms(-month_ms)
    assert_equal "-1mo", Ms::Rb.ms(-30.4375 * 24 * 60 * 60 * 1200)
    assert_equal "-10mo", Ms::Rb.ms(-30.4375 * 24 * 60 * 60 * 10_000)
  end

  def test_short_years
    year_ms = 365.25 * 24 * 60 * 60 * 1000

    assert_equal "1y", Ms::Rb.ms(year_ms + 1)
    assert_equal "1y", Ms::Rb.ms(365.25 * 24 * 60 * 60 * 1200 + 1)
    assert_equal "10y", Ms::Rb.ms(365.25 * 24 * 60 * 60 * 10_000 + 1)

    assert_equal "-1y", Ms::Rb.ms(-year_ms - 1)
    assert_equal "-1y", Ms::Rb.ms(-365.25 * 24 * 60 * 60 * 1200 - 1)
    assert_equal "-10y", Ms::Rb.ms(-365.25 * 24 * 60 * 60 * 10_000 - 1)
  end

  def test_short_rounding
    assert_equal "3d", Ms::Rb.ms(234_234_234)
    assert_equal "-3d", Ms::Rb.ms(-234_234_234)
  end

  #
  # invalid inputs
  #
  def test_ms_empty_string_raises
    assert_raises(ArgumentError) { Ms::Rb.ms("") }
  end

  def test_ms_nil_raises
    assert_raises(ArgumentError) { Ms::Rb.ms(nil) }
  end

  def test_ms_array_raises
    assert_raises(ArgumentError) { Ms::Rb.ms([]) }
  end

  def test_ms_hash_raises
    assert_raises(ArgumentError) { Ms::Rb.ms({}) }
  end

  def test_ms_nan_raises
    assert_raises(ArgumentError) { Ms::Rb.ms(Float::NAN) }
  end

  def test_ms_infinity_raises
    assert_raises(ArgumentError) { Ms::Rb.ms(Float::INFINITY) }
    assert_raises(ArgumentError) { Ms::Rb.ms(-Float::INFINITY) }
  end
end
