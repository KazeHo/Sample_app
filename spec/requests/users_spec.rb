require 'spec_helper'

describe "Users" do

  describe "Une inscription" do

    describe "ratee" do
      it "ne devrait pas creer un nouvel utilisateur" do
        lambda do
          visit signup_path
          fill_in "Nom", :with => ""
          fill_in "eMail", :with => ""
          fill_in "Mot de passe", :with => ""
          fill_in "confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end # end it
    end # end describe "ratee"


    describe "reussie" do
      it "devrait creer un nouvel utilisateur" do
        lambda do
          visit signup_path
          fill_in "Nom", :with => "Example User"
          fill_in "eMail", :with => "user@example.com"
          fill_in "Mot de passe", :with => "foobar"
          fill_in "confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Bienvenue")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end # end it
    end # end describe "reussie"

  end # end describe "Une inscription"


  describe "identification/deconnexion" do

    describe "le succes" do
      it "devrait identifier un utilisateur puis le deconnecter" do
        user = Factory(:user)
        visit signin_path
        fill_in :email, :with => user.email
        fill_in "Mot de passe", :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Deconnexion"
        controller.should_not be_signed_in
      end # end it
    end # end describe "le succès"

  end # end describe "identification/deconnexion"


end # end describe "Users"
