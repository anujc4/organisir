# frozen_string_literal: true

module Organisir
  class SymlinkRule
    def initialize(dirs)
      @dirs = dirs
      @dir_map = {}
      @dirs.map do |dir|
        @dir_map[dir] = gen_regex_for_dir_name(dir)
      end
    end

    def match(file)
      resp = []
      filename = file.split("/").last.downcase
      file_dir = file.split("/").fetch(-2)
      @dirs.each do |d|
        next if file_dir.include? d

        resp << d if filename.downcase.match? @dir_map[d]
      end
      resp
    end

    private

    def gen_regex_for_dir_name(dir)
      tokens = dir.downcase.split
      name_token = tokens.join('\\b.*\\b')
      Regexp.new("\\b#{name_token}\\b", Regexp::EXTENDED | Regexp::IGNORECASE)
    end

  end
end
