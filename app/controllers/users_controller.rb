class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @titre = @user.nom
  end # end def show

  def new
    @user = User.new
    @titre = "Inscription"
  end # end def new

 def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue dans l'Application Exemple !"
      redirect_to @user
    else
      @titre = "Inscription"
      render 'new'
    end # end if else
  end # end def create
end
