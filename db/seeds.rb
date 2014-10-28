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

sulla = julius.questions.create(
  title: "Seen Sulla lately?",
  body: "He throws a great party! Not sure what happened to him since he retired
    though, Pompeia really misses him."
)

crassus = julius.questions.create(
  title: "What happened to Crassus?",
  body: "One day he was busy running his fire trucks and blackmailing people,
    next day hes gone away marching into the dessert thinking hes a real general.
    Hope he's okay though!"
)

march = julius.questions.create(
  title: "Anyone busy on the ides of March?",
  body: "I heard there was a really cool party going on in the senate, gonna
    go with my best purple toga."
)

march.answers.create(
  user: cato,
  body: "I dont know Julius, why dont you find out for yourself? " 
)
march.answers.create(
  user: julius,
  body: "Someone did warn me about something, think it mightve been Brutus, but
    I am above suspicions you know. "
)
march.answers.create(
  user: augustus,
  body: "Dont forget to save some providence for me after you take over uncle! "
)
