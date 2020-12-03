# frozen_string_literal: true

module Organisir
  class Util

    class << self
      def get_sub_dirs(dir)
        Dir.chdir(dir) do
          Dir["*"].select { |o| File.directory?(o) }
        end
      end
    end

  end
end
