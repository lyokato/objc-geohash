Pod::Spec.new do |spec|
  spec.name         = 'objc-geohash'
  spec.version      = '0.0.2'
  spec.homepage     = 'https://github.com/lyokato/objc-geohash'
  spec.license      = 'MIT'
  spec.summary      = 'Objective-C GeoHash Library.'
  spec.author       = { 'Lyo Kato' => 'lyo.kato@gmail.com' }
  spec.source       = { :git => 'https://github.com/lyokato/objc-geohash.git', :commit => '0a2d5430db6368c201141320c4026142e5851a85' }
  spec.source_files = 'Classes/ARC/*'
  spec.header_dir   = 'Objc_GeoHash'
  spec.requires_arc = true
end
