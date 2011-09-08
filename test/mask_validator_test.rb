require 'test_helper'

class MaskValidatorTest < Test::Unit::TestCase
  def test_phones
    create_asserts('phone')

    assert_invalid '4852458787'
    assert_invalid '48 9865 4879'
    assert_invalid "(48)98956698"
    assert_invalid "(48) 9874-45169"
    assert_valid   "(48) 9874-4569"
  end

  def test_acronyms
    create_asserts('acronym')

    assert_invalid '1qw1'
    assert_valid '1gd'
    assert_valid '666'
    assert_valid 'zzz'
  end

  def test_alphanumerics
    create_asserts('alphanumeric')

    assert_invalid '999999'
    assert_invalid 'QQQQQQ'
    assert_invalid '666AAAA'
    assert_invalid '666AAA'
    assert_valid 'AAA666'
  end

  protected

  def create_asserts(attr)
    class_eval <<-RUBY
      def assert_valid(value)
        assert person(:#{attr} => value).valid?
      end

      def assert_invalid(value)
        assert person(:#{attr} => value).invalid?
      end
    RUBY
  end

  def person(attributes = {})
    Person.new(attributes)
  end
end
