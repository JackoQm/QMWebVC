Pod::Spec.new do |spec|
  spec.name = "QMWebVC"
  spec.version = "1.0.0"
  spec.summary = "A useful webView Controller with a WeChat-like progress view."
  spec.homepage = "https://github.com/JackoQm/QMWebVC"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "JackoQm" => 'userqm@163.com' }
  spec.social_media_url = "http://www.jianshu.com/users/1c2ecd8e07d2/timeline"

  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/JackoQm/QMWebVC.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "QMWebVC/**/*.{h,swift}"

end
