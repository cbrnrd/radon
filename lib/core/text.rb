require 'paint'

def vprint(*args)
  puts args if $verbose && !$quiet
end

def error(*args)
  puts Paint["ERROR", '#e74c3c'] + " - #{args}"
end

def report_error_to_github(trace)
  puts %Q{
    :::::::::::::::::: COPY BELOW ::::::::::::::::::
    ### Ruby version

    `#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}`

    ### OS

    #{Gem::Platform.local.os}

    ### Radon Version

    `VERSION`

    ### Date Found

    #{Time.now.strftime("%d/%m/%Y %H:%M")}

    ### Backtrace
    ```
    #{trace}
    ```
    :::::::::::::::::: COPY ABOVE ::::::::::::::::::
    #{Paint["Whoops! Looks like you've found a bug in radon. Please copy the text above and open a new issue at ", '#e74c3c'] + Paint['https://github.com/cbrnrd/radon/issues', :bold, :bright]}
  }
  
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

def classify(name)
  name = name.gsub(/-[a-z]/) {|s| s.upcase }
  name.delete!('-')
  return name.slice(0,1).capitalize + name.slice(1..-1)
end

def find_and_replace_all(target_dir, find, repl)
  files = Dir[File.join(target_dir,'**','*')]
  files.each do |file_name|
    next if File.directory?(file_name)
    begin
      text = File.read(file_name)
      # Do the find and replace
      new_contents = text.gsub(find, repl)
      File.open(file_name, 'w') {|f| f.puts new_contents}
    rescue Errno::ENOENT => e
      # Something weird happened (this shouldn't come up)
      error "ERROR GSUBING FILE #{file_name}"
      report_error_to_github(e.backtrace)
      next
    end
  end

end