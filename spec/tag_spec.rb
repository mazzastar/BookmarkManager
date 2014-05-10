require "spec_helper"
require 'tag'

describe Tag do

	  it "should have a tagname when created" do
	  	# tag = Tag.create(:codeschool)
	  	# expect(tag.name).to eq :codeschool 
	 
			expect(Tag.count).to eq 0
			Tag.create(:tagname => "codeschool")
			expect(Tag.count).to eq 1
			tag = Tag.first
			expect(tag.tagname).to eq "codeschool"
			tag.destroy
			expect(Tag.count).to eq 0
  	end
	
end
