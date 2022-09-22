characters = [
    {
        id: 1,
        name: "Cloud Strife",
        age: 21,
        interests: "Big Swords, Being edgy",
        image: "https://finalfantasy7remake.wiki.fextralife.com/file/Final-Fantasy-7-Remake/cloud-strife-playable-character-ff7remake-wiki-guide-small.jpg",
        image_alt: "Picture of Cloud"
    },
    {
        id: 2,
        name: "Tifa Lockhart",
        age: 23,
        interests: "Cloud, Punching things, Drinking",
        image: "https://xfinalfantasy7remake.wiki.fextralife.com/file/Final-Fantasy-7-Remake/tifa-lockhart-playable-character-ff7remake-wiki-guide-small.jpg",
        image_alt: "Picture of Tifa"
    },
    {
        id: 3,
        name: "Tidus",
        age: 17,
        interests: "Blitzball, Laughing, Food",
        image: "https://i.pinimg.com/736x/1b/79/98/1b7998bc6229180ec55652373d379aaa.jpg",
        image_alt: "Picture of Tidus"
    },
    {
        id: 4,
        name: "Vivi",
        age: 9,
        interests:"Black Magic, Bombay Babes, Tacos",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsI9omnlcnzPV7Zm48qSjMv5XM2_a9UO8ZCA&usqp=CAU",
        image_alt: "Picture of Vivi"
    }
]

characters.each do |each_character|
    Character.create each_character
    p "#{each_character} has been added to the database"
end
