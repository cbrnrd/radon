# The version
VERSION = "0.1.6"

# The root of this project
PROJECT_ROOT = File.absolute_path(File.join(File.dirname(__FILE__), "..", ".."))

# Settings pertaining to radon
SETTINGS_DIR = File.join(Dir.home, '.periodic', 'radon')

# The settings json file
SETTINGS_FILE = File.join(SETTINGS_DIR, 'settings.json')

# The base periodic settings path
BASE_SETTINGS_DIR = File.join(Dir.home, '.periodic')

# The folder containing zips and b64 files
DATA_DIR = File.absolute_path(File.join(PROJECT_ROOT, "data"))

AUTHORS = {
  'Carter Brainerd' => '0xCB[at]protonmail[dot]com'
}
