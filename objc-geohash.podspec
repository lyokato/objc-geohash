Pod::Spec.new do |spec|
  spec.name         = 'objc-geohash'
  spec.version      = '0.1'
  spec.author       = { 'Lyo Kato' => 'lyo.kato@gmail.com' }
  spec.source       = { :git => 'https://github.com/lyokato/objc-geohash.git', :tag => spec.version.to_s }
  spec.source_files = 'Classes/ARC/*'
  spec.requires_arc = true
end
