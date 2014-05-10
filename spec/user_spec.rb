require "spec_helper"
require "user"

describe User do
  context "add user to the db" do
    it "should be created with an email and password" do
      user = User.create(:email => "alex@me.com",  :password => "password", :password_confirmation => "password")
      puts user.inspect
      expect(User.count).to eq 1
      expect(user.email).to eq "alex@me.com"
    end

    it "should not create a user if passwords do not match" do
    	expect(User.count).to eq 0
    	user = User.create(:email => "alex@me.com",  :password => "password", :password_confirmation => "password2")
    	expect(User.count).to eq 0
    end

  end

end