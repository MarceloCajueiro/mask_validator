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
  def initialize(options)
    @allow_nil, @allow_blank = options.delete(:allow_nil), options.delete(:allow_blank)

    super
  end

  def validate_each(record, attribute, value)
    value = record.send("#{attribute.to_s}_before_type_cast")

    return if (@allow_nil && value.nil?) || (@allow_blank && value.blank?)

    record.errors.add(attribute, message, options) unless value.to_s.match regexp(record)
  end

  #
  # Transform the string in a regular expression:
  #
  #   mask_value_for(record) => "9a"
  #
  #   regexp #=> /[0-9][a-zA-Z]/
  #
  # TODO: improve this
  def regexp(record=nil)
    /\A#{(mask_value_for(record).to_s.each_char.collect { |char| character_map[char] || "\\#{char}" }).join}\z/
  end

  def character_map
    { "9" => "[0-9]", "a" => "[a-zA-Z]", "*" => "[a-zA-Z0-9]" }
  end

  #
  # Evaluate the options[:with] according with its class:
  #
  #   options[:with] = :custom_mask
  #   options[:with] = Proc.new {|o| o.custom_mask}
  #   options[:with] = "9a"
  #
  # TODO: improve this
  def mask_value_for(record=nil)
    case options[:with]
    when String
      options[:with]
    when Proc
      options[:with].call(record)
    when Symbol
      record.send(options[:with])
    end
  end

  private

  def message
    options[:message]
  end
end
