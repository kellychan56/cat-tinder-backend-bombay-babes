require 'rails_helper'

RSpec.describe Character, type: :model do
  it 'checking to make sure there is a name for character' do
    character = Character.create(
      age: 22,
      interests: 'Black, dolls, curry',
      image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
      image_alt: 'Picture of Lulu'
    )

    expect(character.errors[:name]).to_not be_empty
  end

  it 'checking to make sure there is an age for character' do
    character = Character.create(
      name: 'Lulu',
      interests: 'Black, dolls, curry',
      image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
      image_alt: 'Picture of Lulu'
    )

    expect(character.errors[:age]).to_not be_empty
  end

  it 'checking to make sure there is an interests for character' do
    character = Character.create(
      name: 'Lulu',
      age: 22,
      image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
      image_alt: 'Picture of Lulu'
    )

    expect(character.errors[:interests]).to_not be_empty
  end

  it 'checking to make sure there is an image for character' do
    character = Character.create(
      name: 'Lulu',
      age: 22,
      interests: 'Black, dolls, curry',
      image_alt: 'Picture of Lulu'
    )

    expect(character.errors[:image]).to_not be_empty
  end

  it 'checking to make sure there is an image_alt for character' do
    character = Character.create(
      name: 'Lulu',
      age: 22,
      interests: 'Black, dolls, curry',
      image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
    )

    expect(character.errors[:image_alt]).to_not be_empty
  end

  it 'checking to make sure that interests are at least 10 characters long for character' do
    character = Character.create(
      age: 22,
      interests: 'Black',
      image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
      image_alt: 'Picture of Lulu'
    )

    expect(character.errors[:interests]).to_not be_empty 
    expect(character.errors[:interests]).to include("is too short (minimum is 10 characters)")
  end

  it 'checking to make sure that name is at least 3 characters long for character' do
    character = Character.create(
      name: 'Yo',
      age: 22,
      interests: 'Black, Curry, dolls',
      image: 'https://oyster.ignimgs.com/mediawiki/apis.ign.com/final-fantasy-x/2/25/Lulu.jpg',
      image_alt: 'Picture of Lulu'
    )

    expect(character.errors[:name]).to_not be_empty 
    expect(character.errors[:name]).to include("is too short (minimum is 3 characters)")
  end
end

