# Mu::Hash

Converts an Hash to an object whose attributes behave like methods.

Fights `NoMethodError` on `nil` objects by enforcing a strict access to your data structure. 💪

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mu-hash'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install mu-hash
```

## Usage

```ruby
# Suppose this is an hash you have to deal with:
source = {
  'service' => {
    'username' => 'foo',
    'password' => 'bar',
  },
}

# Convert it to a Mu::Hash instance:
content = Mu::Hash.new(source)

# Here's how you can access values:
content.service.username.unwrap # => 'foo'
content.service.password.unwrap # => 'bar'

content.service.unwrap # => { 'username' => 'foo', 'password' => 'bar' }

content.service['username'].unwrap # => 'foo'
content.service['password'].unwrap # => 'bar'

content['service']['username'].unwrap # => 'foo'
content['service']['password'].unwrap # => 'bar'

content.service.something_that_does_not_exist # => raises a Mu::Hash::Error
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mu-hash. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mu::Hash project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mu-hash/blob/master/CODE_OF_CONDUCT.md).
