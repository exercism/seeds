namespace :seeds do
  desc "Generate seed data"
  task :generate do
    require_relative 'seeds'
    Reset.hard

    dev = Sequel.connect('postgres://exercism:@localhost/exercism_development')
    seeds = Sequel.connect('postgres://exercism:@localhost/exercism_seeds')

    User.new('alice', mastery: Languages.all.to_yaml).save_to(seeds)

    bob = User.new('bob').save_to(seeds)
    Iterations.new(bob, *Exercise.random(dev)).save_to(seeds)

    system("pg_dump -U exercism exercism_seeds -f db/seeds.sql")
  end
end

task default: "seeds:generate"

