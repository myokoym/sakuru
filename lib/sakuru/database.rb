require "open-uri"
require "json"
require "sakuru/tokenizer/bigram"

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
          # TODO: normalize
          Tokenizer::Bigram.tokenize(line).each do |token|
            next if token.empty?
            @inverted_index[token] ||= []
            # TODO: add position
            @inverted_index[token] << id
          end
        end
      end
    end

    def search(query)
      results = {}
      # TODO: normalize
      tokens = Tokenizer::Bigram.tokenize(query)
      posting_lists = tokens.collect do |token|
        @inverted_index[token]
      end
      ids = nil
      posting_lists.each do |posting_list|
        unless posting_list
          ids = []
          break
        end
        # TODO: check position
        if ids
          ids &= posting_list
        else
          ids = posting_list
        end
      end
      return results unless ids
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
