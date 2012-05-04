# Mask Validator

This gem was inspired in the Sobrinho's gems to validate simple things inside of ActiveModel.

The gem works getting the value before type cast and comparing with a regular expression from the parse of mask pattern.

## Installation

Put `gem "mask_validator", "0.2.1"` in the Gemfile

## Usage

```ruby
validates :phone, :mask => "(99) 9999-9999"

validates :acronym, :mask => "***"

validates :acronym, :mask => :custom_method

validates :acronym, :mask => Proc.new { |o| o.custom_method }
```

* a - Represents an alpha character (A-Z, a-z)
* 9 - Represents a numeric character (0-9)
* * - Represents an alphanumeric character (A-Z, a-z, 0-9)

For more information about masks in the form inputs check the jquery plugin [Masked input](http://digitalbush.com/projects/masked-input-plugin/)

## Application example

Use a little trick to call the masked input (jquery plugin) only defining the validation in the model.

In other words, defining:

```ruby
validates :phone, :mask => "(99) 9999-9999"
```

It is the only necessary thing to apply the masked input.

## License

Copyright © 2011 Marcelo Cajueiro, released under the MIT license
