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
  
  it "checks whether a name is present or not" do
    character_params ={
      character: {
        age: 22,
        interests: 'Black, dolls, curry',
        image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
        image_alt: 'Picture of Lulu'
      }
    }
  
    post '/characters', params: character_params
  
    expect(response.status).to eq 422
    
    json = JSON.parse(response.body)
    expect(json['name']).to include "can't be blank"
  end

  it "checks whether an age is present or not" do
    character_params ={
      character: {
        name: 'Lulu',
        interests: 'Black, dolls, curry',
        image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
        image_alt: 'Picture of Lulu'
      }
    }
  
    post '/characters', params: character_params
    
    json = JSON.parse(response.body)
  
    expect(response.status).to eq 422
    expect(json['age']).to include "can't be blank"
  end

  it "checks whether an interests is present or not" do
    character_params ={
      character: {
        name: 'Lulu',
        age: 22,
        image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
        image_alt: 'Picture of Lulu'
      }
    }
  
    post '/characters', params: character_params
    
    json = JSON.parse(response.body)
  
    expect(response.status).to eq 422
    expect(json['interests']).to include "can't be blank"
  end

  it "checks whether an image is present or not" do
    character_params ={
      character: {
        name: 'Lulu',
        age: 22,
        interests: 'Black, dolls, curry',
        image_alt: 'Picture of Lulu'
      }
    }
  
    post '/characters', params: character_params
    
    json = JSON.parse(response.body)
  
    expect(response.status).to eq 422
    expect(json['image']).to include "can't be blank"
  end

  it "checks whether an image_alt is present or not" do
    character_params ={
      character: {
        name: 'Lulu',
        age: 22,
        interests: 'Black, dolls, curry',
        image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
      }
    }
  
    post '/characters', params: character_params
    
    json = JSON.parse(response.body)
  
    expect(response.status).to eq 422
    expect(json['image_alt']).to include "can't be blank"
  end

  it 'checking to make sure that interests are at least 10 characters long for character' do
    character_params ={
      character: {
        name: 'Lulu',
        age: 22,
        interests: 'Black',
        image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
        image_alt: 'Picture of Lulu'
      }
    }

    post '/characters', params: character_params
  
    json = JSON.parse(response.body)

    expect(response.status).to eq 422 
    expect(json['interests']).to include "is too short (minimum is 10 characters)"
    expect(json['interests']).to_not be_empty
    
  end

  it "checks whether the udpated info is present or not" do
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
        interests: 'Water',
        name: 'Yo'
      }
    }

    patch "/characters/#{character.id}", params: character_params

    character = Character.first

    json = JSON.parse(response.body)

    expect(response.status).to eq 422
    expect(json['interests']).to include "is too short (minimum is 10 characters)"
    expect(json['interests']).to_not be_empty
    expect(json['name']).to include "is too short (minimum is 3 characters)"
  end
end
