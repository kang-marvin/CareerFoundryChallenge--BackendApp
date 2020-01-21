FactoryBot.define do

  # User factory

  factory :user do
    first_name  { Faker::University.unique.name }
    last_name   { Faker::University.unique.name }
    email       { Faker::Internet.unique.email }
    time_zone   { '-03:00' }
  end

  # Student factory

  factory :student do
    first_name  { Faker::University.unique.name }
    last_name   { Faker::University.unique.name }
    email       { Faker::Internet.unique.email }
    time_zone   { '-03:00' }

    before(:create, :build) do
    end

    after(:create, :build) do
    end
  end

  # Mentor factory
  factory :mentor do
    first_name  { Faker::University.unique.name }
    last_name   { Faker::University.unique.name }
    email       { Faker::Internet.unique.email }
    time_zone   { '-03:00' }

    before(:create, :build) do
    end

    after(:create, :build) do
    end

  end
end

