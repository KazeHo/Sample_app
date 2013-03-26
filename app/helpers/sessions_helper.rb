module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end # end def sing_in(user)

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end # end def sing_out

  def signed_in?
    !current_user.nil?
  end # end def current_user



  def current_user=(user)
    @current_user = user
  end # end def current_user=(user)

  def current_user
    @current_user ||= user_from_remember_token
  end # end def current_user

  def current_user?(user)
    user == current_user
  end # end def current_user?(user)



  def deny_access
    store_location
    redirect_to signin_path, :notice => "Connectez-vous pour acceder a cette page !"
  end # end def deny_access



  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end # end def redirect_back_or(default)



  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end # end def user_from_remember_token


    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end # end def remember_token


    def store_location
      session[:return_to] = request.fullpath
    end # end def store_location


    def clear_return_to
      session[:return_to] = nil
    end # end def clear_return_to


end # end module