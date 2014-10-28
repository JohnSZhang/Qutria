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

julius.questions.create(
  title: "Seen Sulla lately?",
  body: "He throws a great party! Not sure what happened to him since he retired
    though, Pompeia really misses him."
)

julius.questions.create(
  title: "What happened to Crassus?",
  body: "One day he was busy running his fire trucks and blackmailing people,
    next day hes gone away marching into the dessert thinking hes a real general."
)

julius.questions.create(
  title: "Anyone busy on the ides of March?",
  body: "I heard there was a really cool party going on in the senate, gonna
    go with my best purple toga."
)
