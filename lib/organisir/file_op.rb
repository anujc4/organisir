# frozen_string_literal: true

require "fileutils"

module Organisir
  class FileOp
    def initialize(root_dir, source_dir)
      @root_dir = root_dir
      @source_dir = source_dir
    end

    def move(filename, source_path, destination_path)
      src = File.join(source_path, filename)
      dest = File.join(destination_path, filename)
      FileUtils.move(src, dest, force: false, verbose: false)
    end

    def symlink(src_file, destination_dirs)
      filename = File.basename(src_file)
      destns = destination_dirs.map do |p|
        File.join(@root_dir, @source_dir, p, filename)
      end
      destns.each do |d|
        begin
          FileUtils.ln_s(src_file,d , force: false, verbose: false)
        rescue Errno::EEXIST
          nil
        end
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
