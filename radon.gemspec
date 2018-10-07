# Put all our core library files in the require path
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))
require 'core'

Gem::Specification.new do |spec|
  spec.name          = "radon"
  spec.version       = VERSION
  spec.authors       = ["cbrnrd"]
  spec.email         = ["0xCB@protonmail.com"]

  spec.summary       = %q{Radon generates starter code for all kinds of environments.}
  spec.homepage      = "https://github.com/cbrnrd/radon"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|console|setup)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "paint"
  spec.add_runtime_dependency "rubyzip", "~> 1.2"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end