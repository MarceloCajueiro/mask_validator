class MaskValidator < ActiveModel::EachValidator

  #
  # This validator use the characters 'a', '9' and '*'
  # to validate the format with regular expression
  #
  # Example using in models:
  #   validates :phone, :mask => "(99) 9999-9999"
  #   validates :acronym, :mask => "***"
  #
  # Where:
  #   a - to letters (A-Z, a-z)
  #   9 - to numbers (0-9)
  #   * - to alphanumerics (A-Z, a-z, 0-9)
  #
  def validate_each(record, attribute, value)
    value = converted_value(value)

    return record.errors.add(attribute, :blank) if options.include?(:allow_nil) && options[:allow_nil] == false && value.nil?
    return record.errors.add(attribute, :empty) if options.include?(:allow_blank) && options[:allow_blank] == false && value.blank?
    return if value.blank?

    return record.errors.add(attribute, options[:message], options) unless value.match(regexp)
  end

  #
  # Transform the string in a regular expression:
  #
  #   options[:with] = "9a"
  #
  #   regexp #=> /[0-9][a-zA-Z]/
  #
  # TODO: improve this
  def regexp
    /\A#{(options[:with].to_s.each_char.collect { |char| character_map[char] || "\\#{char}" }).join}\z/
  end

  def character_map
    { "9" => "[0-9]", "a" => "[a-zA-Z]", "*" => "[a-zA-Z0-9]" }
  end

  def converted_value(value)
    if [Date, DateTime, Time].include?(value.class)
      date_or_time_value(value)
    else
      value
    end
  end

  #
  # Use the value with i18n to validate
  #
  def date_or_time_value(value)
    type = (value.class == Date) ? 'date' : 'time'

    if I18n.t("#{type}.formats.mask") =~ /missing/
      I18n.l(value)
    else
      I18n.l(value, :format => :mask)
    end
  end
end
