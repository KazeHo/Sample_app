class SessionsController < ApplicationController

  def new
    @titre = "S'identifier"
  end # end def new


  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Combinaison eMail/Mot de Passe invalide."
      @titre = "S'identifier"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end # end if else
  end # end def create


  def destroy
    sign_out
    redirect_to root_path
  end # end def destroy
end
