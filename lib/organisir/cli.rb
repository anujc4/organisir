# frozen_string_literal: true

require "thor"

module Organisir
  class Cli < Thor
    def self.exit_on_failure?
      true
    end

    desc "move source destination", "Move files from source to destination directory"
    option :source, aliases: :s, required: true, type: :string
    option :destination, aliases: :d, required: true, type: :string
    option :commit, type: :boolean, default: false

    def move
      if options[:commit]
        say "Preparing to move files in 5 seconds. Cancel the command by pressing Ctrl-C"
        sleep(5)
      else
        say "move command always runs in non-commit mode. Use --commit true to permanently move files.", :red
      end
      Organisir::Commands::MoveFiles.new(options[:source], options[:destination], Dir.pwd, options[:commit]).move
      say "Process completed"
    rescue Interrupt
      say "Exiting organisir...", :green
    end

    desc "symlink source destination[optional]", "Symlink files in nested directories to matching sub-directories within the given directory"
    option :source, aliases: :s, required: true, type: :string
    option :commit, type: :boolean, default: false
    def symlink
      if options[:commit]
        say "Preparing to symlink files in 5 seconds. Cancel the command by pressing Ctrl-C"
        sleep(5)
      else
        say "symlink command always runs in non-commit mode. Use --commit true to symlink files.", :red
      end
      Organisir::Commands::SymlinkFiles.new(options[:source], Dir.pwd, options[:commit]).link
      say "Process completed"
    rescue Interrupt
      say "Exiting organisir...", :green
    end

    desc "multi_symlink source destination",
         "Symlink files present in a source directory to matching sub-directories within the given destination directory"
    option :source, aliases: :s, required: true, type: :string
    option :destination, aliases: :d, required: true, type: :string
    option :commit, type: :boolean, default: false
    def multi_symlink
      if options[:commit]
        say "Preparing to symlink files in 5 seconds. Cancel the command by pressing Ctrl-C"
        sleep(5)
      else
        say "multi_symlink command always runs in non-commit mode. Use --commit true to symlink files.", :red
      end
      Organisir::Commands::MultiSymlinkFiles.new(options[:source], options[:destination], Dir.pwd, options[:commit]).link
      say "Process completed"
    rescue Interrupt
      say "Exiting organisir...", :green
    end

    desc "clean_symlinks source", "Removes all symlinks inside directory and its subdirectories"
    option :source, aliases: :s, required: true, type: :string
    option :commit, type: :boolean, default: false
    option :all, type: :boolean, default: false
    def clean_symlinks
      if options[:commit]
        say "Preparing to remove all symlinks in 5 seconds. Cancel the command by pressing Ctrl-C"
        sleep(5)
      else
        say "clean_symlinks command always runs in non-commit mode. Use --commit true to remove symlinks.", :red
      end
      Organisir::Commands::CleanSymlinks.new(options[:source], Dir.pwd, options[:commit], options[:all]).clean
      say "Process completed"
    rescue Interrupt
      say "Exiting organisir...", :green
    end
  end
end
