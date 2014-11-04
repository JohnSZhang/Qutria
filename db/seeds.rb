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

questions = SeedHelper::get_questions('ruby') #An Array Of Questions

questions.each do |question|
  SeedHelper::save_question(question)
end



answers = SeedHelper::get_answers(questions)
user = SeedHelper::get_users(answers)
