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

    puts "Welcome to radon! It looks like it's your first time running."
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

  # Cross-platform way of finding an executable in the $PATH.
  #
  #   which('ruby') #=> /usr/bin/ruby
  def self.which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
      exts.each { |ext|
        exe = File.join(path, "#{cmd}#{ext}")
        return exe if File.executable?(exe) && !File.directory?(exe)
      }
    end
    return nil
  end

  def open_in_vscode(path)
    fail_with('`code` program is not in $PATH') if Radon::Util.which('code').nil?
    `cd #{path} && code .`
  end

  def open_in_atom(path)
    fail_with('`atom` program is not in $PATH') if Radon::Util.which('atom').nil?
    `cd #{path} && atom .`
  end

  def open_in_editor(opts, path)
    open_in_vscode(path) if opts[:open_vscode]
  rescue StandardError => e
    report_error_to_github(e)
  end

end
end

def fail_with(reason)
  error(reason)
  exit 1
end


