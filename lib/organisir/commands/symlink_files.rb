# frozen_string_literal: true

module Organisir
  module Commands
    class SymlinkFiles
      def initialize(source_dir, pwd, commit)
        @abs_source_dir = File.join(pwd, source_dir)
        @verbose = !commit
      end

      def link
        sub_dirs = Util.get_sub_dirs(@abs_source_dir)
        files = Dir.glob(File.join(@abs_source_dir, "*", "*.*"))
                   .reject { |f| File.directory?(f) || File.symlink?(f) || File.zero?(f) }
        print("Scanned #{files.length} files inside #{sub_dirs.length} directories in #{@abs_dest_dir}\n")

        rule = SymlinkRule.new(sub_dirs)
        files.each do |f|
          match_dirs = rule.match(f)
          next if match_dirs.nil? || match_dirs.empty?

          process(f, match_dirs)
        end
      end

      private

      def process(src_file, destination_dirs)
        print "Rule matched file #{src_file.to_s.colorize(:red)} symlinked to directorie(s) #{destination_dirs.join(", ").to_s.colorize(:red)}\n"
        return if @verbose

        destination_dirs.each do |d|
          begin
            dest = File.join(@abs_source_dir, d)
            relative_path = Pathname.new(src_file).relative_path_from(dest)
            FileUtils.ln_s(relative_path, dest, force: false, verbose: false)
          rescue Errno::EEXIST
            nil
          end
        end
      end

    end
  end
end
