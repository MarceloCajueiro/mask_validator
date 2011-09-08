# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mask_validator"
  s.version     = "0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Marcelo Cajueiro"]
  s.email       = ["marcelocajueiro@gmail.com"]
  s.homepage    = "https://github.com/marcelocajueiro/mask_validator"
  s.summary     = %q{Input Mask validation for ActiveModel}

  s.rubyforge_project = "mask_validator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activemodel', ">= 3.0"
  s.add_development_dependency 'rake', '>= 0.8.7'

end
