require 'json'
require 'uri'
require 'net/http'

class RestEjabberd
  def initialize(attributes = {})
    @api = URI.parse attributes.fetch(:api_url, 'http://localhost:8088/api/')
    @secret = attributes.fetch(:secret)
    @client = Net::HTTP.new(@api.host, @api.port)
    @client.set_debug_output $stdout if ENV['DEBUG']
  end

  def register(username, password, host = @api.host)
    url = @api + "admin"
    request = prepare_request(Net::HTTP::Post.new(url.request_uri))
    request.body = command('register', username, host, password)

    JSON.parse @client.request(request).body
  end

  def unregister(username, password, host = @api.host)
    url = @api + "admin"
    request = prepare_request(Net::HTTP::Post.new(url.request_uri))
    request.body = command('unregister', username, host)

    response = JSON.parse(@client.request(request).body)
    response.has_key?("ok")
  end

  def change_password(username, old_password, new_password, host = @api.host)
    url = @api + 'register/change_password'
    request = prepare_request(Net::HTTP::Post.new(url.request_uri))
    request.body = change_password_command(username, host, old_password, new_password)

    @client.request(request).body == '"ok"'
  end

  def is_registered?(username, password, host = @api.host)
    url = @api + "register/is_registered?username=#{username}&host=#{host}&key=#{@secret}"
    request = prepare_request(Net::HTTP::Get.new(url.request_uri))
    @client.request(request).body == 'true'
  end

  private

  def command(command, *args)
    {
      key: @secret,
      command: command,
      args: args
    }.to_json
  end

  def change_password_command(username, host, old_password, new_password)
    # { "key":"secret", "username":"t1", "host":"localhost", "old_password":"hejhej", "new_password":"sansan" }
    {
      key: @secret,
      username: username,
      host: host,
      old_password: old_password,
      new_password: new_password
    }.to_json
  end

  def prepare_request(request)
    request['Content-Type'] = 'application/json'
    request
  end
end
