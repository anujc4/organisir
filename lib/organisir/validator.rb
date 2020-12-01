# frozen_string_literal: true

module Organisir
  class Validator
    class << self
      def validate_start(source_dir, dest_dir)
        raise "#{source_dir} is not a valid directory path" unless File.directory?(source_dir)

        raise "#{dest_dir} is not a valid directory path" unless File.directory?(dest_dir)
      end
    end
  end
end
