require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :nom => "Example User", :email => "user@example.com", :password =>"foobar", :password_confirmation =>"foobar" }
  end # end before

  it "devrait creer une nouvelle instance dotee des attributs valides" do
    User.create!(@attr)
  end # end it

  it "exige un nom" do
    bad_guy = User.new(@attr.merge(:nom => ""))
    bad_guy.should_not be_valid
  end # end it

  it "exige une adresse email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end # end it

  it "devrait accepter une adresse email valide" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end # end "adresses.each do"
  end # end if

  it "devrait rejeter une adresse email invalide" do
    adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end # end "adresses.each do"
  end # end it

  it "devrait rejeter un email double" do
    # Place un utilisateur avec un email donné dans la BD.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end # end it

  it "devrait rejeter une adresse email invalide jusqu'a la casse" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end # end it


  describe "password validations" do
    it "devrait exiger un mot de passe" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end # end it

    it "devrait exiger une confirmation du mot de passe qui correspond" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end # end it

    it "devrait rejeter les mots de passe (trop) courts" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end # end it

    it "devrait rejeter les (trop) longs mots de passe" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end # end if
  end # end describe "password validations"




  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end # end before

    it "devrait avoir un attribut  mot de passe crypte" do
      @user.should respond_to(:encrypted_password)
    end # end it


    describe "Methode has_password?" do
      it "doit retourner true si les mots de passe coincident" do
        @user.has_password?(@attr[:password]).should be_true
      end # end it  

      it "doit retourner false si les mots de passe divergent" do
        @user.has_password?("invalide").should be_false
      end # end it
    end # end describe "Methode has_password"


    describe "authenticate method" do
      it "devrait retourner nul en cas d'inequation entre email/mot de passe" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end # end it

      it "devrait retourner nil quand un email ne correspond a aucun utilisateur" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end # end it

      it "devrait retourner l'utilisateur si email/mot de passe correspondent" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end # end it
    end # end describe "authenticate method"
  end # end describe "password encryption"


  describe "Attribut admin" do

    before(:each) do
      @user = User.create!(@attr)
    end # end before

    it "devrait confirmer l'existence de `admin`" do
      @user.should respond_to(:admin)
    end # end it

    it "ne devrait pas etre un administrateur par defaut" do
      @user.should_not be_admin
    end # end it

    it "devrait pouvoir devenir un administrateur" do
      @user.toggle!(:admin)
      @user.should be_admin
    end # end it
  end # end describe "password encryption"


end # end describe "User"
