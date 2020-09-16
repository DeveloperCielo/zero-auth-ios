Pod::Spec.new do |spec|

  spec.name         = "ZeroAuthCielo"
  spec.version      = "1.0.2"
  spec.summary      = "Biblioteca de validação de cartões de crédito"

  spec.description  = <<-DESC
  Biblioteca Cielo/Braspag de validação de cartões de crédito.
                   DESC

  spec.homepage     = "https://github.com/DeveloperCielo/zero-auth-ios"

  spec.license      = "MIT"

  spec.author             = { "Jeferson F. Nazario" => "jefnazario@gmail.com" }
  spec.social_media_url   = "https://twitter.com/jefnazario"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/DeveloperCielo/zero-auth-ios.git", :tag => "#{spec.version}" }
  spec.swift_version = "5.0"
  spec.ios.deployment_target = '9.0'

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "ZeroAuth/ZeroAuth/**/*.{h,m,swift,framework}"
  spec.dependency 'CieloOAuth'
  spec.exclude_files = "ZeroAuth/Example/**/*.*"
end
