# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
julius = User.create(
  username: "SerialTriumvirate",
  password: "baldeagle",
  email: "gual_divider@caesars.house")

augustus = User.create(
  username: "MarbleEyed",
  password: "Octavian27",
  email: "pax_romana@rome.com"
)

cato = User.create(
  username: "TheUncorruptable",
  password: "preservetherepulic",
  email: "a_virtuous_life@cato.io"
)
