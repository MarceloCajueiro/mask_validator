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

    if value.nil?
      record.errors.add(attribute, :blank) unless allow_nil?
    end

    if value.blank?
      record.errors.add(attribute, :empty) unless allow_blank?
    else
      record.errors.add(attribute, message, options) unless value.match(regexp)
    end
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

  private

  def message
    options[:message]
  end

  def allow_nil?
    options.include?(:allow_nil) && options[:allow_nil] == false ? false : true
  end

  def allow_blank?
    options.include?(:allow_blank) && options[:allow_blank] == false ? false : true
  end
end
