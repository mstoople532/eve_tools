class FitComparer
  attr_reader :old_fitting, :new_fitting
  attr_accessor :difference

  Response = Struct.new(:sell, :buy, :keep, keyword_init: true)

  def initialize(old_fitting:, new_fitting:)
    @old_fitting = old_fitting
    @new_fitting = new_fitting
    @difference = Hash.new
  end

  def call
    new_tally = new_fitting.tally
    old_tally = old_fitting.tally

    old_tally.map do |item, count|
      if new_tally.include?(item)
        new_count = new_tally.fetch(item)
        amount_needed = new_count - count
        difference[item] = amount_needed
      else
        difference[item] = count
      end
    end
    respond
  end

  def respond
    Response.new(
      sell: calculate_to_sell(difference),
      buy: calculate_to_buy(difference),
      keep: calculate_to_keep(difference)
    )
  end
  
  private

  def calculate_to_sell(list)
    list.select{ |k,v| v < 0 }
  end

  def calculate_to_buy(list)
    list.select{ |k,v| v > 0 }
  end

  def calculate_to_keep(list)
    list.select{ |k,v| v == 0 }
  end

end
