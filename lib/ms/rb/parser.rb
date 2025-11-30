# frozen_string_literal: true

module Ms
  module Rb
    module Parser
      module Units
        S  = 1000
        M  = S * 60
        H  = M * 60
        D  = H * 24
        W  = D * 7
        Y  = D * 365.25
        MO = Y / 12.0
      end

      REGEX = /
        ^\s*
        (?<value>-?\d*\.?\d+)\s*
        (?<unit>
          milliseconds?|msecs?|ms|
          seconds?|secs?|s|
          minutes?|mins?|min|m|
          hours?|hrs?|hr|h|
          days?|day|d|
          weeks?|week|w|
          months?|month|mo|
          years?|year|yrs?|yr|y
        )?
        \s*$
      /ix

      module_function

      def parse(str)
        unless str.is_a?(String) && !str.empty? && str.length <= 100
          raise ArgumentError,
                "Value provided must be a string between 1 and 99 chars. value=#{str.inspect}"
        end

        match = REGEX.match(str)
        return Float::NAN unless match

        value = match[:value].to_f
        unit  = (match[:unit] || "ms").downcase

        case unit
        when "years", "year", "yrs", "yr", "y"
          value * Units::Y
        when "months", "month", "mo"
          value * Units::MO
        when "weeks", "week", "w"
          value * Units::W
        when "days", "day", "d"
          value * Units::D
        when "hours", "hour", "hrs", "hr", "h"
          value * Units::H
        when "minutes", "minute", "mins", "min", "m"
          value * Units::M
        when "seconds", "second", "secs", "sec", "s"
          value * Units::S
        when "milliseconds", "millisecond", "msecs", "msec", "ms"
          value
        else
          raise ArgumentError, "Unknown unit #{unit.inspect} for value=#{str.inspect}"
        end
      end

      def parse_strict(value)
        parse(value)
      end
    end
  end
end
