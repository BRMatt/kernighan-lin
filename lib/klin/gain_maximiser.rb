
class Klin::GainMaximiser


  def maximise(swaps)
    current_gain = 0
    gains = swaps.map { |swap| current_gain += swap.gain }

    max_gain = gains.max

    [gains.rindex(max_gain), max_gain]
  end
end
