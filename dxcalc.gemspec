Gem::Specification.new do |s|
  s.name = 'dxcalc'
  s.version = '0.1.0'
  s.summary = 'dxcalc'
  s.authors = ['James Robertson']
  s.files = Dir['lib/dxcalc.rb']
  s.add_runtime_dependency('dynarex', '~> 1.7', '>=1.7.20')
  s.signing_key = '../privatekeys/dxcalc.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/dxcalc'
end
