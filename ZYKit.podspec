Pod::Spec.new do |s|
  s.name         = "ZYKit"
  s.version      = "1.0.0"
  s.summary      = "ZYKit for iOS"
  s.description  = <<-DESC
                   ZYKit for iOS
                   DESC
  s.homepage     = "https://github.com/objcat/ZYKit"
  s.license      = 'MIT'
  s.author       = { "objcat" => "objcat2024@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://github.com/objcat/ZYKit', :tag => s.version }
  s.requires_arc = true
  s.source_files  = "ZYKit/*.{h,m}"
end
