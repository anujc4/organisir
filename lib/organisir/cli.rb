# frozen_string_literal: true

require "thor"

module Organisir
  class Cli < Thor
    def self.exit_on_failure?
      true
    end

    desc "start source destination", "Move files from source to destination directory"
    option :source, aliases: :s, required: true, type: :string
    option :destination, aliases: :d, required: true, type: :string
    option :commit, type: :boolean, default: false

    def start
      if options[:commit]
        say "Preparing to move files in 5 seconds. Cancel the command by pressing Ctrl-C"
        sleep(5)
      else
        say "Start command always runs in non-commit mode. Use --commit true to permanently move files.", :red
      end
      pwd = Dir.pwd
      Organisir::Client.new.start(options[:source], options[:destination], pwd, options[:commit])
    rescue Interrupt
      say "Exiting organisir...", :green
    end

    desc "symlink", "Symlink files in nested directories to matching sub-directories within the given directory"
    option :source, aliases: :s, required: true, type: :string
    option :commit, type: :boolean, default: false
    def symlink
      if options[:commit]
        say "Preparing to symlink files in 5 seconds. Cancel the command by pressing Ctrl-C"
        # sleep(5)
      else
        say "Symlink command always runs in non-commit mode. Use --commit true to symlink files.", :red
      end
      pwd = Dir.pwd
      Organisir::Client.new.symlink(options[:source], pwd, options[:commit])
    rescue Interrupt
      say "Exiting organisir...", :green
    end
  end
end
