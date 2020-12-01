# frozen_string_literal: true

require "fileutils"

module Organisir
  class FileOp
    def initialize(root_dir)
      @root_dir = root_dir
    end

    def move(filename, source_path, destination_path)
      src = File.join(source_path, filename)
      dest = File.join(destination_path, filename)
      # print "mv#{false ? ' -f' : ''} #{[src,dest].flatten.join ' '}\n".colorize(:green)
      FileUtils.move(src, dest, force: false, verbose: false)
    end

    def symlink(src_file, destination_dirs)
      filename = src_file.split("/").last
      destns = destination_dirs.map do |p|
        File.join(@root_dir, p, filename)
      end

      destns.each do |d|
        FileUtils.symlink(src_file, d, force: false, verbose: true)
      end
    end

    def clean(link, path)
      src = File.join(@root_dir, path, link)
      # Last explicit check to see if the file indeed is a symlink
      return unless File.symlink?(src)

      FileUtils.remove(src)
    end
  end
end
