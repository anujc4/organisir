# frozen_string_literal: true

require "thor"

module Organisir
  class Cli < Thor
    def self.exit_on_failure?
      true
    end

    COMMANDS = {
      start: %w[
        Move files from a source directory to a destination directory based on the filename of all files inside
        the source directory. Only files present in the source directory will be scanned and moved. The destination
        directory should ideally contain multiple directories where you would want your files to move.
      ].join(" "),
      organise: "Alias of start",
      symlink: %w[
        Scan all directories inside a directory and the files contained in each of them (upto one level). Each file
        which matches multiple rules will have a symlink created in each directory where the rule was matched. The
        original file will not be moved and new symlinks will refer to the original file path.
      ].join(" "),
      clean: %w[
        Remove all dangling symlinks from a directory by scanning through all the directories inside the given
        source directory
      ].join(" "),
      version: "Display installed tmuxinator version"
    }.freeze

    desc "start source destination", "Move files from source to destination directory"
    option :source, aliases: :s, required: true, type: :string
    option :destination, aliases: :d, required: true, type: :string
    option :commit, type: :boolean, default: false

    def start
      if options[:commit]
        say "Preparing to move files in 5 seconds. Cancel the command by pressing Ctrl-C"
        # sleep(5)
      else
        say "Start command always runs in non-commit mode. Use --commit true to permanently move files.", :red
      end
      pwd = Dir.pwd
      Organisir::Client.new.start(options[:source], options[:destination], pwd, options[:commit])
    rescue Interrupt
      say "Exiting organisir...", :green
    end

    desc "source", "Symlink files in nested directories to matching sub-directories within the given directory"
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
