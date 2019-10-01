Pod::Spec.new do |spec|
	spec.name = 'SharedComponents'
	spec.platform = :ios, '10.0'
	spec.version = '0.1.0'
	spec.summary = 'SharedComponents to be used in test apps'
	spec.homepage = 'https.alessandromanni.com'	
	spec.license = "Internal use only"
	spec.author = 'Alessandro Manni'
	spec.source = { :git => 'https://github.com/AleManni' }
	spec.source_files = 'Sources/**/*'
	
	spec.resource_bundles = {
		'SharedComponents' => [
		'SharedComponents/Resources/**/*',
		'SharedComponents/Classes/**/*.xib',
		'SharedComponents/Classes/**/*.storyboard'
		]
	}

end