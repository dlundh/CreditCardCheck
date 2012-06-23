require_relative "creditCardCheck"
require "test/unit"

class TestCreditCardCheck < Test::Unit::TestCase
 
  def test_validation
    assert_equal("valid", CreditCardCheck.new.validate(4111111111111111))  
    assert_equal("invalid", CreditCardCheck.new.validate(5105105105105106))
    assert_equal("valid", CreditCardCheck.new.validate(5237111701838632))
    assert_equal("valid", CreditCardCheck.new.validate("5105 1051 0510 5100"))
  end
  
  def test_type
    assert_equal("AMEX", CreditCardCheck.new.get_type(378282246310005))
    assert_equal("Discover", CreditCardCheck.new.get_type(6011111111111117))
    assert_equal("Unknown", CreditCardCheck.new.get_type("9011 1111 1111 1117"))
    assert_equal("MasterCard", CreditCardCheck.new.get_type("5105 1051 0510 5106"))
  end
  
  def test_validation_failure
    #assert_equal("valid", CreditCardCheck.new.validate(5105105105105106), "Validation failed!")
  end
 
end