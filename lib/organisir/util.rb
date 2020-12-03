# frozen_string_literal: true

module Organisir
  class Util

    class << self
      def get_sub_dirs(dir)
        Dir.chdir(dir) do
          Dir["*"].select { |o| File.directory?(o) }
        end
      end

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
end
