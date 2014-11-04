# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'rubygems'
require 'ruby-stackoverflow'
require_relative 'seed_helper'
include SeedHelper

tags_array = ['ruby', 'backbone',
      'rails', 'javascript',
      'css', 'html5', 'node.js', 'python' ]

questions = SeedHelper::get_questions('ruby') #An Array Of Questions

questions.each do |question|
  rails_q = SeedHelper::create_question(question)
  SeedHelper::create_comments(question, rails_q) 

  if question.answers.count > 0
    answers = SeedHelper::parse_answers(question)
    answers.each do |answer|
      rails_a = SeedHelper::create_answer(answer, rails_q)
      SeedHelper::create_comments(answer, rails_a)
    end
  end
end
