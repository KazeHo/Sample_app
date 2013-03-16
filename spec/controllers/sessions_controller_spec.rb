require 'spec_helper'

describe SessionsController do
  render_views



  describe "GET 'new'" do
    it "devrait reussir" do
      get :new
      response.should be_success
    end # end it

    it "devrait avoir le bon titre" do
      get :new
      response.should have_selector("title", :content => "S'identifier")
    end# end it
  end # end describe "GET 'new'"




  describe "POST 'create'" do
    describe "invalid signin" do
      before(:each) do
        @attr = { :email => "email@example.com", :password => "invalid" }
      end # end before

      it "devrait re-rendre la page new" do
        post :create, :session => @attr
        response.should render_template('new')
      end # end it

      it "devrait avoir le bon titre" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "S'identifier")
      end # end it

      it "devait avoir un message flash.now" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end # end it
    end # end describe "invalid signin"


    describe "avec un email et un mot de passe valides" do
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end # end before

      it "devrait identifier l'utilisateur" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end # end it

      it "devrait rediriger vers la page d'affichage de l'utilisateur" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end # end it
    end # end describe "avec un email et un mot de passe valides"

  end # end describe "POST 'create'"



  describe "DELETE 'destroy'" do
    it "devrait deconnecter un utilisateur" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end # end it
  end # end describe "DELETE 'destroy'"


end
