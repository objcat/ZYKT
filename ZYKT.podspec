Pod::Spec.new do |s|
  s.name         = "ZYKT"
  s.version      = "0.1.1"
  s.summary      = "ZYKT for iOS"
  s.description  = <<-DESC
                   ZYKT for iOS
                   DESC
  s.homepage     = "https://github.com/objcat/ZYKT"
  s.license      = 'MIT'
  s.author       = { "objcat" => "objcat2024@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://github.com/objcat/ZYKT', :tag => s.version }
  s.requires_arc = true

  s.subspec 'ZYUserDefaults' do |zyud|
    zyud.source_files = 'ZYUserDefaults/*.{h,m}'
  end

end
