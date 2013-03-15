require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
    end # end before

    it "devrait reussir" do
      get :show, :id => @user
      response.should be_success
    end # end it

    it "devrait trouver le bon utilisateur" do
      get :show, :id => @user
      assigns(:user).should == @user
    end # end it

    it "devrait avoir le bon titre" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.nom)
    end # end it

    it "devrait inclure le nom de l'utilisateur" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.nom)
    end # end it

    it "devrait avoir une image de profil" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end # end it
  end # end describe "GET 'show'"

  describe "GET 'new'" do
    it "devrait reussir" do
      get 'new'
      response.should be_success
    end # end it

    it "devrait avoir le bon titre" do
      get 'new'
      response.should have_selector("title", :content => "Inscription")
    end # end it
  end # end describe "GET 'new'"
end
