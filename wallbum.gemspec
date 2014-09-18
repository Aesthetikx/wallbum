Gem::Specification.new do |s|
  s.name                  = 'wallbum'
  s.version               = '1.0.0'
  s.license               = 'MIT'
  s.summary               = 'Create a wallpaper from discogs album art'
  s.authors               = ['John DeSilva']
  s.email                 = ['desilvjo@umich.edu']
  s.files                 = `git ls-files`.split("\n")
  s.homepage              = 'https://github.com/Aesthetikx/wallbum'
  s.bindir                = 'bin'

  s.executables           << 'wallbum'

  s.add_runtime_dependency 'discogs-wrapper'
  s.add_runtime_dependency 'rmagick'
  s.add_runtime_dependency 'rubystats'
  s.add_runtime_dependency 'slop'
end
