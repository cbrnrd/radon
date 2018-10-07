require 'paint'

def vprint(*args)
  puts args if $verbose && !$quiet
end

def error(*args)
  puts Paint["ERROR", '#e74c3c'] + " - #{args}"
end

def create(fname)
  puts Paint["  create", '#2ecc71'] + " #{fname}" unless $quiet
end

def skip(fname)
  puts Paint["  skip", '#f1c40f'] + " #{fname}" unless $quiet
end