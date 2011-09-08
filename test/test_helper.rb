require 'rubygems'
require 'test/unit'
require 'active_model'
require 'mask_validator'
require 'ostruct'

class Person < OpenStruct
  include ActiveModel::Validations
  validates :phone, mask: "(99) 9999-9999"
  validates :acronym, mask: "***"
  validates :alphanumeric, mask: "aaa999"
end
