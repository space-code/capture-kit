Pod::Spec.new do |s|
    s.name = 'CaptureKit'
    s.version = '1.0.0'
    s.license = 'MIT'
    s.summary = 'A screen capture framework'
    s.homepage = 'https://github.com/space-code/capture-kit'
    s.authors = { 'Nikita Vasilev' => 'nv3212@gmail.com' }
    s.source = { :git => 'https://github.com/space-code/capture-kit.git', :tag => s.version }
    s.documentation_url = 'https://github.com/space-code/capture-kit'

    s.osx.deployment_target = '10.12'

    s.source_files = 'CaptureKit/CaptureKit.h'
end