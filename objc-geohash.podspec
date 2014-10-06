Pod::Spec.new do |spec|
  spec.name         = 'objc-geohash'
  spec.version      = '0.0.2'
  spec.homepage     = 'https://github.com/lyokato/objc-geohash'
  spec.license      = 'MIT'
  spec.summary      = 'Objective-C GeoHash Library.'
  spec.author       = { 'Lyo Kato' => 'lyo.kato@gmail.com' }
  spec.source       = { :git => 'https://github.com/lyokato/objc-geohash.git', :commit => 'fd4149cb79dd0b6c9acd553000ccdf28460808b1' }
  spec.source_files = 'Classes/ARC/*'
  spec.requires_arc = true
end
