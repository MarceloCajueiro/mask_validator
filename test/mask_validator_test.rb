require 'test_helper'

class MaskValidatorTest < Test::Unit::TestCase
  def test_phones
    person = Person.new(valid_attributes)
    assert person.valid?

    person.phone = nil
    assert person.valid?

    person.phone = ''
    assert person.valid?

    person.phone = '(48) 9874-4569'
    assert person.valid?
    
    person.phone = '4852458787'
    assert person.invalid?
    assert_equal false, person.errors[:phone].empty?, "Expected to phone have errors. Details: #{person.errors[:phone]}"

    person.phone = '48 9865 4879'
    assert person.invalid?
    assert_equal false, person.errors[:phone].empty?, "Expected to phone have errors. Details: #{person.errors[:phone]}"

    person.phone = '(48)98956698'
    assert person.invalid?
    assert_equal false, person.errors[:phone].empty?, "Expected to phone have errors. Details: #{person.errors[:phone]}"

    person.phone = '(48) 9874-45169'
    assert person.invalid?
    assert_equal false, person.errors[:phone].empty?, "Expected to phone have errors. Details: #{person.errors[:phone]}"
  end

  def test_acronyms
    person = Person.new(valid_attributes)
    assert person.valid?

    person.acronym = nil
    assert person.valid?

    person.acronym = ''
    assert person.valid?

    person.acronym = '1gd'
    assert person.valid?

    person.acronym = '666'
    assert person.valid?

    person.acronym = 'zzz'
    assert person.valid?
    
    person.acronym = '1qw1'
    assert person.invalid?
    assert_equal false, person.errors[:acronym].empty?, "Expected to acronym have errors. Details: #{person.errors[:acronym]}"
  end

  def test_alphanumerics
    person = Person.new(valid_attributes)
    assert person.valid?

    person.alphanumeric = nil
    assert person.valid?

    person.alphanumeric = ''
    assert person.valid?
    
    person.alphanumeric = '999999'
    assert person.invalid?
    assert_equal false, person.errors[:alphanumeric].empty?, "Expected to alphanumeric have errors. Details: #{person.errors[:alphanumeric]}"

    person.alphanumeric = 'QQQQQQ'
    assert person.invalid?
    assert_equal false, person.errors[:alphanumeric].empty?, "Expected to alphanumeric have errors. Details: #{person.errors[:alphanumeric]}"

    person.alphanumeric = '666AAAA'
    assert person.invalid?
    assert_equal false, person.errors[:alphanumeric].empty?, "Expected to alphanumeric have errors. Details: #{person.errors[:alphanumeric]}"

    person.alphanumeric = '666AAA'
    assert person.invalid?
    assert_equal false, person.errors[:alphanumeric].empty?, "Expected to alphanumeric have errors. Details: #{person.errors[:alphanumeric]}"
  end

  def test_not_allow_blank
    person = Person.new(valid_attributes)
    assert person.valid?

    person.post_code = nil
    assert person.valid?

    person.post_code = ''
    assert person.invalid?
    assert_equal false, person.errors[:post_code].empty?, "Expected to post_code have errors. Details: #{person.errors[:post_code]}"
  end

  def test_not_allow_nil
    person = Person.new(valid_attributes)
    assert person.valid?

    person.fax = ''
    assert person.valid?

    person.fax = nil
    assert person.invalid?
    assert_equal false, person.errors[:fax].empty?, "Expected to fax have errors. Details: #{person.errors[:fax]}"
  end

  protected
  def valid_attributes
    {
      phone: "(12) 3456-7890",
      fax: "(12) 3456-7890",
      acronym: "ABC",
      alphanumeric: "AAA666",
      post_code: "12345"
    }
  end
end
