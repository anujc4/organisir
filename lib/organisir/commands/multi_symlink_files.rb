# frozen_string_literal: true

module Organisir
  module Commands
    class MultiSymlinkFiles

      def initialize(source_dir, destination_dir, pwd, commit)
        @abs_source_dir = File.join(pwd, source_dir)
        @abs_destination_dir = File.join(pwd, destination_dir)
        @verbose = !commit
      end

      def link
        sub_dirs = Util.get_sub_dirs(@abs_destination_dir)
        print("Scanned #{files.length} files inside #{sub_dirs.length} directories in #{@abs_dest_dir}\n")
        rule = Rule.new(sub_dirs)
        files.each do |f|
          match_dirs = rule.match(f)
          next if match_dirs.nil? || match_dirs.empty?

          process(f, match_dirs)
        end
      end

      private

      def files
        Dir.glob(File.join(@abs_source_dir, "**", "*"))
           .reject { |f| File.directory?(f) || File.symlink?(f) || File.zero?(f) }
      end

      def process(file, dirs)
        print "Rule matched file #{file.to_s.colorize(:red)} symlinked to directory(s) #{dirs.join(", ").to_s.colorize(:red)}\n"
        return if @verbose

        dirs.each do |d|
          begin
            dest = File.join(@abs_destination_dir, d)
            relative_path = Pathname.new(file).relative_path_from(dest)
            FileUtils.ln_s(relative_path, dest, force: false, verbose: false)
          rescue Errno::EEXIST
            nil
          end
        end
      end

    end
  end
end
