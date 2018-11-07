require 'fileutils'
require 'json'
module Radon
class Util
  def self.first_run
    return if (File.directory?(SETTINGS_DIR) && File.exist?(SETTINGS_FILE))
    puts "Performing first time setup..."
    
    # Make settings dir
    FileUtils.mkdir_p(SETTINGS_DIR)
    vprint("Creating #{SETTINGS_DIR}")

    puts "Welcome to radon! It looks like it's your first time running radon."
    email    = ask "  Email: "
    gh_uname = ask "  GitHub username: "

    data = {
      :email => email,
      :username => gh_uname
    }

    File.write(File.join(SETTINGS_DIR, 'settings.json'), JSON.pretty_generate(data))
    vprint "Writing settings to #{File.join(SETTINGS_DIR, 'settings.json')}"
  end

  def self.get_email
    JSON.parse(File.read(SETTINGS_FILE))['email']
  end

  def self.get_github_username
    JSON.parse(File.read(SETTINGS_FILE))['username']
  end
  
end
end
