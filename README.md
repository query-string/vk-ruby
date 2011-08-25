#vk-ruby
Ruby wrapper for vk.com API 

## Installation
`gem install vk-ruby`

## What is needed to work with api?
1. Create an object type of application you require (Serverside, Standalone, Secure)
2. Authorize [doc](http://vkontakte.ru/developers.php?o=-1&p=%D0%90%D0%B2%D1%82%D0%BE%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F&s=0)

```.ruby
# Serverside Application
require 'vk-ruby'

app =  VK::Serverside.new(:app_id => APP_ID, :app_secret => APP_SECRET)

if params = app.authorize(CODE) 
   app.search(:q => 'Sting', :access_token => params['access_token']).each do |track|
     puts track.inspect  # => Sting tracks
   end
end
```
## Application Example

- ##### Standalone:

    [vk-console](http://github.com/zinenko/vk-console )

- ##### Serverside & secure server

    [social_app](https://github.com/zinenko/social_app)

## Tests

Coming soon!

## Contributing to vk-ruby
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.


## Copyright

Copyright (c) 2011 Andrew Zinenko. See LICENSE.txt for
further details.