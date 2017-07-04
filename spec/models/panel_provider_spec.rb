require 'rails_helper'

RSpec.describe PanelProvider, type: :model do
  let(:letters_panel_provider) { FactoryGirl.create :letters_panel_provider}
  let(:arrays_panel_provider) { FactoryGirl.create :arrays_panel_provider}
  let(:nodes_panel_provider) { FactoryGirl.create :nodes_panel_provider}
  describe "price" do
    it "should do price for letters" do
      stub_request(:get, "http://time.com").to_return(body: "<html><body><p>paragraph 1</p><p>Paragraph 2</p></body></html>", status: 200)
      expect(letters_panel_provider.price).to eq(0.06)
    end

    it "should do price for arrays" do
      result = {
        title: "title",
        docs: [
          short_string_list: [
            "string1",
            "string2",
            "string3",
          ],
          short_hash_list: [
            {id: 1},
            {id: 2},
            {id: 3},
          ],
          long_string_list: [
            "string1",
            "string2",
            "string3",
            "string4",
            "string5",
            "string6",
            "string7",
            "string8",
            "string9",
            "string10",
            "string11",
            "string12",
          ],
          short_hash_list: [
            {id: 1},
            {id: 2},
            {id: 3},
            {id: 4},
            {id: 5},
            {id: 6},
            {id: 7},
            {id: 8},
            {id: 9},
            {id: 10},
            {id: 11},
          ]
        ]
      }
      stub_request(:get, "http://openlibrary.org/search.json?q=the+lord+of+the+rings").to_return(body: result.to_json, status: 200)
      expect(arrays_panel_provider.price).to eq(2)

    end

    it "should do price for nodes" do
      stub_request(:get, "http://time.com").to_return(body: "<html><body><p>paragraph 1</p><p>Paragraph 2</p></body></html>", status: 200)
      expect(nodes_panel_provider.price).to eq(0.04)
    end
  end
end
