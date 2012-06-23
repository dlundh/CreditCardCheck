class CreditCardCheck
  def get_type(number)
    n = number.to_s
    if (n[0..3] == "6011")    
      return "Discover"
    elsif (n[0..1] == "34" || n[0..1] == "37")
      return "AMEX"
    elsif (n[0..1].to_i >= 51 && n[0..1].to_i <= 55)
      return "MasterCard"
    elsif (n[0] == "4")
      return "VISA"
    else
      return "Unknown"
    end    
  end
  
  def validate(number)    
      cc_array = number.to_s.gsub(/\s+/, "").reverse.split('').collect! {|n| n.to_i}      
      value = 0
      
      cc_array.each_with_index do |digit, i|             
        if (i % 2 == 0) 
          value += digit
        else
          if (digit * 2 >= 10)
            digits = (digit * 2).to_s 
            value += digits[0].to_i + digits[1].to_i
          else
            value += digit * 2
          end        
        end        
      end      
      if (value % 10 == 0)
        return "valid"
      else
        return "invalid"
      end
  end 
  
  def input
    $/ = "END"  
    puts "Enter credit card numbers, one per line. End by typing END:"
    @cc_numbers = gets
    self.display_results()
  end
  
  def display_results
    cc_array = @cc_numbers.chomp("\nEND").split(/\n/)
    cc_array.each do |cc_number|        
        card = "#{self.get_type(cc_number)}: #{cc_number.gsub(/\s+/, "")}"
        validation = self.validate(cc_number) 
        puts("#{card.ljust(28)} (#{validation})")
    end 
  end
end