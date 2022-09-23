class Character < ApplicationRecord
    validates :name, :age, :interests, :image, :image_alt, presence: true
    validates :interests, length: { minimum: 10}
    validates :name, length: { minimum: 3 }
end
