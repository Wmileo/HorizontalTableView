Pod::Spec.new do |s|
  s.name         = "SimpleHorizontalTableView"
  s.version      = "0.1.0"
  s.summary      = "横向tableview"
  s.description  = <<-DESC
					 可以横向的tableview
                   DESC

  s.homepage     = "https://github.com/Wmileo/HorizontalTableView"
  s.license      = "MIT"
  s.author             = { "leo" => "work.mileo@gmail.com" }

  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/Wmileo/HorizontalTableView.git", :tag => s.version.to_s }
  s.source_files  = "HorizontalTableView/HorizontalTableView/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
end
