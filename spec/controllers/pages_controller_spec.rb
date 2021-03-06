require 'spec_helper'

describe PagesController do
  render_views



  describe "GET 'home'" do
    it "devrait reussir" do
      get 'home'
      response.should be_success
    end # end it

    it "devrait avoir le bon titre" do
      get 'home'
      response.should have_selector("title",
                        :content => "Simple App du Tutoriel Ruby on Rails | Accueil")
    end # end it
  end # end describe "GET 'home'"



  describe "GET 'contact'" do
    it "devrait reussir" do
      get 'contact'
      response.should be_success
    end # end it

    it "devrait avoir le bon titre" do
      get 'contact'
      response.should have_selector("title",
                        :content =>
                          "Simple App du Tutoriel Ruby on Rails | Contact")
    end # end it
  end # end describe "GET 'contact'"



  describe "GET 'about'" do
    it "devrait reussir" do
      get 'about'
      response.should be_success
    end # end it

    it "devrait avoir le bon titre" do
      get 'about'
      response.should have_selector("title",
                        :content =>
                          "Simple App du Tutoriel Ruby on Rails | A Propos")
    end # end it
  end # end describe "GET 'about'"


end
