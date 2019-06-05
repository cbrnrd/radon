require 'core/constants'
module Radon
class Environments

  # The list of all supported environments and their associeted data paths
  @@all = {
          'gradle' => File.join(DATA_DIR, 'gradle.zip'),
          'java'   => File.join(DATA_DIR, 'java.zip'),
          'maven'  => File.join(DATA_DIR, 'maven.zip'),
          'python' => File.join(DATA_DIR, 'python.zip'),
          'c'      => File.join(DATA_DIR, 'c.zip'),
          'ruby'   => File.join(DATA_DIR, 'ruby.zip'),
          'crystal'=> File.join(DATA_DIR, 'crystal_app.zip'),
          'go_s'   => File.join(DATA_DIR, 'go_s.zip'),
          'website'=> File.join(DATA_DIR, 'website.zip')
        }

  # Gets all environments as an array of strings
  def self.get_all_names
    @@all.keys
  end

  # Gets the value (corrosponding zip) of the key
  def self.get_target_of(key)
    @@all[key]
  end

  # Extract the zip
  def self.extract(key, target)
    envs = get_all_names
    if envs.include? key
      send "extract_#{key}", target
    else
      fail_with("#{key} is not a supported environment.\nYou can suggest it be added at https://github.com/cbrnrd/radon/issues")
    end
  end

end
end
