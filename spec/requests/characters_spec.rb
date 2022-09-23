require 'rails_helper'

RSpec.describe "Characters", type: :request do


  describe "GET /index" do
    it "get a list of all the characters" do
      Character.create(
        name: 'Lulu',
        age: 22,
        interests: 'Black, dolls, curry',
        image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
        image_alt: 'Picture of Lulu'
      )

      get '/characters'

      characters = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(characters.length).to eq(1)
    end
  end

  describe "POST /create" do
    it "creates a new character" do
      character_params = {
        character: {
          name: 'Lulu',
          age: 22,
          interests: 'Black, dolls, curry',
          image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
          image_alt: 'Picture of Lulu'
        }
      }

      post '/characters', params: character_params

      character = Character.first

      expect(response).to have_http_status(200)
      expect(character.name).to eq('Lulu')
      expect(character.image_alt).to_not be_empty
    end
  end

  describe "PATCH /update" do
    it "updates an exisiting character" do
      Character.create(
        name: 'Lulu',
        age: 22,
        interests: 'Black, dolls, curry',
        image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
        image_alt: 'Picture of Lulu'
      )

      character = Character.first

      character_params = {
        character: {
          age: 21,
          image_alt: "Lulu pic"
        }
      }

      patch "/characters/#{character.id}", params: character_params

      character = Character.first

      expect(character.age).to eq(21)
      expect(character.image_alt).to_not eq("Picture of Lulu")
      expect(character.image_alt).to eq("Lulu pic")
    end
  end

  describe "DELETE /destory" do
    it "deletes an exisiting character" do
      Character.create(
        name: 'Lulu',
        age: 22,
        interests: 'Black, dolls, curry',
        image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
        image_alt: 'Picture of Lulu'
      )

      character = Character.first

      delete "/characters/#{character.id}"

      expect(response.status).to eq(204)

      characters = Character.all
      expect(characters).to be_empty
    end
  end
end
