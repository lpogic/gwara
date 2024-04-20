require_relative "./lib/gwara/version"

Gem::Specification.new do |s|
  s.name        = "gwara"
  s.version     = Gwara::VERSION
  s.summary     = "Css influenced HTML dialect compiler"
  s.description = <<~EOT
    HTML derived language compiler.
  EOT
  s.authors     = ["Łukasz Pomietło"]
  s.email       = "oficjalnyadreslukasza@gmail.com"
  s.files       = Dir.glob('lib/**/*')
  s.homepage    = "https://github.com/lpogic/gwara"
  s.license       = "Zlib"
  s.required_ruby_version     = ">= 3.2.2"
  s.add_runtime_dependency("modeling", "~> 0.0.4")
  s.add_runtime_dependency("koper", "~> 0.0.2")
  s.metadata = {
    "documentation_uri" => "https://github.com/lpogic/gwara/blob/main/doc/wiki/README.md",
    "homepage_uri" => "https://github.com/lpogic/gwara"
  }
end