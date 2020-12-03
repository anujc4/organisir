# frozen_string_literal: true

module Organisir
  class SymlinkRule
    def initialize(dirs)
      @dirs = dirs
      @dir_map = {}
      @dirs.map do |dir|
        @dir_map[dir] = Util.gen_regex_for_dir_name(dir)
      end
    end

    def match(file)
      resp = []
      filename = File.basename(file).downcase
      file_dir = File.basename(File.dirname(file))
      @dirs.each do |d|
        next if file_dir.include? d

        resp << d if filename.downcase.match?(@dir_map[d])
      end
      resp
    end

  end
end
