class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    {user: user.attributes.merge(profile: user.profile_pic.attached? ? url_for(user.profile_pic) : '', token: JsonWebToken.encode(user_id: user.id)) } if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)
    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end