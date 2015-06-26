require "optparse"
require "sakuru/version"

module Sakuru
  class Command
    def self.run(arguments)
      new(arguments).run
    end

    def initialize(arguments)
      @options = parse_options(arguments)
    end

    def run
    end

    private
    def parse_options(arguments)
      options = {}

      parser = OptionParser.new(<<-USAGE)
Usage:
  require "sakuru"

  db = Sakuru::Database.new
  db.add(file_path)
  db.add(uri)
  db.search(query)
  db.save(output_path)
  db.load(saved_file_path)
      USAGE

      parser.version = VERSION

      parser.parse!(arguments)

      options
    end
  end
end
