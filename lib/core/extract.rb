require "base64"
require "tempfile"
require "zip"

def extract_gradle(target)
  extract_zip(Radon::Environments.get_target_of('gradle'), target)
end

def extract_java(target)
  extract_zip(Radon::Environments.get_target_of('java'), target)
end

def extract_maven(target)
  extract_zip(Radon::Environments.get_target_of('maven'), target)
end

def extract_python(target)
  extract_zip(Radon::Environments.get_target_of('python'), target)
end

def extract_ruby(target)
  extract_zip(Radon::Environments.get_target_of('ruby'), target)
  replace_all_tokens(target)
end

def extract_c(target)
  extract_zip(Radon::Environments.get_target_of('c'), target)
end

def extract_crystal(target)
  extract_zip(Radon::Environments.get_target_of('crystal'), target)
  replace_all_tokens(target)
end

def extract_go_s(target)
  extract_zip(Radon::Environments.get_target_of('go_s'), target)
end

def extract_website(target)
  extract_zip(Radon::Environments.get_target_of('website'), target)
end

# Extracts some zip data to the passed destination
def extract_zip(file, destination)
  puts "Creating project under #{File.expand_path(destination)}" unless $quiet
  create(destination)
  FileUtils.mkdir_p(destination)

  Zip::File.open(file) do |zip_file|
    zip_file.each do |f|
      fname = f.name.gsub('{{NAME}}', projectify(destination))
      fpath = File.join(destination, fname)
      if File.exists?(fpath)
        skip(fpath)
      else
        create(fpath)
      end
      zip_file.extract(f, fpath) unless File.exist?(fpath)
    end
  end
end
