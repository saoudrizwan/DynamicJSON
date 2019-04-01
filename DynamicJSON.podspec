Pod::Spec.new do |s|
	s.name = "DynamicJSON"
	s.version = "2.0.2"
	s.license = { :type => "MIT", :file => "LICENSE" }
	s.summary = "A dynamically typed JSON parser for Swift using the new @dynamicMemberLookup feature"
	s.description  = <<-DESC
    DynamicJSON is a dynamically typed parser for JSON built upon the new @dynamicMemberLookup feature introduced by Chris Lattner in Swift 4.2. This allows us to access arbitrary object members which are resolved at runtime, allowing Swift to be as flexible as JavaScript when it comes to JSON.
  	DESC
	s.homepage = "https://github.com/saoudrizwan/DynamicJSON"
	s.social_media_url = "https://twitter.com/sdrzn"
	s.author = { "Saoud Rizwan" => "hello@saoudmr.com" }
	s.source = { :git => "https://github.com/saoudrizwan/DynamicJSON.git", :tag => s.version }
	s.documentation_url = "https://github.com/saoudrizwan/DynamicJSON"
  
	s.swift_version = "4.2"
	s.ios.deployment_target = "9.0"
	s.osx.deployment_target = "10.10"
	s.tvos.deployment_target = "9.0"
	s.watchos.deployment_target = "3.0"
  
	s.source_files = "Sources/*.swift"
  end
