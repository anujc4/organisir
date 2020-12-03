# frozen_string_literal: true

module Organisir
  module Commands
    class CleanSymlinks
      def initialize(source_dir, pwd, commit, all)
        @abs_source_dir = File.join(pwd, source_dir)
        @verbose = !commit
        @all = all
      end

      def clean
        fetch_all_symlinks.each do |sym|
          print "Delete symlink #{sym.to_s.colorize(:red)}.\n"
          File.delete(sym) unless @verbose
        end
      end

      private

      def fetch_all_symlinks
        Dir.glob(File.join(@abs_source_dir, "**", "*")).filter do |f|
          @all ? File.symlink?(f) : File.symlink?(f) && File.exist?(f)
        end
      end

    end
  end
end
