ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :people do |t|
    t.string     :phone
    t.string     :acronym
    t.string     :alphanumeric
    t.string     :zip_code
    t.string     :fax
    t.decimal    :body_fat
    t.integer    :birth_year
    t.date       :birth_date
    t.datetime   :birth_time
  end
end
