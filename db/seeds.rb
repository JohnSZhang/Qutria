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

john = User.create(
  username: "john",
  password: "123456",
  email: "john@cato.io"
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

cato_a = march.answers.create(
  user: cato,
  body: "I dont know Julius, why dont you find out for yourself? "
)

julius_a = march.answers.create(
  user: julius,
  body: "Someone did warn me about something, think it mightve been Brutus, but
    I am above suspicions you know. "
)
augustus_a = march.answers.create(
  user: augustus,
  body: "Dont forget to save some providence for me after you take over uncle! "
)

republic = Tag.create(
  name: "Republic",
  description: "All the republic lovers come here"
)

army = Tag.create(
  name: "Legions",
  description: "The foundation of our republic"
)

poetry = Tag.create(
  name: "poetry",
  description: "For the Ovid lovers"
)

Taggable.create(
  taggings: march,
  tag: republic
)

Taggable.create(
  taggings: sulla,
  tag: army
)

Taggable.create(
  taggings: crassus,
  tag: poetry
)

Taggable.create(
  taggings: march,
  tag: army
)

Favorite.create(
  user: julius,
  tag: republic
)

Favorite.create(
  user: julius,
  tag: army
)

Favorite.create(
  user: cato,
  tag: republic
)


Favorite.create(
  user: cato,
  tag: army
)

Comment.create(
  commentable: march,
  user: julius,
  body: "Ah I just remembered, there was a secret underground senator only party"
)

Comment.create(
  commentable: march,
  user: julius,
  body: "See you all there!"
)

Comment.create(
  commentable: march,
  user: julius,
  body: "Be there or be square!"
)

julius_c = Comment.create(
  commentable: augustus_a,
  user: julius,
  body: "Of course! How do you like Spain? The gold mines aren't doing so well lately"
)

Comment.create(
  commentable: julius_c,
  user: augustus,
  body: "I love Spain! Ill make those barbarians learn the virtues of hard work"
)
