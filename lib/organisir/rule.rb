# frozen_string_literal: true

module Organisir
  class Rule
    def initialize(dirs)
      @dirs = dirs
      @dir_map = {}
      @dirs.map do |dir|
        @dir_map[dir] = gen_regex_for_dir_name(dir)
      end
    end

    def match(file)
      resp = []
      @dir_map.keys.each do |k|
        resp << k if file.downcase.match(@dir_map[k])
      end

      resp.min unless resp.empty?
    end

    private

    def gen_regex_for_dir_name(dir)
      tokens = dir.downcase.split
      # TODO: Verify if this regex rule can be deprecated
      # name_token = tokens.join('\\b.*\\b')
      # Regexp.new("\\b#{name_token}\\b", Regexp::EXTENDED | Regexp::IGNORECASE)
      name_token = tokens.join(".*")
      Regexp.new(".*#{name_token}.*", Regexp::EXTENDED | Regexp::IGNORECASE)
    end
  end
end
