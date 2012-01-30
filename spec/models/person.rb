class Person < ActiveRecord::Base
  validates :phone,            :mask => "(99) 9999-9999", :allow_blank => true
  validates :fax,              :mask => "(99) 9999-9999", :allow_nil => false
  validates :acronym,          :mask => "***", :allow_nil => true
  validates :alphanumeric,     :mask => "aaa999"
  validates :zip_code,         :mask => "99999-999", :allow_blank => false
  validates :birth_date,       :mask => '99/99/9999'
  validates :birth_time,       :mask => '99:99'
  validates :birth_year,       :mask => '9999'
  validates :body_fat,         :mask => "99,99"
  validates :custom,           :mask => :custom_mask, :allow_blank => false
  validates :identification,   :mask => Proc.new{|o| o.proc_mask}, :allow_blank => false

  def custom_mask
    "999.99"
  end

  def proc_mask
    "99.99"
  end
end
