# frozen_string_literal: true

require_relative "rb/parser"
require_relative "rb/formatter"

module Ms
  module Rb
    module_function

    def ms(value, long: false)
      if value.is_a?(String)
        Parser.parse(value)
      elsif value.is_a?(Numeric)
        Formatter.format(value, long: long)
      else
        raise ArgumentError, "value must be a string or number"
      end
    end

    def parse(str)
      Parser.parse(str)
    end

    def parse_strict(str)
      Parser.parse_strict(str)
    end

    def format(ms, long: false)
      Formatter.format(ms, long: long)
    end
  end
end
