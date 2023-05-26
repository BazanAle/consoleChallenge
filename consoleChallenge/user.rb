class User
  attr_reader :user_name, :password, :users

  def initialize(user_name, password)
   @user_name = user_name
   @password = password
  end

  def authenticate(password)
    @password == password
  end


end