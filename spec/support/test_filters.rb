# frozen_string_literal: true

module TestFilters
  def success_filter(val)
    "Success: #{val}"
  end

  def failure_filter(val)
    raise ArgumentError, val
  end
end
