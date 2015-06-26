# Sakuru [![Gem Version](https://badge.fury.io/rb/sakuru.svg)](http://badge.fury.io/rb/sakuru)

A tiny full-text search engine by pure Ruby.

## Installation

    $ gem install sakuru

## Usage

```ruby
require "sakuru"

db = Sakuru::Database.new
db.add(file_path)
db.add(uri)
db.search(query)
db.save(output_path)
db.load(saved_file_path)
```

## License

MIT License. See LICENSE.txt for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
