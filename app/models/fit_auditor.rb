class FitAuditor
  attr_accessor :buy, :sell, :keep
  def initialize(buy:, sell:, keep:)
    @buy = buy
    @sell = sell
    @keep = keep
  end

end
