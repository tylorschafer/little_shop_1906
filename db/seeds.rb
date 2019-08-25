Review.destroy_all
Item.destroy_all
Merchant.destroy_all

#merchants
tylor = Merchant.create(name: "Tylor's Sound Shop", address: '123 Boomy Blvd.', city: 'Denver', state: 'CO', zip: 80203)
santiago = Merchant.create(name: "Santiago's Wavelength Warehouse", address: '325 Sound St.', city: 'Denver', state: 'CO', zip: 80210)

#Music Shop
speaker_1 = tylor.items.create(name: "PreSonus Eris E8", description: "This 8 inch Powered Studio Monitor shouldn't blow up.", price: 199, image: "https://media.sweetwater.com/api/i/f-webp__q-82__ha-f51538433c1912b3__hmac-85582178b99b4942fae12e47ed5c485a14a941ff/images/items/750/ErisE8-large.jpg.auto.webp", inventory: 50)
speaker_1.reviews.create(title: "It broke my house!", content: "This thing caused a blackout in my house the second I turned it on.", rating: 1.0)
speaker_1.reviews.create(title: "Dangerous!", content: "As soon as a plugged it in my wall erupted in flames! Decent quality for the price.", rating: 3.0)
speaker_2 = tylor.items.create(name: "Yamaha HS8", description: "The Yamaha HS8 active studio monitor will help you make better-sounding recordings.", price: 349, image: "https://media.sweetwater.com/api/i/f-webp__q-82__ha-85dcc8c0d9765e1f__hmac-14c633de242c7078a8c63abdba83b7135147ca5e/images/items/750/HS8W-large.jpg.auto.webp", inventory: 20)
speaker_2.reviews.create(title: "What a great piece of gear!", content: "Wow, I couldn't be more satisfied with this product. I would reccomend it to everyone!", rating: 5.0)
speaker_2.reviews.create(title: "Left me wanting more..", content: "Not enough bang for the buck.", rating: 3.5)
speaker_3 = tylor.items.create(name: "JBL 305P MkII", description: "JBL 305P MkII active studio monitors are a great nearfield solution for any serious audio engineer or music producer.", price: 129, image: "https://media.sweetwater.com/api/i/f-webp__q-82__ha-14e0dcd08b68b78c__hmac-c8e020fd738af4fb1c210b021a29cec2b6a7c84d/images/items/750/LSR305MK2-large.jpg.auto.webp", inventory: 20)
speaker_3.reviews.create(title: "Wonderful Purchase!", content: "I can't believe how good this thing sounds.", rating: 5.0)
speaker_3.reviews.create(title: "Does a great job.", content: "Some serious quality for it's price.", rating: 4.0)

#Sound Shop
synth_1 = santiago.items.create(name: "Behringer Odyssey", description: "Behringer's über-affordable homage to the legendary 1970s ARP Odyssey gives you all the classic features", price: 499, image: "https://media.sweetwater.com/api/i/f-webp__q-82__ha-06356fad1950f9c7__hmac-1cd10dad6610f97864a218a960afbe7fcb04913d/images/items/750/Brodyssey-large.jpg.auto.webp", inventory: 5)
synth_1.reviews.create(title: "Don't buy things made by Behringer", content: "I could make cooler sounds with a hamburger", rating: 1.0)
synth_1.reviews.create(title: "I like it!", content: "This is the coolest looking paperweight I've ever had!", rating: 4.5)
synth_2 = santiago.items.create(name: "Teenage Engineering OP-1", description: "Teenage Engineering's OP-1 synthesizer gives you a complete sampling and synthesis workstation you can take anywhere.", price: 1299, image: "https://media.sweetwater.com/api/i/f-webp__q-82__ha-29f5ca19e7280bfd__hmac-3cefbda207abfca8a3584af46b6cacec4d6c3d23/images/items/750/OP1-large.jpg.auto.webp", active?:false, inventory: 0)
synth_2.reviews.create(title: "Would not reccomend", content: "This thing smelled like rotten garbage when I recieved it, gross.", rating: 1.0)
synth_3 = santiago.items.create(name: "Moog One 16-voice Analog Synthesizer", description: "As the first polyphonic Moog synthesizer in more than three decades, Moog One spearheads a new era of analog synthesis.", price: 7999, image: "https://media.sweetwater.com/api/i/f-webp__q-82__ha-cb5d11da2f9d3bea__hmac-a97d8169fe85b398ef9a6208996e1a3d3b2471bb/images/items/750/MoogOne16-large.jpg.auto.webp", inventory: 2)
synth_3.reviews.create(title: "Would not reccomend", content: "This thing smelled like rotten garbage when I recieved it, gross.", rating: 1.0)
synth_3.reviews.create(title: "Bad Quality", content: "It came to me in little pieces and had a funky smell to it.", rating: 1.5)
