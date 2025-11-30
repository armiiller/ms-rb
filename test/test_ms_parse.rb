# frozen_string_literal: true

require_relative "test_helper"

class TestMsParse < Minitest::Test
  #
  # parse(string)
  #
  def test_should_not_throw_on_valid_string
    assert_silent { Ms::Rb.parse("1m") }
  end

  def test_preserve_ms_if_no_unit
    assert_equal 100, Ms::Rb.parse("100")
  end

  def test_convert_m_to_ms
    assert_equal 60_000, Ms::Rb.parse("1m")
  end

  def test_convert_h_to_ms
    assert_equal 3_600_000, Ms::Rb.parse("1h")
  end

  def test_convert_d_to_ms
    assert_equal 172_800_000, Ms::Rb.parse("2d")
  end

  def test_convert_w_to_ms
    assert_equal 1_814_400_000, Ms::Rb.parse("3w")
  end

  def test_convert_s_to_ms
    assert_equal 1000, Ms::Rb.parse("1s")
  end

  def test_convert_ms_to_ms
    assert_equal 100, Ms::Rb.parse("100ms")
  end

  def test_convert_y_to_ms
    assert_equal 31_557_600_000, Ms::Rb.parse("1y")
  end

  def test_decimal_hours
    assert_equal 5_400_000, Ms::Rb.parse("1.5h")
  end

  def test_multiple_spaces
    assert_equal 1000, Ms::Rb.parse("1   s")
  end

  def test_returns_nan_if_invalid
    assert Ms::Rb.parse("☃").nan?
    assert Ms::Rb.parse("10-.5").nan?
    assert Ms::Rb.parse("foo").nan?
  end

  def test_case_insensitive
    assert_equal 1_672_552_800_000, Ms::Rb.parse("53 YeArS")
    assert_equal 32_054_400_000, Ms::Rb.parse("53 WeEkS")
    assert_equal 4_579_200_000, Ms::Rb.parse("53 DaYS")
    assert_equal 190_800_000, Ms::Rb.parse("53 HoUrs")
    assert_equal 53, Ms::Rb.parse("53 MiLliSeCondS")
  end

  def test_starting_with_dot
    assert_equal 0.5, Ms::Rb.parse(".5ms")
  end

  def test_negative_integers
    assert_equal(-100, Ms::Rb.parse("-100ms"))
  end

  def test_negative_decimals
    assert_equal(-5_400_000, Ms::Rb.parse("-1.5h"))
    assert_equal(-37_800_000, Ms::Rb.parse("-10.5h"))
  end

  def test_negative_decimal_starting_with_dot
    assert_equal(-1_800_000, Ms::Rb.parse("-.5h"))
  end

  #
  # long strings
  #
  def test_long_string_should_not_throw
    assert_silent { Ms::Rb.parse("53 milliseconds") }
  end

  def test_convert_milliseconds
    assert_equal 53, Ms::Rb.parse("53 milliseconds")
  end

  def test_convert_msecs
    assert_equal 17, Ms::Rb.parse("17 msecs")
  end

  def test_convert_sec
    assert_equal 1000, Ms::Rb.parse("1 sec")
  end

  def test_convert_min
    assert_equal 60_000, Ms::Rb.parse("1 min")
  end

  def test_convert_hr
    assert_equal 3_600_000, Ms::Rb.parse("1 hr")
  end

  def test_convert_days_word
    assert_equal 172_800_000, Ms::Rb.parse("2 days")
  end

  def test_convert_weeks_word
    assert_equal 604_800_000, Ms::Rb.parse("1 week")
  end

  def test_convert_months_word
    assert_equal 2_629_800_000, Ms::Rb.parse("1 month")
  end

  def test_convert_years_word
    assert_equal 31_557_600_000, Ms::Rb.parse("1 year")
  end

  def test_decimal_hours_long
    assert_equal 5_400_000, Ms::Rb.parse("1.5 hours")
  end

  def test_negative_integer_long
    assert_equal(-100, Ms::Rb.parse("-100 milliseconds"))
  end

  def test_negative_decimals_long
    assert_equal(-5_400_000, Ms::Rb.parse("-1.5 hours"))
  end

  def test_negative_decimal_starting_with_dot_long
    assert_equal(-1_800_000, Ms::Rb.parse("-.5 hr"))
  end

  #
  # invalid inputs
  #
  def test_parse_empty_string_raises
    assert_raises(ArgumentError) { Ms::Rb.parse("") }
  end

  def test_parse_too_long_string_raises
    str = "▲" * 101
    assert_raises(ArgumentError) { Ms::Rb.parse(str) }
  end

  def test_parse_nil_raises
    assert_raises(ArgumentError) { Ms::Rb.parse(nil) }
  end

  def test_parse_undefined_equivalent_raises
    # JS undefined ≈ Ruby no-arg or nil
    assert_raises(ArgumentError) { Ms::Rb.parse(nil) }
  end

  def test_parse_array_raises
    assert_raises(ArgumentError) { Ms::Rb.parse([]) }
  end

  def test_parse_hash_raises
    assert_raises(ArgumentError) { Ms::Rb.parse({}) }
  end

  def test_parse_nan_raises
    assert_raises(ArgumentError) { Ms::Rb.parse(Float::NAN) }
  end

  def test_parse_infinity_raises
    assert_raises(ArgumentError) { Ms::Rb.parse(Float::INFINITY) }
    assert_raises(ArgumentError) { Ms::Rb.parse(-Float::INFINITY) }
  end
end
