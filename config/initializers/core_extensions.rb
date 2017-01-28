Dir[Rails.root.join('app', 'lib', 'core_extensions', '**', '*.rb')].each do |file|
  require file
end
