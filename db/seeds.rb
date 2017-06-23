# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: 'dale.cooper@zéro.org', username: 'dalecooper', password: 'secret')
user.activate!

Project.create!([
  { name: Faker::Company.catch_phrase.gsub(/\s/, '-'), user: user },
  { name: Faker::Company.catch_phrase.gsub(/\s/, '-'), user: user },
  { name: Faker::Company.catch_phrase.gsub(/\s/, '-'), user: user },
  { name: Faker::Company.catch_phrase.gsub(/\s/, '-'), user: user },
  { name: Faker::Company.catch_phrase.gsub(/\s/, '-'), user: user },
  { name: Faker::Company.catch_phrase.gsub(/\s/, '-'), user: user, started_at: 30.days.ago, due_at: 20.days.from_now },
  { name: Faker::Company.catch_phrase.gsub(/\s/, '-'), user: user, started_at: 10.days.ago, due_at: 42.days.from_now },
])

order_sequence = (0..10).to_a.shuffle
Task.create!([
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop, created_at: 1.week.ago },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop, created_at: 2.weeks.ago },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop, due_at: 1.day.ago },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop, due_at: 2.days.ago },
  { label: Faker::TwinPeaks.quote, user: user, order: order_sequence.pop, created_at: 1.week.ago, due_at: 1.day.ago, restarted_count: 2 },
])
