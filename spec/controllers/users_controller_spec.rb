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





  describe "POST 'create'" do
    describe "succes" do
      before(:each) do
        @attr = { :nom => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end # end before

      it "devrait creer un utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end # end it

      it "devrait identifier l'utilisateur" do
        post :create, :user => @attr
        controller.should be_signed_in
      end # end it

      it "devrait rediriger vers la page d'affichage de l'utilisateur" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end  # end it   

     it "devrait avoir un message de bienvenue" do
        post :create, :user => @attr
        flash[:success].should =~ /Bienvenue dans l'Application Exemple/i
      end  # end it
    end # end describe "succès"

    describe "echec" do
      before(:each) do
        @attr = { :nom => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end # end before

      it "ne devrait pas creer d'utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end # end it

      it "devrait avoir le bon titre" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Inscription")
      end # end it

      it "devrait rendre la page 'new'" do
        post :create, :user => @attr
        response.should render_template('new')
      end # end it
    end # end describe "echec
  end # end describe "POST 'create'"





  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end # end before

    it "devrait reussir" do
      get :edit, :id => @user
      response.should be_success
    end # end it

    it "devrait avoir le bon titre" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edition profil")
    end # end it

    it "devrait avoir un lien pour changer l'image Gravatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_selector("a", :href => gravatar_url,
                                         :content => "changer")
    end # end it
  end # end describe "GET 'edit'"






  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end # end before

    describe "echec" do

      before(:each) do
        @attr = { :email => "", :nom => "", :password => "",
                  :password_confirmation => "" }
      end # end before

      it "devrait retourner la page d'Edition" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end # end it

      it "devrait avoir le bon titre" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edition profil")
      end # end it
    end # end describe "echec"

    describe "succes" do

      before(:each) do
        @attr = { :nom => "New Name", :email => "user@example.org",
                  :password => "barbaz", :password_confirmation => "barbaz" }
      end # end before

      it "devrait modifier les caracteristiques de l'utilisateur" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.nom.should  == @attr[:nom]
        @user.email.should == @attr[:email]
      end # end it

      it "devrait rediriger vers la page d'affichage de l'utilisateur" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end # end it

      it "devrait afficher un message flash" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /actualise/
      end # end it
    end # end describe "succes"
  end # end describe "PUT 'update'"



  describe "authentification des pages edit/update" do

    before(:each) do
      @user = Factory(:user)
    end # end before

    describe "pour un utilisateur non identifie" do

      it "devrait refuser l'accces a l'action 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end # end it

      it "devrait refuser l'acces a l'action 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end # end it
    end # end describe "pour un utilisateur non identifie"


    describe "pour un utilisateur identifie" do

      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end # end before

      it "devrait correspondre a l'utilisateur a editer" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end # end it

      it "devrait correspondre a l'utilisateur a actualiser" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end # end it
    end # end describe "pour un utilisateur identifie"

  end # end describe "authentification des pages edit/update"


end


