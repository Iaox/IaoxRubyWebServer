require 'sinatra'
class App < Sinatra::Base
  enable :sessions

  def initialize(server)
    super
    @server = server
    @client_handler = @server.get_client_handler
  end
  get '/' do
    @rs_accounts = RSAccount.all
  	slim :index
  end

  get '/kick/:user' do |user|
    client = @client_handler.get_client_by_name(user)
    if !client.nil?
      client.set_should_disconnect
    end
    redirect back
  end

end