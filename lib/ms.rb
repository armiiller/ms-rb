# lib/ms.rb
# frozen_string_literal: true

require_relative "ms/rb"

module Ms
  module_function

  def ms(value, **options)
    Rb.ms(value, **options)
  end

  def parse(str)
    Rb.parse(str)
  end

  def parse_strict(str)
    Rb.parse_strict(str)
  end

  def format(ms, **options)
    Rb.format(ms, **options)
  end
end
