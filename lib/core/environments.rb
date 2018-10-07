require "core/constants"
module Radon
class Environments
  @@all = {
          'gradle' => File.join(DATA_DIR, "gradle.zip"),
          'java'   => File.join(DATA_DIR, "java.zip"),
          'python' => File.join(DATA_DIR, "python.zip"),
          'ruby'   => File.join(DATA_DIR, "ruby.zip")
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
      extractGradle(target)
    when 'java'
      extractJava(target)
    when 'python'
      extractPython(target)
    when 'ruby'
      extractRuby(target)
    else
      error("#{key} is not a supported environment.\nYou can suggest it be added at https://github.com/cbrnrd/krypton/issues")
    end
  end
end
end