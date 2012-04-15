require 'spec_helper'

describe MaskValidator do
  subject do
    Person.new :phone => '(12) 3456-7890',
               :fax => '(12) 3456-7890',
               :acronym => 'ABC',
               :alphanumeric => 'AAA666',
               :zip_code => '88900-000',
               :birth_date => '13/10/1989',
               :birth_time => '10:20',
               :birth_year => '2011',
               :body_fat => '23,44',
               :custom => '989.78',
               :identification => '53.86'
  end

  it "Person should be valid" do
    subject.should be_valid
  end

  # validates :phone, :mask => "(99) 9999-9999", :allow_blank => true
  context "mask validation to phone with explicit ':allow_blank => true'" do
    it "should be valid with a nil phone" do
      subject.phone = nil
      subject.should be_valid
    end

    it "should be valid with an empty phone" do
      subject.phone = ''
      subject.should be_valid
    end

    it "should be valid with a phone in according of the mask" do
      subject.phone = '(48) 9874-4569'
      subject.should be_valid
    end

    it "should not be valid with a phone with a wrong pattern" do
      subject.phone = '4852458787'
      subject.should_not be_valid

      subject.phone = '48 9865 4879'
      subject.should_not be_valid

      subject.phone = '(48) 9874-45169'
      subject.should_not be_valid

      subject.phone = '(48)98956698'
      subject.should_not be_valid
    end
  end

  # validates :acronym, :mask => "***", :allow_nil => true
  context "mask validation to acronym with explicit ':allow_nil => true'" do
    it "should be valid with an nil acronym" do
      subject.acronym = nil
      subject.should be_valid
    end

    it "should be valid with an empty acronym" do
      subject.acronym = ''
      subject.should be_valid
    end

    it "should be valid with a acronym in according of the mask" do
      subject.acronym = '1gd'
      subject.should be_valid

      subject.acronym = '666'
      subject.should be_valid

      subject.acronym = 'zzz'
      subject.should be_valid
    end

    it "should not be valid with a acronym with a wrong pattern" do
      subject.acronym = '1qw1'
      subject.should_not be_valid
    end
  end

  # validates :alphanumeric, :mask => "aaa999"
  context "mask validation to alphanumeric with implicit ':allow_nil => true' and ':allow_blank => true'" do
    it "should be valid with an nil alphanumeric" do
      subject.alphanumeric = nil
      subject.should be_valid
    end

    it "should be valid with an empty alphanumeric" do
      subject.alphanumeric = ''
      subject.should be_valid
    end

    it "should be valid with a alphanumeric in according of the mask" do
      subject.alphanumeric = 'awe987'
      subject.should be_valid
    end

    it "should not be valid with a alphanumeric with a wrong pattern" do
      subject.alphanumeric = '999999'
      subject.should_not be_valid

      subject.alphanumeric = 'QQQQQQ'
      subject.should_not be_valid

      subject.alphanumeric = '666aaaa'
      subject.should_not be_valid

      subject.alphanumeric = '666AAA'
      subject.should_not be_valid
    end
  end

  # validates :zip_code, :mask => "99999-999", :allow_blank => false
  context "mask validation to zip code with explicit ':allow_blank => false'" do
    it "should not be valid with an nil zip code" do
      subject.zip_code = nil
      subject.should_not be_valid
    end

    it "should not be valid with an empty zip code" do
      subject.zip_code = ''
      subject.should_not be_valid
    end
  end

  # validates :fax, :mask => "(99) 9999-9999", :allow_nil => false
  context "mask validation to fax with explicit ':allow_nil => false'" do
    it "should not be valid with an nil fax" do
      subject.fax = nil
      subject.should_not be_valid
    end

    it "should be valid with an empty fax" do
      subject.fax = ''
      subject.should be_valid
    end
  end

  context "when the attributes type is not a string" do
    it "should not be valid with a wrong date format" do
      subject.birth_date = "15-12-2009"
      subject.should be_invalid
    end

    it "should not be valid with a wrong birth year" do
      subject.birth_year = 20110
      subject.should be_invalid
    end

    it "should not be valid with a wrong birth time" do
      subject.birth_time = "333:20"
      subject.should be_invalid
    end

    it "should not be valid with a wrong body fat" do
      subject.body_fat = 333.00
      subject.should be_invalid
    end
  end

  # validates :custom, :mask => :custom_mask, :allow_blank => false
  context "mask validation to custom field using custom_mask method" do
    it "should be valid with an correct custom value" do
      subject.stub!(:custom_mask => "99999-999")
      subject.custom = '32632-567'
      subject.should be_valid
    end

    it "should not be valid with an empty custom value" do
      subject.stub!(:custom_mask => "9.9.9")
      subject.custom = ''
      subject.should_not be_valid
    end
  end

  # validates :identification, :mask => Proc.new{|o| o.proc_mask}, :allow_blank => false
  context "mask validation to proc field using a Proc" do
    it "should be valid with an correct value" do
      subject.stub!(:proc_mask => "999.9.99")
      subject.identification = '326.3.67'
      subject.should be_valid
    end

    it "should not be valid with an empty value" do
      subject.stub!(:prock_mask => "9.9.9")
      subject.identification = ''
      subject.should_not be_valid
    end
  end
end
