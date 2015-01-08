require 'rspec'
require 'active_model'
require 'active_record'
require 'mask_validator'

require "support/db/schema"
require "support/models/person"
require "support/models/no_active_record_person"

RSpec::Matchers.define :have_valid_value_to do |attribute|
  match do |actual|
    actual.valid?

    !actual.errors[attribute].include?("is invalid")
  end

  failure_message do |actual|
    "expected that the #{attribute} attribute would be valid"
  end

  failure_message_when_negated do |actual|
    "expected that the #{attribute} attribute would be invalid"
  end
end
