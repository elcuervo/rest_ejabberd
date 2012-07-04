Gem::Specification.new do |s|
  s.name              = "rest_ejabberd"
  s.version           = "0.0.1"
  s.summary           = "Ruby interface for ejabberd's mod_restful"
  s.description       = "Easy tool to use ejabberd's mod_restful from Ruby"
  s.authors           = ["elcuervo"]
  s.email             = ["yo@brunoaguirre.com"]
  s.homepage          = "http://github.com/elcuervo/rest_ejabberd"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files test`.split("\n")

  s.add_development_dependency("minitest", "~> 3.1.0")
  s.add_development_dependency("vcr", "~> 2.1.1")
end
