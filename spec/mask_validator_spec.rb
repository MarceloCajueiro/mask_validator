require 'spec_helper'

describe MaskValidator do
  context 'When class is not an ActiveRecord model' do
    subject do
      NoActiveRecordPerson.new
    end

    it "should be valid with a phone in according of the mask" do
      subject.phone = '(48) 9874-4569'
      subject.should have_valid_value_to(:phone)
    end
  end

  context 'When class is an ActiveRecord model' do
    subject do
      Person.new
    end

    # validates :phone, :mask => "(99) 9999-9999", :allow_blank => true
    context "mask validation to phone" do
      it "should be valid with a phone in according of the mask" do
        subject.phone = '(48) 9874-4569'
        subject.should have_valid_value_to(:phone)
      end

      it "should not be valid with a phone with a wrong pattern" do
        subject.phone = '4852458787'
        subject.should_not have_valid_value_to(:phone)

        subject.phone = '48 9865 4879'
        subject.should_not have_valid_value_to(:phone)

        subject.phone = '(48) 9874-45169'
        subject.should_not have_valid_value_to(:phone)

        subject.phone = '(48)98956698'
        subject.should_not have_valid_value_to(:phone)
      end
    end

    # validates :acronym, :mask => "***", :allow_nil => true
    context "mask validation to acronym" do
      it "should be valid with a acronym in according of the mask" do
        subject.acronym = '1gd'
        subject.should have_valid_value_to(:acronym)

        subject.acronym = '666'
        subject.should have_valid_value_to(:acronym)

        subject.acronym = 'zzz'
        subject.should have_valid_value_to(:acronym)
      end

      it "should not be valid with a acronym with a wrong pattern" do
        subject.acronym = '1qw1'
        subject.should_not have_valid_value_to(:acronym)
      end
    end

    # validates :alphanumeric, :mask => "aaa999"
    context "mask validation to alphanumeric" do
      it "should be valid with a alphanumeric in according of the mask" do
        subject.alphanumeric = 'awe987'
        subject.should have_valid_value_to(:alphanumeric)
      end

      it "should not be valid with a alphanumeric with a wrong pattern" do
        subject.alphanumeric = '999999'
        subject.should_not have_valid_value_to(:alphanumeric)

        subject.alphanumeric = 'QQQQQQ'
        subject.should_not have_valid_value_to(:alphanumeric)

        subject.alphanumeric = '666aaaa'
        subject.should_not have_valid_value_to(:alphanumeric)

        subject.alphanumeric = '666AAA'
        subject.should_not have_valid_value_to(:alphanumeric)
      end
    end

    context "when the attributes type is not a string" do
      it "should not be valid with a wrong date format" do
        subject.birth_date = "15-12-2009"
        subject.should_not have_valid_value_to(:birth_date)
      end

      it "should not be valid with a wrong birth year" do
        subject.birth_year = 20110
        subject.should_not have_valid_value_to(:birth_year)
      end

      it "should not be valid with a wrong birth time" do
        subject.birth_time = "333:20"
        subject.should_not have_valid_value_to(:birth_time)
      end

      it "should not be valid with a wrong body fat" do
        subject.body_fat = 333.00
        subject.should_not have_valid_value_to(:body_fat)
      end
    end

    # validates :custom, :mask => :custom_mask, :allow_blank => false
    context "mask validation to custom field using custom_mask method" do
      it "should be valid with an correct custom value" do
        subject.stub!(:custom_mask => "99999-999")
        subject.custom = '32632-567'
        subject.should have_valid_value_to(:custom)
      end

      it "should not be valid with an empty custom value" do
        subject.stub!(:custom_mask => "9.9.9")
        subject.custom = ''
        subject.should_not have_valid_value_to(:custom)
      end
    end

    # validates :identification, :mask => Proc.new{|o| o.proc_mask}, :allow_blank => false
    context "mask validation to proc field using a Proc" do
      it "should be valid with an correct value" do
        subject.stub!(:proc_mask => "999.9.99")
        subject.identification = '326.3.67'
        subject.should have_valid_value_to(:identification)
      end

      it "should not be valid with an empty value" do
        subject.stub!(:prock_mask => "9.9.9")
        subject.identification = ''
        subject.should_not have_valid_value_to(:identification)
      end
    end

    # validates :phone, :mask => "99999-999", :allow_blank => true
    context "mask validation to phone with explicit ':allow_blank => true'" do
      it "should not be valid with an nil phone" do
        subject.phone = nil
        subject.should have_valid_value_to(:phone)
      end

      it "should be valid with an empty phone" do
        subject.phone = ''
        subject.should have_valid_value_to(:phone)
      end
    end

    # validates :acronym, :mask => "***", :allow_nil => true
    context "mask validation to acronym with explicit ':allow_nil => true'" do
      it "should be valid with an nil acronym" do
        subject.acronym = nil
        subject.should have_valid_value_to(:acronym)
      end

      it "should be valid with an empty acronym" do
        subject.acronym = ''
        subject.should_not have_valid_value_to(:acronym)
      end
    end

    # validates :fax, :mask => "(99) 9999-9999", :allow_nil => false
    context "mask validation to fax with explicit ':allow_nil => false'" do
      it "should not be valid with an nil fax" do
        subject.fax = nil
        subject.should_not have_valid_value_to(:fax)
      end

      it "should be valid with an empty fax" do
        subject.fax = ''
        subject.should_not have_valid_value_to(:fax)
      end
    end

    # validates :zip_code, :mask => "99999-999", :allow_blank => false
    context "mask validation to zip_code with explicit ':allow_blank => false'" do
      it "should not be valid with an nil zip_code" do
        subject.zip_code = nil
        subject.should_not have_valid_value_to(:zip_code)
      end

      it "should be valid with an empty zip_code" do
        subject.zip_code = ''
        subject.should_not have_valid_value_to(:zip_code)
      end
    end

    # validates :birth_date, :mask => '99/99/9999'
    context "mask validation to birth_date with implicit ':allow_blank => false'" do
      it "should not be valid with an nil birth_date" do
        subject.birth_date = nil
        subject.should_not have_valid_value_to(:birth_date)
      end

      it "should be valid with an empty birth_date" do
        subject.birth_date = ''
        subject.should_not have_valid_value_to(:birth_date)
      end
    end
  end
end
