require 'test_helper'

describe RestEjabberd do
  before do
    @client = RestEjabberd.new secret: 'secret'
    @username = 'test'
    @password = 'password'
  end

  it 'should register and unregister a user' do
    VCR.use_cassette("create and remove a user") do
      response = @client.register @username, @password

      assert response.has_key?("ok")
      assert @client.unregister @username, @password
    end
  end

  it 'should change a user password' do
    VCR.use_cassette("change user password") do
      @client.register @username, @password

      assert @client.change_password @username, @password, 'newpassword'
      assert @client.is_registered?(@username, @password)
      assert @client.unregister @username, @password
      assert !@client.is_registered?(@username, @password)
    end
  end
end
