require 'socket'

class RSServer

  def initialize
    @clientHandler = ClientHandler.new
    @server = TCPServer.new 2000
    puts "Server is running at port: 2000"

    ##Start a new connection thread
    Thread.new do
    loop do
      handle_connection
      end
    end

    ##Start a new "Update loop" which will update every 10 second
    Thread.new do
      loop do
        update_clients
        sleep 10
      end
    end

  end

  def handle_connection
    client = @server.accept
    puts "We got a new connection"
    client.puts "NAME"
    name = client.readline.to_s.chomp

    if !name.nil?
      @clientHandler.add(Client.new(client, name))
    end
  end

  def update_clients
    @clientHandler.get_clients.each do |client|
      if !client.is_connected?
        @clientHandler.remove(client)
      end
    end
  end

  def get_client_handler
    return @clientHandler
  end
end






