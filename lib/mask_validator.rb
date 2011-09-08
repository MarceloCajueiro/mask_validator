class MaskValidator < ActiveModel::EachValidator

  #
  # This validator use the characters 'a', '9' and '*'
  # to validate the form of the content
  #
  # Example using in models:
  #   validates :phone, mask: "(99) 9999-9999"
  #   validates :acronym, mask: "***"
  #
  # Where:
  #   a - Represents an alpha character (A-Z,a-z)
  #   9 - Represents a numeric character (0-9)
  #   * - Represents an alphanumeric character (A-Z,a-z,0-9)
  #
  # TODO: refactoring
  def validate_each(record, attribute, value)
    return record.errors.add(attribute, :blank) if options.include?(:allow_nil) && options[:allow_nil] == false && value.nil?
    return record.errors.add(attribute, :empty) if options.include?(:allow_blank) && options[:allow_blank] == false && !value.nil? && value.empty?
    return true if value.nil? || value.blank?

    definitions = { "9" => "[0-9]", "a" => "[a-zA-Z]", "*" => "[a-zA-Z0-9]" }
    regex = /#{(options[:with].to_s.each_char.collect { |char| definitions[char] || "\\#{char}" }).join}/

    match = value.match(regex)
    unless match && match.to_s == value
      record.errors.add(attribute, options[:message], options)
    end
  end
end
