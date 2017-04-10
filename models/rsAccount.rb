class RSAccount
  include DataMapper::Resource

  property :id,                          Serial
  property :username,                    String
  property :password,                    String
  property :available,                   Boolean, :default => true
  property :completed_tutorial_island,   Boolean, :default => false

end
