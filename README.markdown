# MaskValidator

This gem was inspired in the Sobrinho's gems to validate simple things inside of ActiveModel.

Use mask in inputs and validate in the models.

The gem works getting the value before type cast and comparing with a regexp from the mask pattern.

## Installation

Use the github version until a really stable version be released.

`gem "mask_validator", :git => "git://github.com/MarceloCajueiro/mask_validator.git"`

## Usage:

`validates :phone, mask: "(99) 9999-9999"`

`validates :acronym, mask: "***"`

* a - Represents an alpha character (A-Z,a-z)
* 9 - Represents a numeric character (0-9)
* * - Represents an alphanumeric character (A-Z,a-z,0-9)

For more information about masks in the form inputs check the jquery plugin [Masked input](http://digitalbush.com/projects/masked-input-plugin/)

## License

Copyright © 2011 Marcelo Cajueiro, released under the MIT license
