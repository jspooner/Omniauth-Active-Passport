# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-active_passport/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "omniauth-active_passport"
  s.version     = Omniauth::ActivePassport::VERSION
  s.authors     = ["Cesar Camacho"]
  s.email       = ["cesar.camacho@activenetwork.com"]
  s.homepage    = ""
  s.summary     = %q{Official OmniAuth strategy for Active Passport.}
  s.description = %q{Official OmniAuth strategy for Active Passport.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'omniauth', '>= 1', '< 3'
  s.add_dependency 'omniauth-oauth2', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 2.7'
end
