require 'paint'

def vprint(*args)
  puts args if $verbose && !$quiet
end

def error(*args)
  puts Paint["ERROR", '#e74c3c'] + " - #{args}"
end

def create(fname)
  puts Paint["  create", '#2ecc71'] + " #{fname}" unless $quiet
end

def skip(fname)
  puts Paint["  skip", '#f1c40f'] + " #{fname}" unless $quiet
end

def projectify(name)
  # Name becomes frozen for some reason
  name = name.gsub(/(.)([A-Z])/,'\1-\2')
  name.downcase!
  name.gsub!('..', '')
  name.gsub!('/', '')
  name.gsub!('\\', '')
  name[0] = '' if name[0] == '-'
  name.gsub!('--', '-')
  name.gsub!('_-', '-')
  return name
end

def find_and_replace_all(target_dir, find, repl)
  Dir.foreach(target_dir) do |file_name|
    og_fname = file_name
    file_name = File.join(target_dir, file_name)
    next if og_fname == '.' || og_fname == '..' || File.directory?(file_name)
    text = File.read(file_name)
    replace = text.gsub!(find, repl)
    File.open(file_name, "w") { |file| file.puts replace }
  end
end