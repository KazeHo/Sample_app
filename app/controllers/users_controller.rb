require 'will_paginate'
require 'will_paginate/active_record'

class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]


def index
    @titre = "Liste des utilisateurs"
    @users = User.all
  end


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



  def edit
    @titre = "Edition profil"
  end # end def edit



  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil actualise."
      redirect_to @user
    else
      @titre = "Edition profil"
      render 'edit'
    end # end if else
  end # end def update


  private

    def authenticate
      deny_access unless signed_in?
    end # end def authenticate

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end # end def correct_user

end
