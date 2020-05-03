class FitAuditor
  attr_reader :old_fitting, :new_fitting

  def initialize(old_fitting:, new_fitting:)
    @old_fitting = old_fitting
    @new_fitting = new_fitting
  end

  def call
    old = parse_fitting(old_fitting)
    new = parse_fitting(new_fitting)
    FitComparer.new(old_fitting: old[:parsed_fitting], new_fitting: new[:parsed_fitting]).call
  end

  def parse_fitting(fitting)
    FitParser.new(fitting: fitting).call
  end
end

