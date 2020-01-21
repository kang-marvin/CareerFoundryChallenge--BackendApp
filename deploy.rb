#!/usr/bin/env ruby

# -----------------------------------------------------
# Ruby/Rails Heroku Deployment Script
# @author Daniel Berkompas
#
# After downloading, run `ruby deploy.rb --help` to
# get usage instructions.
#
# MIT License
# -----------------------------------------------------
require 'optparse'

# Set default options
options = {
  migrations:   true,
  branch:       "master",
  remote:       "production",
  env:          "staging",
  clear_cache:  false
}

# Interpret passed in options
OptionParser.new do |opts|
  # Usage instructions.  Access with the --help flag
  opts.banner = "Usage: ruby deploy.rb [options]"

  opts.separator ""
  opts.separator "Required options:"

  # Required Arguments
  opts.on("--env [ENV]", String, "Environment to deploy to. 'staging' or 'production'") do |v|
    options[:env] = v unless v.nil?

    if options[:env] == "production"

      options[:branch] = "master"
      options[:remote] = "production"

    elsif options[:env] == "staging"

      options[:branch] = "staging"
      options[:remote] = "staging"
      options[:clear_cache] = true

    end
  end

  # Optional Argument

  opts.separator ""
  opts.separator "Optional options:"

  # Determines whether to run migrations or not. Default: migrations run.
  opts.on("-n", "--no-migrations", "Don't run `heroku run rake db:migrate`. They run by default.") do |v|
    options[:migrations] = v.nil?
  end

  # Optional Argument
  # Determines which branch to push to Heroku. Default: master
  opts.on("--branch [BRANCH]", String, "Select a branch to push. e.g. '-b feature_something' Default: master") do |v|
    options[:branch] = v unless v.nil?
  end

  # Optional Argument
  # Determines which remote to push to.  Default: production
  opts.on("--remote [REMOTE]", String, "Set the remote to push to. e.g. '-r staging' Default: production") do |v|
    options[:remote] = v unless v.nil?
  end
end.parse!

# Enanble Zero-Downtime Deploy (aka Heroku Preboot)
if options[:env] == "production"
  puts "\n\n"
  puts "----------------------------------------------------"
  puts " Enabling Heroku Preboot"
  puts "----------------------------------------------------"
  system "heroku features:enable preboot --remote #{options[:remote]}"
end

# Update branch
puts "\n\n"
puts "----------------------------------------------------"
puts "1. Checkout and pull latest branch"
puts "----------------------------------------------------"
puts "Branch: #{options[:branch].upcase}"

system "git checkout #{options[:branch]}"
system "git pull"

# Deploy Code
puts "----------------------------------------------------"
puts "2. Deploying Code to Heroku"
puts "----------------------------------------------------"
puts "Branch:         #{options[:branch].upcase}"
puts "Remote:         #{options[:remote].upcase}"
puts "Run Migrations? #{options[:migrations].to_s.upcase}"
puts "Clear cache?    #{options[:clear_cache] == true ? 'YES' : 'NO'}"
puts "----------------------------------------------------"

if options[:env] == "production"
  system "git push -f #{options[:remote]} master"
else
  system "git push -f #{options[:remote]} #{options[:branch]}:master"
end

# Run migrations
if options[:migrations] == true
  puts "\n\n"
  puts "----------------------------------------------------"
  puts "2. Running Migrations"
  puts "----------------------------------------------------"

  # puts "Backing up database..."
  # system "heroku pgbackups:capture --expire --remote #{options[:remote]}"

  puts "Putting site in maintenance mode..."
  system "heroku maintenance:on --remote #{options[:remote]}"

  puts "Running migrations..."
  if options[:remote] == "production"
    system "heroku run rake db:migrate --remote #{options[:remote]}"
  else
    system "heroku run rake db:migrate --remote #{options[:remote]}"
  end

  puts "Taking site out of maintenance mode..."
  system "heroku maintenance:off --remote #{options[:remote]}"
end

# Clear Data Cache
if options[:clear_cache] == true
  puts "\n\n"
  puts "----------------------------------------------------"
  puts " Clear Data Cache"
  puts "----------------------------------------------------"

  # system "heroku run rake cache:clear_data_cache --remote #{options[:remote]}"
end

# Disabling Heroku Preboot
if options[:env] == "production" && options[:disable_zdd] == false
  puts "\n\n"
  puts "----------------------------------------------------"
  puts " Disabling Heroku Preboot"
  puts "----------------------------------------------------"
  system "heroku features:disable preboot --remote #{options[:remote]}"
end

puts "\n\n"
puts "Done!  Your code is now live."
puts "\n\n"