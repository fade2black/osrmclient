# Osrmclient

Ruby interface to query Open Source Routing Machine servers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'osrmclient'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install osrmclient

## Usage
```ruby
  client = Osrmclient.new(server: 'http://router.project-osrm.org')

  puts "'locate' example:"
  response = client.locate(lat:37.9113, lon:58.3771)
  puts "Response: #{response.body}"
  puts "----------------------------------"

  puts "'nearest' example:"
  response = client.nearest(lat:37.9113, lon:58.3771)
  puts "Response: #{response.body}"
  puts "----------------------------------"

  response = client.viaroute(lat1:37.8954, lon1:58.3640, lat2:37.8968, lon2:58.3619, z: 18, geometry: true)
  puts "Response: #{response.body}"
  puts "----------------------------------"

  puts "'table' example:"
  response = client.table(locations:{lat1:52.554070, lon1:13.160621, lat2:52.431272, lon2:13.720654, lat3:52.554070, lon3:13.720654, lat4:52.554070, lon4:13.160621}, z:18)
  puts "Response: #{response.body}"
  puts "----------------------------------"
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/osrmclient/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
