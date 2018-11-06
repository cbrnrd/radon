require "base64"
require "tempfile"
require "zip"

def extract_gradle(target)
  extract_zip(Radon::Environments.getTargetOf('gradle'), target)
end

def extract_java(target)
  extract_zip(Radon::Environments.getTargetOf('java'), target)
end

def extract_maven(target)
  extract_zip(Radon::Environments.getTargetOf('maven'), target)
end

def extract_python(target)
  extract_zip(Radon::Environments.getTargetOf('python'), target)
end

def extract_ruby(target)
  extract_zip(Radon::Environments.getTargetOf('ruby (beta)'), target)
  find_and_replace_all(target, '{{NAME}}', projectify(target).split('-').collect(&:capitalize).join)
end

def extract_c(target)
  extract_zip(Radon::Environments.getTargetOf('c'), target)
end

def extract_crystal(target)
  extract_zip(Radon::Environments.getTargetOf('crystal'), target)
  find_and_replace_all(target, '{{NAME}}', projectify(target))#.split('-').collect(&:capitalize).join)
  find_and_replace_all(target, '{{CAPSNAME}}', classify(target))
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
