require "core/constants"
module Radon
class Environments
  @@all = {
          'gradle' => File.join(DATA_DIR, "gradle.zip"),
          'java'   => File.join(DATA_DIR, "java.zip"),
          'maven'  => File.join(DATA_DIR, "maven.zip"),
          'python' => File.join(DATA_DIR, "python.zip"),
          'ruby (beta)'   => File.join(DATA_DIR, "ruby.zip")
        }

  # Gets all environments as an array of strings      
  def self.getAllNames
    @@all.keys
  end

  # Gets the value (corrosponding zip) of the key
  def self.getTargetOf(key)
    @@all[key]
  end

  def self.extract(key, target)
    case key
    when 'gradle'
      extract_gradle(target)
    when 'java'
      extract_java(target)
    when 'python'
      extract_python(target)
    when 'ruby'
      extract_ruby(target)
    when 'maven'
      extract_maven(target)
    else
      error("#{key} is not a supported environment.\nYou can suggest it be added at https://github.com/cbrnrd/radon/issues")
    end
  end
end
end