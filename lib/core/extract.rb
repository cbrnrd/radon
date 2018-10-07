require "base64"
require "tempfile"
require "zip"

def extractGradle(target)
  '''t = Tempfile.new(["gradle", ".zip"])
  tpath = t.path
  puts tpath
  t.write(Base64.decode64(File.join(DATA_DIR, "gradle.b64")))
  puts Base64.decode64(File.join(DATA_DIR, "gradle.b64"))
  extract_zip(tpath, target)
  #t.close
  #t.unlink # Delete the file
'''
  path = Radon::Environments.getTargetOf('gradle')
  extract_zip(path, target)
end

def extractJava(target)
t = Tempfile.new(['java', '.zip'])
tpath = t.path
t.write(Base64.decode64(File.join(DATA_DIR, "java.b64")))
extract_zip(tpath, target)
t.close
t.unlink # Delete the file
end

def extractPython
end

def extractRuby
end

# Extracts some zip data to the passed destination
def extract_zip(file, destination)
  puts "Creating project under #{File.expand_path(destination)}" unless $quiet
  create(destination)
  FileUtils.mkdir_p(destination)

  Zip::File.open(file) do |zip_file|
    zip_file.each do |f|
      fpath = File.join(destination, f.name)
      zip_file.extract(f, fpath) unless File.exist?(fpath)
      if File.exist?(fpath)
        create(fpath)
      else
        skip(fpath)
      end
    end
  end
end