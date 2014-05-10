require "spec_helper"
require "tag"

describe Link do
  context "Demostration of how Datamapper works" do
	it "should be created then retrieved from the db" do
		expect(Link.count).to eq 0
		Link.create(:title => "Makers Academy",
					:url => "http://www.makersacademy.com/")
		expect(Link.count).to eq 1
		link = Link.first
		expect(link.url).to eq "http://www.makersacademy.com/"
		expect(link.title).to eq "Makers Academy"
		link.destroy
		# expect(Link.count).to eq 0
	end 

	it "should be able to add tags" do
		expect(Link.count).to eq 0
		tags = "codeschool learning_course".split(" ").map do |tag_string|
			Tag.first_or_create(:tagname => tag_string)

		end

		Link.create(:title => "Makers Academy",
					:url => "http://www.makersacademy.com/",
					:tags => tags)
		expect(Link.count).to eq 1
		link = Link.first
		expect(link.url).to eq "http://www.makersacademy.com/"
		expect(link.title).to eq "Makers Academy"
		expect(link.tags.map(&:tagname)).to include("codeschool")
    	expect(link.tags.map(&:tagname)).to include("learning_course")

	end 	
  end
end