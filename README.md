# Urls For Humans

Urls For Humans allows you to apply meaningful names to your Rails Application's urls by leveraging what happens under the covers with `Model.find(params[:id])` and `to_param`. So long as the url is prefixed with the model's id, the lookup will happen exactly how we intend it to with a few key benefits:

  * Simplicity
  * Lightweight
  * Persistent urls because changes the the latter portions of a param won't affect it's lookup.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'urls_for_humans'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install urls_for_humans
```

## Usage


To use Urls For Humans you need to extend the `UrlsForHumans` module, and call the class method `urls_for_humans`:

```ruby
class User < ActiveRecord::Base
  extend UrlsForHumans

  # ...

  urls_for_humans :first_name, :last_name

  # ...
end
```

The `urls_for_humans` method can be a collection of any information that you'd like to include in the url. For example, with the above class we'd result in:

```ruby
u = User.create(first_name: 'John', last_name: 'Otander')

u.to_param
# => '1-john-otander'

u.first_name = nil
u.to_param
# => '1-otander'
```

With this solution, an ActiveRecord object will always produce the correct url throughout the application:

```ruby
link_to user.first_name, user
# => <a href="http://localhost:3000/users/1-john-otander" 
```

Additionally, any link that hits the internet will persist because `1-random-content`, `1-other-random-content`, and `1-john-doe` will all route to the same resource.

## Resources

  * <https://github.com/norman/friendly_id>
  * <https://gist.github.com/cdmwebs/1209732>

## Contributing

1. Fork it ( http://github.com/johnotander/urls_for_humans/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
