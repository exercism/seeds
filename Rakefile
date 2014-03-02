namespace :seeds do
  desc "Generate seed data"
  task :generate do
    require_relative 'seeds'
    Reset.hard

    db = Sequel.connect('postgres://exercism:@localhost/exercism_seeds')

    User.create(db, 'alice', mastery: Languages.all.to_yaml)
    system("pg_dump -U exercism exercism_seeds -f db/seeds.sql")
  end
end

