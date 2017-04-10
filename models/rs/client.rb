class Client

  def initialize(socket, name)
    @is_connected = true
    @name = name
    puts name + " Connected"
    Thread.new do
      loop do
        request = socket.readline.chomp.to_s
        if !@is_connected
          puts "Lets close the connection"
          socket.puts("DISCONNECT")
        end
        case request
          when "DISCONNECT"
            set_should_disconnect
            puts "Lets close the connection"
            socket.puts("DISCONNECT")
          when "POLL_MULE"
            puts "Thread: #{get_name} is requesting a mule"
            puts "no available mule"
            socket.puts("NO_AVAILABLE_MULE")
          when "POLL_ACCOUNT"
            puts "Thread: #{get_name} is requesting an account"
            if !@rs_account.nil?
              @rs_account.update(:available => true)
            end
            @rs_account = RSAccount.first(:available => true, :completed_tutorial_island => false)
            if !@rs_account.nil?
              puts "lets send account"
              socket.puts("POLL_ACCOUNT:#{@rs_account.username}:#{ @rs_account.password}")
              @rs_account.update(:available => false)
            else
              puts "No available account"
              socket.puts("NO_AVAILABLE_ACCOUNT")
            end
          when "PING"
            puts "Thread is alive."
            socket.puts("PING")
          when "COMPLETED_TUTORIAL"
            puts "account completed tutorial"
            @rs_account.update(:completed_tutorial_island => true)
            socket.puts("UPDATED_TUTORIAL_STATUS")
          else
            puts "Unkown request: #{request}"
            socket.puts("UNKOWN_REQUEST")
        end
      end
    end
  end

  def set_should_disconnect
   @is_connected = false
  end

  def is_connected?
    return @is_connected
  end

  def get_name
    return @name
  end

  def get_rs_account
    return @rs_account
  end
end