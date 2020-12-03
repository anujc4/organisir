# frozen_string_literal: true

require "fileutils"
require "thor"
require "colorize"
require "pathname"
require "pry"

module Organisir
end

require "organisir/cli"
require "organisir/commands/clean_symlinks"
require "organisir/commands/move_files"
require "organisir/commands/multi_symlink_files"
require "organisir/commands/symlink_files"
require "organisir/rule"
require "organisir/symlink_rule"
require "organisir/util"
require "organisir/validator"
require "organisir/version"
