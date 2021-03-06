require "spec_helper"
require "user"

describe User do
  context "add user to the db" do
    it "should be created with an email and password" do
      user = User.create(:username => "Alex", :email => "alex@me.com",  :password => "password", :password_confirmation => "password")
      expect(User.count).to eq 1
      expect(user.email).to eq "alex@me.com"
    end

    it "should not create a user if passwords do not match" do
    	expect(User.count).to eq 0
    	user = User.create(:username => "Alex", :email => "alex@me.com",  :password => "password", :password_confirmation => "password2")
    	expect(User.count).to eq 0
    end

  end
  
  context "retrieve user password from db" do 
    it "should return something when an email is provided" do 
      User.create(:username => "Alex", :email=> "t@t.com", :password => "t", :password_confirmation => "t")
      user = User.recover_password("t@t.com")
      expect(user).not_to be_nil

    end
  end

end