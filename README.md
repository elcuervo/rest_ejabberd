# RestEjabberd

Ruby interface to ejabberd's [https://github.com/jadahl/mod_restful](mod_restful)

This allows to:

* create a user
* delete a user
* check existance
* change password

```ruby
client = RestEjabberd.new secret: 'shhhhh', host: 'chat.server.com/api/'
client.register 'me@localhost', '123123'
client.is_registered? 'me@localhost'
#=> true
client.change_password 'me@localhost', '123123', 'asdasd'
#=> true
client.unregister 'me@localhost', 'asdasd'
#=> true
```
