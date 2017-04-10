class ClientHandler
  @clients
  @active_rs_accounts

  def initialize
    @clients = Array.new
    @active_rs_accounts = Array.new
  end

  def add(client)
    @clients.push(client)
  end

  def remove(client)
    if @clients.include?(client)
      if !client.get_rs_account.nil?
        client.get_rs_account.update(:available => true)
      end
      @clients.delete(client)
    end
  end

  def get_clients
    return @clients
  end

  def get_client_by_name(name)
    @clients.each do |client|
      if client.get_name == name
        return client
      end
    end
    return nil
  end

end