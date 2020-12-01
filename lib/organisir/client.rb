# frozen_string_literal: true

module Organisir
  class Client
    def start(source_dir, dest_dir, pwd, commit)
      @abs_source_dir = File.join(pwd, source_dir)
      @abs_dest_dir = File.join(pwd, dest_dir)
      Validator.validate_start(@abs_source_dir, @abs_dest_dir)

      @verbose = !commit
      @pwd = pwd
      @file_op = FileOp.new(pwd, source_dir)
      execute_start
    end

    def symlink(source_dir, pwd, commit)
      @abs_source_dir = File.join(pwd, source_dir)
      @verbose = !commit
      @pwd = pwd
      @file_op = FileOp.new(pwd, source_dir)

      execute_symlink
    end

    private

    def execute_start
      sub_dirs = get_sub_dirs(@abs_dest_dir)
      # print sub_dirs
      print("Scanned #{sub_dirs.length} directories in #{@abs_dest_dir}\n")
      src_files = get_src_files(@abs_source_dir)
      print("Scanned #{src_files.length} files in #{@abs_source_dir}\n")

      rule = Rule.new(sub_dirs)
      src_files.each do |f|
        match_dir = rule.match(f)
        next if match_dir.nil?

        move_file(f, match_dir)
      end
      print "Process completed\n"
    end

    def execute_symlink
      sub_dirs = get_sub_dirs(@abs_source_dir)
      files = Dir.glob(File.join(@abs_source_dir, "*", "*.*"))
                 .reject { |f| File.directory?(f) || File.symlink?(f) || File.zero?(f) }
      print("Scanned #{files.length} files inside #{sub_dirs.length} directories in #{@abs_dest_dir}\n")

      rule = SymlinkRule.new(sub_dirs)
      files.each do |f|
        match_dirs = rule.match(f)
        next if match_dirs.nil? || match_dirs.empty?

        symlink_file(f, match_dirs)
      end
      print "Process completed\n"
    end

    def move_file(filename, dirname)
      print "Rule matched file #{filename.to_s.colorize(:red)} moved to directory #{dirname.to_s.colorize(:red)}\n"
      return if @verbose

      @file_op.move(filename, @abs_source_dir, File.join(@abs_dest_dir, dirname))
    end

    def symlink_file(file, match_dirs)
      print "Rule matched file #{file.to_s.colorize(:red)} symlinked to directories #{match_dirs.join(", ").to_s.colorize(:red)}\n"
      return if @verbose

      @file_op.symlink(file, match_dirs)
    end

    def get_sub_dirs(dir)
      Dir.chdir(dir)
      sub_dirs = Dir["*"].select { |o| File.directory?(o) }
      Dir.chdir(@pwd)
      sub_dirs
    end

    def get_src_files(dir)
      Dir.entries(dir).reject { |f| File.directory? f }
    end
  end
end
