Gem::Specification.new do |s|
  s.name = "sid-csv"
  s.version = "0.0.1"
  s.summary = "YANG-CBOR SID file as CSV"
  s.description = %q{sid-csv implements a library and a command-line interface to YANG sid files as CSV}
  s.author = "Carsten Bormann"
  s.email = "cabo@tzi.org"
  s.license = "Apache-2.0"
  s.homepage = "https://github.com/cabo/sid-csv"
  s.has_rdoc = false
  s.files = Dir['lib/**/*.rb'] + %w(README.md sid-csv.gemspec data/sid-csv.cddl) + Dir['bin/**/*']
  s.executables = Dir['bin/**/*'].map {|x| File.basename(x)}
  s.required_ruby_version = '>= 2.7.0'

  s.require_paths = ["lib"]
end
