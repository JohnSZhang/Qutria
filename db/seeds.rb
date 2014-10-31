# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# julius = User.create(
#   username: "SerialTriumvirate",
#   password: "baldeagle",
#   email: "gual_divider@caesars.house")
#
# augustus = User.create(
#   username: "MarbleEyed",
#   password: "Octavian27",
#   email: "pax_romana@rome.com"
# )
#
# cato = User.create(
#   username: "TheUncorruptable",
#   password: "preservetherepulic",
#   email: "a_virtuous_life@cato.io"
# )
#
# john = User.create(
#   username: "john",
#   password: "123456",
#   email: "john@cato.io"
# )
#
# sulla = julius.questions.create(
#   title: "Seen Sulla lately?",
#   body: "He throws a great party! Not sure what happened to him since he retired
#     though, Pompeia really misses him."
# )
#
# crassus = julius.questions.create(
#   title: "What happened to Crassus?",
#   body: "One day he was busy running his fire trucks and blackmailing people,
#     next day hes gone away marching into the dessert thinking hes a real general.
#     Hope he's okay though!"
# )
#
# march = julius.questions.create(
#   title: "Anyone busy on the ides of March?",
#   body: "I heard there was a really cool party going on in the senate, gonna
#     go with my best purple toga."
# )
#
# cato_a = march.answers.create(
#   user: cato,
#   body: "I dont know Julius, why dont you find out for yourself? "
# )
#
# julius_a = march.answers.create(
#   user: julius,
#   body: "Someone did warn me about something, think it mightve been Brutus, but
#     I am above suspicions you know. "
# )
# augustus_a = march.answers.create(
#   user: augustus,
#   body: "Dont forget to save some providence for me after you take over uncle! "
# )
#
# republic = Tag.create(
#   name: "Republic",
#   description: "All the republic lovers come here"
# )
#
# army = Tag.create(
#   name: "Legions",
#   description: "The foundation of our republic"
# )
#
# poetry = Tag.create(
#   name: "poetry",
#   description: "For the Ovid lovers"
# )
#
# Taggable.create(
#   taggings: march,
#   tag: republic
# )
#
# Taggable.create(
#   taggings: sulla,
#   tag: army
# )
#
# Taggable.create(
#   taggings: crassus,
#   tag: poetry
# )
#
# Taggable.create(
#   taggings: march,
#   tag: army
# )
#
# Favorite.create(
#   user: julius,
#   tag: republic
# )
#
# Favorite.create(
#   user: julius,
#   tag: army
# )
#
# Favorite.create(
#   user: cato,
#   tag: republic
# )
#
#
# Favorite.create(
#   user: cato,
#   tag: army
# )
#
# Comment.create(
#   commentable: march,
#   user: julius,
#   body: "Ah I just remembered, there was a secret underground senator only party"
# )
#
# Comment.create(
#   commentable: march,
#   user: julius,
#   body: "See you all there!"
# )
#
# Comment.create(
#   commentable: march,
#   user: julius,
#   body: "Be there or be square!"
# )
#
# julius_c = Comment.create(
#   commentable: augustus_a,
#   user: julius,
#   body: "Of course! How do you like Spain? The gold mines aren't doing so well lately"
# )
#
# Comment.create(
#   commentable: julius_c,
#   user: augustus,
#   body: "I love Spain! Ill make those barbarians learn the virtues of hard work"
# )

jupiter = User.create(
  username: "jupiter",
  password: "123456",
  email: "j@jupiter.house")

juno = User.create(
  username: "juno",
  password: "123456",
  email: "j@juno.house")

neptune = User.create(
  username: "neptune",
  password: "123456",
  email: "j@neptune.house")

pluto = User.create(
  username: "pluto",
  password: "123456",
  email: "j@pluto.house")

apollo = User.create(
  username: "apollo",
  password: "123456",
  email: "j@apollo.house")

diana = User.create(
  username: "diana",
  password: "123456",
  email: "j@diana.house")

mars = User.create(
  username: "mars",
  password: "123456",
  email: "j@mars.house")

venus = User.create(
  username: "venus",
  password: "123456",
  email: "j@venus.house")

cupid = User.create(
  username: "cupid",
  password: "123456",
  email: "j@cupid.house")

mercury = User.create(
  username: "mercury",
  password: "123456",
  email: "j@mercury.house")

minerva = User.create(
  username: "minerva",
  password: "123456",
  email: "j@minerva.house")

vulcan = User.create(
  username: "venus",
  password: "123456",
  email: "j@vulcan.house")

john = User.create(
  username: "john",
  password: "123456",
  email: "j@john.house")

war = Tag.create(
  name: "war",
  description: "The gods are always fighting each other"
)

jealousy = Tag.create(
  name: "jealousy",
  description: "gods get jealous, a lot"
)

punishment = Tag.create(
  name: "punishment",
  description: "Someones a good lesson is hard learned"
)

knowledge = Tag.create(
  name: "knowledge",
  description: "They know all things"
)

weather = Tag.create(
  name: "weather",
  description: "Weahter, rain, wheat!"
)

juno_q = juno.questions.create(
  title: "any one seen jupiter?",
  body: "Did he run off as a swan again!"
)

Taggable.create(
  taggings: juno_q,
  tag: jealousy
)

Taggable.create(
  taggings: juno_q,
  tag: war
)

Taggable.create(
  taggings: juno_q,
  tag: knowledge
)
minerva_a = juno_q.answers.create(
  user: minerva,
  body: "I dont know know, think I saw him watching tv earlier "
)


neptune_q = neptune.questions.create(
  title: "Anyone saw my trident?",
  body: "Lost it again, third one this year!!"
)
Taggable.create(
  taggings: neptune_q,
  tag: jealousy
)

Taggable.create(
  taggings: neptune_q,
  tag: knowledge
)

venus_a = neptune_q.answers.create(
  user: venus,
  body: "Ariel traded it for these 'legs'"
)

jupiter_q = jupiter.questions.create(
  title: "I want a bigger alter",
  body: "Not really a question, I just want a new temple!"
)

Taggable.create(
  taggings: jupiter_q,
  tag: war
)

Taggable.create(
  taggings: jupiter_q,
  tag: weather
)

venus_q = venus.questions.create(
  title: "How can I prevent SQL-injection in PHP??",
  body: "I heard web development is pretty hot these days!"
)

Taggable.create(
  taggings: venus_q,
  tag: punishment
)

Taggable.create(
  taggings: venus_q,
  tag: war
)
Taggable.create(
  taggings: venus_q,
  tag: jealousy
)

Taggable.create(
  taggings: venus_q,
  tag: knowledge
)

apollo_q = apollo.questions.create(
  title: "How do you like Dlephi?",
  body: "Someones building a brand new temple for me there!"
)
Taggable.create(
  taggings: apollo_q,
  tag: war
)
Taggable.create(
  taggings: apollo_q,
  tag: knowledge
)
minerva_q = minerva.questions.create(
  title: "How do I build up a stealth-mage early in Skyrim?",
  body: "This game is really addicting!"
)

Taggable.create(
  taggings: minerva_q,
  tag: war
)
Taggable.create(
  taggings: minerva_q,
  tag: weather
)
