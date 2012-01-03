require 'rspec'
require 'active_model'
require 'ostruct'
require 'mask_validator'

class Person < OpenStruct
  include ActiveModel::Validations

  validates :birth_date, :mask => '99/99/9999'
  validates :birth_time, :mask => '99:99'
  validates :phone, :mask => "(99) 9999-9999", :allow_blank => true
  validates :acronym, :mask => "***", :allow_nil => true
  validates :alphanumeric, :mask => "aaa999"
  validates :zip_code, :mask => "99999-999", :allow_blank => false
  validates :fax, :mask => "(99) 9999-9999", :allow_nil => false
end

I18n.locale = :pt
I18n.load_path << Dir[File.expand_path("../support/locales/*.yml", __FILE__)]
