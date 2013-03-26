require 'spec_helper'

describe "LayoutLinks" do

  it "devrait trouver une page Accueil a '/'" do
    get '/'
    response.should have_selector('title', :content => "Accueil")
  end # end it

  it "devrait trouver une page Contact a '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end # end it

  it "devrait trouver une page A Propos a '/about'" do
    get '/about'
    response.should have_selector('title', :content => "A Propos")
  end # end it

  it "devrait trouver une page Aide a '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Aide")
  end # end it

  it "devrait avoir une page d'inscription a '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Inscription")
  end # end it



  describe "quand pas identifie" do
    it "doit avoir un lien de connexion" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "S'identifier")
    end # end it
  end # end describe "quand pas identifie"



  describe "quand identifie" do
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email, :with => @user.email
      fill_in "Mot de passe", :with => @user.password
      click_button
    end # end describe "quand identifie" 

    it "devrait avoir un lien de deconnexion" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Deconnexion")
    end # end it

    it "devrait avoir un lien vers le profil" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profil")
    end # end it
  end # end describe "LayoutLinks"


end # end describe "LayoutLinks"
