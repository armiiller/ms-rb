# frozen_string_literal: true

require_relative "test_helper"

class TestMsParseStrict < Minitest::Test
  #
  # parseStrict(string)
  #
  def test_should_not_throw
    assert_silent { Ms::Rb.parse_strict("1m") }
  end

  def test_preserve_ms
    assert_equal 100, Ms::Rb.parse_strict("100")
  end

  def test_convert_m_to_ms
    assert_equal 60_000, Ms::Rb.parse_strict("1m")
  end

  def test_convert_h_to_ms
    assert_equal 3_600_000, Ms::Rb.parse_strict("1h")
  end

  def test_convert_d_to_ms
    assert_equal 172_800_000, Ms::Rb.parse_strict("2d")
  end

  def test_convert_w_to_ms
    assert_equal 1_814_400_000, Ms::Rb.parse_strict("3w")
  end

  def test_convert_s_to_ms
    assert_equal 1000, Ms::Rb.parse_strict("1s")
  end

  def test_convert_ms_to_ms
    assert_equal 100, Ms::Rb.parse_strict("100ms")
  end

  def test_convert_mo_to_ms
    assert_equal 2_629_800_000, Ms::Rb.parse_strict("1mo")
  end

  def test_convert_y_to_ms
    assert_equal 31_557_600_000, Ms::Rb.parse_strict("1y")
  end

  def test_decimal_hours
    assert_equal 5_400_000, Ms::Rb.parse_strict("1.5h")
  end

  def test_multiple_spaces
    assert_equal 1000, Ms::Rb.parse_strict("1   s")
  end

  def test_invalid_returns_nan
    assert Ms::Rb.parse_strict("☃").nan?
    assert Ms::Rb.parse_strict("10-.5").nan?
    assert Ms::Rb.parse_strict("foo").nan?
  end

  def test_case_insensitive
    assert_equal 1_672_552_800_000, Ms::Rb.parse_strict("53 YeArS")
    assert_equal 32_054_400_000, Ms::Rb.parse_strict("53 WeEkS")
    assert_equal 4_579_200_000, Ms::Rb.parse_strict("53 DaYS")
    assert_equal 190_800_000, Ms::Rb.parse_strict("53 HoUrs")
    assert_equal 53, Ms::Rb.parse_strict("53 MiLliSeCondS")
  end

  def test_starting_with_dot
    assert_in_delta 0.5, Ms::Rb.parse_strict(".5ms")
  end

  def test_negative_integers
    assert_equal(-100, Ms::Rb.parse_strict("-100ms"))
  end

  def test_negative_decimals
    assert_equal(-5_400_000, Ms::Rb.parse_strict("-1.5h"))
    assert_equal(-37_800_000, Ms::Rb.parse_strict("-10.5h"))
  end

  def test_negative_decimal_starting_with_dot
    assert_equal(-1_800_000, Ms::Rb.parse_strict("-.5h"))
  end

  #
  # parseStrict(long string)
  #
  def test_long_string_should_not_throw
    assert_silent { Ms::Rb.parse_strict("53 milliseconds") }
  end

  def test_long_milliseconds
    assert_equal 53, Ms::Rb.parse_strict("53 milliseconds")
  end

  def test_long_msecs
    assert_equal 17, Ms::Rb.parse_strict("17 msecs")
  end

  def test_long_sec
    assert_equal 1000, Ms::Rb.parse_strict("1 sec")
  end

  def test_long_min
    assert_equal 60_000, Ms::Rb.parse_strict("1 min")
  end

  def test_long_hr
    assert_equal 3_600_000, Ms::Rb.parse_strict("1 hr")
  end

  def test_long_days
    assert_equal 172_800_000, Ms::Rb.parse_strict("2 days")
  end

  def test_long_weeks
    assert_equal 604_800_000, Ms::Rb.parse_strict("1 week")
  end

  def test_long_months
    assert_equal 2_629_800_000, Ms::Rb.parse_strict("1 month")
  end

  def test_long_years
    assert_equal 31_557_600_000, Ms::Rb.parse_strict("1 year")
  end

  def test_long_decimal_hours
    assert_equal 5_400_000, Ms::Rb.parse_strict("1.5 hours")
  end

  def test_long_negative_integer
    assert_equal(-100, Ms::Rb.parse_strict("-100 milliseconds"))
  end

  def test_long_negative_decimal
    assert_equal(-5_400_000, Ms::Rb.parse_strict("-1.5 hours"))
  end

  def test_long_negative_decimal_starting_with_dot
    assert_equal(-1_800_000, Ms::Rb.parse_strict("-.5 hr"))
  end

  #
  # invalid inputs
  #
  def test_empty_string_raises
    assert_raises(ArgumentError) { Ms::Rb.parse_strict("") }
  end

  def test_string_over_100_chars_raises
    long = "▲" * 101
    assert_raises(ArgumentError) { Ms::Rb.parse_strict(long) }
  end

  def test_nil_raises
    assert_raises(ArgumentError) { Ms::Rb.parse_strict(nil) }
  end

  def test_array_raises
    assert_raises(ArgumentError) { Ms::Rb.parse_strict([]) }
  end

  def test_hash_raises
    assert_raises(ArgumentError) { Ms::Rb.parse_strict({}) }
  end

  def test_nan_raises
    assert_raises(ArgumentError) { Ms::Rb.parse_strict(Float::NAN) }
  end

  def test_infinity_raises
    assert_raises(ArgumentError) { Ms::Rb.parse_strict(Float::INFINITY) }
    assert_raises(ArgumentError) { Ms::Rb.parse_strict(-Float::INFINITY) }
  end
end
