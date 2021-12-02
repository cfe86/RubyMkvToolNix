# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'mkvtoolnix'
  spec.version       = '1.0.0'
  spec.authors       = ['Christian Feier']
  spec.email         = ['Christian.Feier@gmail.com']

  spec.summary       = 'A wrapper for MkvToolNix https://mkvtoolnix.download/ to create, alter and inspect MKV files.'\
                       'For more information, please check the github page: https://github.com/cfe86/RubyMkvToolNix'
  spec.description   = 'A wrapper for MkvToolNix https://mkvtoolnix.download/ to create, alter and inspect MKV files.'\
                       'Currently mkvpropedit and mkvextract are fully implemented. mkvmerge is completed except the split options.'
  spec.homepage      = 'https://github.com/cfe86/RubyMkvToolNix'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata['homepage_uri'] = 'https://github.com/cfe86/RubyMkvToolNix'
  spec.metadata['source_code_uri'] = 'https://github.com/cfe86/RubyMkvToolNix'
  spec.metadata['changelog_uri'] = 'https://github.com/cfe86/RubyMkvToolNix'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
