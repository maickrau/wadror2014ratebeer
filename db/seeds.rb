# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

b1.beers.create name:"Iso 3", old_style:"Lager"
b1.beers.create name:"Karhu", old_style:"Lager"
b1.beers.create name:"Tuplahumala", old_style:"Lager"
b2.beers.create name:"Huvila Pale Ale", old_style:"Pale Ale"
b2.beers.create name:"X Porter", old_style:"Porter"
b3.beers.create name:"Hefezeizen", old_style:"Weizen"
b3.beers.create name:"Helles", old_style:"Lager"