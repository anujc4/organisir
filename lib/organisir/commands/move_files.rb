# frozen_string_literal: true

module Organisir
  module Commands
    class MoveFiles
      def initialize(source_dir, dest_dir, pwd, commit)
        @abs_source_dir = File.join(pwd, source_dir)
        @abs_dest_dir = File.join(pwd, dest_dir)
        Validator.validate_start(@abs_source_dir, @abs_dest_dir)

        @verbose = !commit
        @pwd = pwd
      end

      def move
        sub_dirs = Util.get_sub_dirs(@abs_dest_dir)

        print("Scanned #{sub_dirs.length} directories in #{@abs_dest_dir}\n")
        src_files = get_src_files(@abs_source_dir)
        print("Scanned #{src_files.length} files in #{@abs_source_dir}\n")

        rule = Rule.new(sub_dirs)
        src_files.each do |f|
          match_dir = rule.match(f).min

          next if match_dir.nil? || match_dir.empty?

          process(f, match_dir)
        end
      end

      private

      def get_src_files(dir)
        Dir.entries(dir).reject { |f| File.directory? f }
      end

      def process(filename, dirname)
        print "Rule matched file #{filename.to_s.colorize(:red)} moved to directory #{dirname.to_s.colorize(:red)}\n"
        return if @verbose

        src = File.join(@abs_source_dir, filename)
        dest = File.join(File.join(@abs_dest_dir, dirname), filename)
        FileUtils.move(src, dest, force: false, verbose: false)
      end

    end
  end
end
