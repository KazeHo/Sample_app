module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end # end def sing_in(user)


  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end # end def sing_out


  def current_user=(user)
    @current_user = user
  end # end def current_user=(user)

  def current_user
    @current_user ||= user_from_remember_token
  end # end def current_user

  def signed_in?
    !current_user.nil?
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end# end def user_from_remember_token


    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end# end def remember_token


end # end module
