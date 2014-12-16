# Urls for Humans

[![Build Status](https://travis-ci.org/johnotander/urls_for_humans.svg?branch=master)](https://travis-ci.org/johnotander/urls_for_humans)

Urls for Humans is a gem that allows you to apply meaningful names to your Rails Application's urls
by leveraging what happens under the covers with `Model.find(params[:id])`, `to_i`, and `to_param`.
This makes it easy to turn `users/1` to `users/1-john-otander`. So long as the url is prefixed with
the model's `id` (which Urls for Humans ensures), the lookup will happen exactly how we intend it
to with a few key benefits:

  * Simple thanks to ActiveSupport.
  * Lightweight, weighing in at roughly 20 something lines of added gem code to your Rails app (since
  ActiveSupport is already a dependency).
  * Persistent urls because changes in the latter portions of a param won't affect it's lookup.
  * There are no slugs required.

### Why use Urls for Humans in place of Friendly ID?

This is a different approach to friendly URLs than the `friendly_id` gem because it doesn't modify
the db queries themselves. The `urls_for_humans` approach essentially allows all urls fitting the
form `resource/<id>-<anything else>` to route to `resource/:id` because `to_i` is called on the
`id` parameter.

Personally, I prefer this approach because a link out there in the wild to a user's profile
`users/previous_username` isn't broken (404'd) when they change their username to `users/new_username`
because the slug has been changed.

Also, I'm biased.

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


To use Urls For Humans you need to extend the `UrlsForHumans` module, and call the class method
`urls_for_humans`:

```ruby
class User < ActiveRecord::Base
  include UrlsForHumans

  # ...

  urls_for_humans :first_name, :last_name

  # ...
end
```

The `urls_for_humans` method can be a collection of any information that you'd like to include in
the url. For example, with the above class we'd result in:

```ruby
u = User.create(first_name: 'John', last_name: 'Otander')

u.to_param
# => '1-john-otander'

u.first_name = nil
u.to_param
# => '1-otander'
```

With this solution, an ActiveRecord object will always produce the correct url throughout the
application:

```ruby
link_to user.first_name, user
# => <a href="http://localhost:3000/users/1-john-otander"
```

Additionally, any link that hits the internet will persist because `1-random-content`, `1-other-random-content`,
and `1-john-doe` will all route to the same resource.

### I don't like it when you leverage executable class bodies

That's fine. You can add a method to your model, instead.

```ruby
class User < ActiveRecord::Base
  include UrlsForHumans

  # ...

  def humanly_attrs
    [:first_name, :last_name, :favorite_food]
  end

  # ...
end
```

This will result in `"#{ id }-#{ first_name }-#{ last_name }-#{ favorite_food }"`. Yay.

## Resources

  * <https://github.com/norman/friendly_id>
  * <https://gist.github.com/cdmwebs/1209732>

## Contributing

1. Fork it ( http://github.com/johnotander/urls_for_humans/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Crafted with <3 by [John Otander](http://johnotander.com) ([@4lpine](https://twitter.com/4lpine)).
