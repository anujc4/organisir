# frozen_string_literal: true

module Organisir
  class Rule
    def initialize(dirs)
      @dirs = dirs
      @dir_map = {}
      @dirs.map do |dir|
        @dir_map[dir] = Util.gen_regex_for_dir_name(dir)
      end
    end

    def match(file)
      resp = []
      @dir_map.keys.each do |k|
        resp << k if file.downcase.match(@dir_map[k])
      end

      resp
    end

  end
end
