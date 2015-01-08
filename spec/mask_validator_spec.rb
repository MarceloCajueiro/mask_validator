require 'spec_helper'

describe MaskValidator do
  context 'When class is not an ActiveRecord model' do
    subject do
      NoActiveRecordPerson.new
    end

    it "should be valid with a phone in according of the mask" do
      subject.phone = '(48) 9874-4569'
      expect(subject).to have_valid_value_to(:phone)
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
        expect(subject).to have_valid_value_to(:phone)
      end

      it "should not be valid with a phone with a wrong pattern" do
        subject.phone = '4852458787'
        expect(subject).to_not have_valid_value_to(:phone)

        subject.phone = '48 9865 4879'
        expect(subject).to_not have_valid_value_to(:phone)

        subject.phone = '(48) 9874-45169'
        expect(subject).to_not have_valid_value_to(:phone)

        subject.phone = '(48)98956698'
        expect(subject).to_not have_valid_value_to(:phone)
      end
    end

    # validates :acronym, :mask => "***", :allow_nil => true
    context "mask validation to acronym" do
      it "should be valid with a acronym in according of the mask" do
        subject.acronym = '1gd'
        expect(subject).to have_valid_value_to(:acronym)

        subject.acronym = '666'
        expect(subject).to have_valid_value_to(:acronym)

        subject.acronym = 'zzz'
        expect(subject).to have_valid_value_to(:acronym)
      end

      it "should not be valid with a acronym with a wrong pattern" do
        subject.acronym = '1qw1'
        expect(subject).to_not have_valid_value_to(:acronym)
      end
    end

    # validates :alphanumeric, :mask => "aaa999"
    context "mask validation to alphanumeric" do
      it "should be valid with a alphanumeric in according of the mask" do
        subject.alphanumeric = 'awe987'
        expect(subject).to have_valid_value_to(:alphanumeric)
      end

      it "should not be valid with a alphanumeric with a wrong pattern" do
        subject.alphanumeric = '999999'
        expect(subject).to_not have_valid_value_to(:alphanumeric)

        subject.alphanumeric = 'QQQQQQ'
        expect(subject).to_not have_valid_value_to(:alphanumeric)

        subject.alphanumeric = '666aaaa'
        expect(subject).to_not have_valid_value_to(:alphanumeric)

        subject.alphanumeric = '666AAA'
        expect(subject).to_not have_valid_value_to(:alphanumeric)
      end
    end

    context "when the attributes type is not a string" do
      it "should not be valid with a wrong date format" do
        subject.birth_date = "15-12-2009"
        expect(subject).to_not have_valid_value_to(:birth_date)
      end

      it "should not be valid with a wrong birth year" do
        subject.birth_year = 20110
        expect(subject).to_not have_valid_value_to(:birth_year)
      end

      it "should not be valid with a wrong birth time" do
        subject.birth_time = "333:20"
        expect(subject).to_not have_valid_value_to(:birth_time)
      end

      it "should not be valid with a wrong body fat" do
        subject.body_fat = 333.00
        expect(subject).to_not have_valid_value_to(:body_fat)
      end
    end

    # validates :custom, :mask => :custom_mask, :allow_blank => false
    context "mask validation to custom field using custom_mask method" do
      it "should be valid with an correct custom value" do
        allow(subject).to receive(:custom_mask).and_return("99999-999")
        subject.custom = '32632-567'
        expect(subject).to have_valid_value_to(:custom)
      end

      it "should not be valid with an empty custom value" do
        allow(subject).to receive(:custom_mask).and_return("9.9.9")
        subject.custom = ''
        expect(subject).to_not have_valid_value_to(:custom)
      end
    end

    # validates :identification, :mask => Proc.new{|o| o.proc_mask}, :allow_blank => false
    context "mask validation to proc field using a Proc" do
      it "should be valid with an correct value" do
        allow(subject).to receive(:proc_mask).and_return("999.9.99")
        subject.identification = '326.3.67'
        expect(subject).to have_valid_value_to(:identification)
      end

      it "should not be valid with an empty value" do
        allow(subject).to receive(:proc_mask).and_return("9.9.9")
        subject.identification = ''
        expect(subject).to_not have_valid_value_to(:identification)
      end
    end

    # validates :phone, :mask => "99999-999", :allow_blank => true
    context "mask validation to phone with explicit ':allow_blank => true'" do
      it "should not be valid with an nil phone" do
        subject.phone = nil
        expect(subject).to have_valid_value_to(:phone)
      end

      it "should be valid with an empty phone" do
        subject.phone = ''
        expect(subject).to have_valid_value_to(:phone)
      end
    end

    # validates :acronym, :mask => "***", :allow_nil => true
    context "mask validation to acronym with explicit ':allow_nil => true'" do
      it "should be valid with an nil acronym" do
        subject.acronym = nil
        expect(subject).to have_valid_value_to(:acronym)
      end

      it "should be valid with an empty acronym" do
        subject.acronym = ''
        expect(subject).to_not have_valid_value_to(:acronym)
      end
    end

    # validates :fax, :mask => "(99) 9999-9999", :allow_nil => false
    context "mask validation to fax with explicit ':allow_nil => false'" do
      it "should not be valid with an nil fax" do
        subject.fax = nil
        expect(subject).to_not have_valid_value_to(:fax)
      end

      it "should be valid with an empty fax" do
        subject.fax = ''
        expect(subject).to_not have_valid_value_to(:fax)
      end
    end

    # validates :zip_code, :mask => "99999-999", :allow_blank => false
    context "mask validation to zip_code with explicit ':allow_blank => false'" do
      it "should not be valid with an nil zip_code" do
        subject.zip_code = nil
        expect(subject).to_not have_valid_value_to(:zip_code)
      end

      it "should be valid with an empty zip_code" do
        subject.zip_code = ''
        expect(subject).to_not have_valid_value_to(:zip_code)
      end
    end

    # validates :birth_date, :mask => '99/99/9999'
    context "mask validation to birth_date with implicit ':allow_blank => false'" do
      it "should not be valid with an nil birth_date" do
        subject.birth_date = nil
        expect(subject).to_not have_valid_value_to(:birth_date)
      end

      it "should be valid with an empty birth_date" do
        subject.birth_date = ''
        expect(subject).to_not have_valid_value_to(:birth_date)
      end
    end
  end
end
