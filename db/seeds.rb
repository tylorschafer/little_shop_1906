Item.destroy_all
Review.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
tire_review_1 = tire.reviews.create(title: "What a great piece of gear!", content: "Wow, I couldn't be more satisfied with this product. I would reccomend it to everyone!", rating: 5.0)
tire_review_2 = tire.reviews.create(title: "Left me wanting more..", content: "This product broke on me after a week, would not reccomend.", rating: 1.5)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
pull_toy_review_1 = pull_toy.reviews.create(title: "Gets the job done", content: "My pooch loves this product, has lasted for weeks already!", rating: 4.2)
pull_toy_review_2 = pull_toy.reviews.create(title: "Good Buy!", content: "This is a great toy, very durable and good quality", rating: 4.5)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
bone_review_1 = dog_bone.reviews.create(title: "Would not reccomend", content: "This thing smelled like rotten garbage when I recieved it, gross.", rating: 1.0)
bone_review_2 = dog_bone.reviews.create(title: "Bad Quality", content: "It came to me in little pieces and had a funky smell to it.", rating: 1.5)
