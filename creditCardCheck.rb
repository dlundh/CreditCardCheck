class CreditCardCheck
  def get_type(number)
    length = number.gsub(/\s+/, "").size
    if (length == 16 && number =~ /^6011/)
      return "Discover"
    elsif (length == 15 && number =~ /^(34|37)/)
      return "AMEX"
    elsif (length == 16 && number =~ /^5[1-5]/)
      return "MasterCard"
    elsif (length == 16 && number =~ /^4/)
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
    cc_numbers = gets
    return cc_numbers
  end
  
  def display_results(cc_numbers)
    cc_array = cc_numbers.chomp("\nEND").split(/\n/)
    cc_array.each do |cc_number|        
        card = "#{self.get_type(cc_number)}: #{cc_number.gsub(/\s+/, "")}"
        validation = self.validate(cc_number) 
        puts("#{card.ljust(28)} (#{validation})")
    end 
  end
end