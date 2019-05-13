# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

raise 'You cannot run seeds in production' if Rails.env.production?

# rubocop:disable Rails/Output
[Task, Project, User, FlipperFeature].each do |table|
  puts "Deleting #{table.name} records..."
  table.delete_all
end

puts 'Starting seeding...'

puts 'Creating feature flags'
Flipper.enable :feature_registration

puts 'Creating Users records...'
user = User.create!(
  email: 'dale.cooper@lessy.io',
  username: 'dalecooper',
  password: 'secret',
  admin: true,
)
user.activate!

puts 'Creating Projects records...'
Project.create!([
  { name: Faker::Company.catch_phrase, user: user },
  { name: Faker::Company.catch_phrase, user: user },
  { name: Faker::Company.catch_phrase, user: user },
  { name: Faker::Company.catch_phrase, user: user },
  { name: Faker::Company.catch_phrase, user: user },
  {
    name: Faker::Company.catch_phrase,
    user: user,
    state: 'started',
    started_at: 30.days.ago,
    due_at: 20.days.from_now,
  },
  {
    name: Faker::Company.catch_phrase,
    user: user,
    state: 'started',
    started_at: 10.days.ago,
    due_at: 42.days.from_now,
  },
])

puts 'Creating Tasks records...'
order_sequence = (1..11).to_a.shuffle
Task.create!(
  [
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'started',
      started_at: Time.current,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'started',
      started_at: Time.current,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'started',
      started_at: Time.current,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'started',
      started_at: Time.current,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'started',
      started_at: Time.current,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'started',
      started_at: Time.current,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'started',
      started_at: 1.week.ago,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'started',
      started_at: 2.weeks.ago,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'planned',
      started_at: Time.current,
      planned_at: 1.day.ago,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'planned',
      started_at: Time.current,
      planned_at: 2.days.ago,
    },
    {
      label: Faker::TvShows::TwinPeaks.quote,
      user: user,
      order: order_sequence.pop,
      state: 'planned',
      started_at: 1.week.ago,
      planned_at: 1.day.ago,
      planned_count: 3,
    },
  ],
)

puts 'Seeds are now ready! You can login with: dalecooper / secret'
# rubocop:enable Rails/Output
