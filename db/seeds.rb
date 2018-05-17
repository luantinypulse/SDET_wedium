# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Author seed data
User.create(name: 'Luan Ta')
User.create(name: 'Ngoc Nguyen')
User.create(name: 'Tuan Tran')

# Articel Seed data
#  -- WHY THERE'S ERROR TYPE MISSMATCH when NO NULL: FALSE in Article ??? 
Article.create(title: 'Seed Data 1', slug: 'seeded-date', body: 'Seeding data', description: 'Seeding data description', author_id: User.first.id)
Article.create(title: 'Seed Data 2', slug: 'seeded-date', body: 'Seeding data', description: 'Seeding data description', author_id: User.second.id)
Article.create(title: 'Seed Data 3', slug: 'seeded-date', body: 'Seeding data', description: 'Seeding data description', author_id: User.third.id)

