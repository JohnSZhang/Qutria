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
client = RubyStackoverflow::Client.new
tags_array = ['ruby', 'backbone',
      'rails', 'javascript',
      'css', 'html5', 'node.js', 'python' ]

tags_array.each do |tag|
  puts tag
  questions = SeedHelper::get_questions(tag, 'votes') #An Array Of Questions

  questions.each do |question|
    next if SeedHelper::question_exit?(question.title)
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
end

tags_array.each do |tag|
  puts tag
  questions = SeedHelper::get_questions(tag, 'hot') #An Array Of Questions

  questions.each do |question|
    next if SeedHelper::question_exit?(question.title)
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
end

Tag.find_in_batches(batch_size: 15) do |tags|
  tag_names = tags.map(&:name)
  response = client.tags_wiki_by_names(tag_names).data
  SeedHelper::update_tags(response) unless response.nil?
end
