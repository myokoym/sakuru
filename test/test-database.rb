require "tempfile"
require "sakuru/database"

class DatabaseTest < Test::Unit::TestCase
  def setup
    @database = Sakuru::Database.new
  end

  def test_add
    @database.add(__FILE__)
    assert_equal([__FILE__], @database.files)
  end

  def test_search
    @database.add(__FILE__)
    assert_equal({__FILE__ => 1},
                 @database.search("DatabaseTest"))
  end

  def test_save
    @database.add(__FILE__)
    file = Tempfile.new("sakuru")
    @database.save(file)
    file.flush
    assert_equal([__FILE__],
                 JSON.load(file)["files"])
  end

  def test_load
    data = {
      "files" => ["piyo.txt"],
      "inverted_index" => {},
    }
    file = Tempfile.new("sakuru")
    JSON.dump(data, file)
    file.flush
    @database.load(file)
    assert_equal(["piyo.txt"],
                 @database.files)
  end
end
