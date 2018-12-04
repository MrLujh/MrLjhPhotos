Pod::Spec.new do |s|
s.name        = 'MrLjhPhotos'
s.version     = '0.0.2'
s.authors     = { 'MrLjh' => '287929070@qq.com' }
s.homepage    = 'https://github.com/MrLujh/MrLjhPhotos'
s.summary     = '获得相册图片'
s.source      = { :git => 'https://github.com/MrLujh/MrLjhPhotos.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }
s.platform = :ios, '8.0'
s.requires_arc = true
s.source_files = "MrLjhPhotos", "*.{h,m}"

end