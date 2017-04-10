class Seeder

  def self.seed!
    self.rs_account
  end

  def self.rs_account
    RSAccount.create(
                 :username => "kore12@gmail.com",
                 :password => "pass123"
    )

    RSAccount.create(
        :username => "kore10@gmail.com",
        :password => "pass123"
    )

    RSAccount.create(
        :username => "godhemsg13@gmail.com",
        :password => "pass123"
    )
  end

end