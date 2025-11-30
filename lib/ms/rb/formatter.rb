# frozen_string_literal: true

module Ms
  module Formatter
    # Exact integer constants (matching Vercel/ms)
    S = 1000
    M = S * 60
    H = M * 60
    D = H * 24
    W = D * 7
    Y = 31_557_600_000       # 365.25 days * 24h * 3600s * 1000ms
    MO = 2_629_800_000        # Y / 12

    module_function

    #
    # Public entry point — matches JS behavior
    #
    def format(ms, long: false)
      raise ArgumentError, "ms must be a number" unless ms.is_a?(Numeric)
      raise ArgumentError, "ms cannot be NaN or Infinity" unless ms.finite?

      long ? format_long(ms) : format_short(ms)
    end

    #
    # Short format — e.g., "3d", "4h"
    #
    def format_short(ms)
      ms_abs = ms.abs

      return "#{round(ms / Y.to_f)}y" if ms_abs >= Y
      return "#{round(ms / MO.to_f)}mo" if ms_abs >= MO
      return "#{round(ms / W.to_f)}w" if ms_abs >= W
      return "#{round(ms / D.to_f)}d" if ms_abs >= D
      return "#{round(ms / H.to_f)}h" if ms_abs >= H
      return "#{round(ms / M.to_f)}m" if ms_abs >= M
      return "#{round(ms / S.to_f)}s" if ms_abs >= S

      "#{ms}ms"
    end

    #
    # Long format — e.g., "3 days", "4 hours"
    #
    def format_long(ms)
      ms_abs = ms.abs

      return plural(ms, Y, "year") if ms_abs >= Y
      return plural(ms, MO, "month") if ms_abs >= MO
      return plural(ms, W, "week") if ms_abs >= W
      return plural(ms, D, "day") if ms_abs >= D
      return plural(ms, H, "hour") if ms_abs >= H
      return plural(ms, M, "minute") if ms_abs >= M
      return plural(ms, S, "second") if ms_abs >= S

      "#{ms} ms"
    end

    #
    # Pluralization helper — matches JS exactly
    #
    def plural(ms, unit_ms, name)
      value = round(ms / unit_ms.to_f)
      suffix = ((value.abs == 1) ? "" : "s")
      "#{value} #{name}#{suffix}"
    end

    #
    # JS-compatible rounding
    #
    def round(num)
      # JS Math.round behavior is equivalent to Ruby round(0)
      num.round
    end
  end
end
