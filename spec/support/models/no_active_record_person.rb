class NoActiveRecordPerson
  include ActiveModel::Validations

  attr_accessor :phone

  validates :phone, :mask => "(99) 9999-9999", :allow_blank => true
end
