# Load all lib files
Dir[File.join(__dir__, 'lib', '**', '*.rb')].sort.each { |file| require file }