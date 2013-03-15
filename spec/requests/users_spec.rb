require 'spec_helper'

describe "Users" do
  describe "Une inscription" do
    describe "ratee" do
      it "ne devrait pas creer un nouvel utilisateur" do
        lambda do
          visit signup_path
          fill_in "nom", :with => ""
          fill_in "email", :with => ""
          fill_in "password", :with => ""
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
          fill_in "nom", :with => "Example User"
          fill_in "email", :with => "user@example.com"
          fill_in "password", :with => "foobar"
          fill_in "confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Bienvenue")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end # end it
    end # end describe "reussie"

  end # end describe "Une inscription"
end # end describe "Users"
