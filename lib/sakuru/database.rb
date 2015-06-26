require "open-uri"
require "json"

module Sakuru
  class Database
    attr_reader :files
    def initialize
      @inverted_index = {}
      @files = []
    end

    def add(path)
      if @files.include?(path)
        id = @files.index(path)
        @inverted_index.each do |key, posting_list|
          @inverted_index[key].delete(id)
        end
      else
        @files << path
        id = @files.index(path)
      end

      open(path) do |file|
        file.each_line do |line|
          # TODO: normalize and tokenize.
          line.split(/\s+/).each do |word|
            next if word.empty?
            @inverted_index[word] ||= []
            # TODO: add position
            @inverted_index[word] << id
          end
        end
      end
    end

    def search(query)
      results = {}
      # TODO: normalize and tokenize.
      ids = @inverted_index[query]
      ids.each do |id|
        file = @files[id]
        results[file] ||= 0
        results[file] += 1
      end
      results
    end

    def save(output_path)
      data = {
        "files" => @files,
        "inverted_index" => @inverted_index,
      }
      File.open(output_path, "w") do |file|
        JSON.dump(data, file)
      end
    end

    def load(saved_file_path)
      data = JSON.load(File.read(saved_file_path))
      @files = data["files"]
      @inverted_index = data["inverted_index"]
    end
  end
end
