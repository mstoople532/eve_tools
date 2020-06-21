class FitParser
  attr_reader :fitting

  Response = Struct.new(:parsed_fitting, keyword_init: true)

  def initialize(fitting:)
    @fitting = fitting
  end


  def call
    eft_data = Array.new
    fitting.each_line{ |line| eft_data << line.chomp }

    eft_data.map! do |line|

      if line.match?(/[x]\d+/)
        number_of_items = line.match(/[x]\d+/).to_s.match(/\d+/).to_s.to_i
        line.gsub!(/[x]\d+/, "")
        line.strip!

        (number_of_items - 1).times do
          eft_data << line
        end
        line
      else
        line
      end
    end

    eft_data.reject! { |line| line.empty? }
    eft_data.reject! { |line| line.include?("[") } 

    respond(eft_data)
  end

  def respond(eft_data)
    Response.new(parsed_fitting: eft_data)
  end
end
