namespace :seeds do
  desc "Generate seed data"
  task :generate do
    require_relative 'seeds'
    Reset.hard

    dev = Sequel.connect('postgres://exercism:@localhost/exercism_development')
    seeds = Sequel.connect('postgres://exercism:@localhost/exercism_seeds')

    User.new('alice', mastery: Languages.all.to_yaml).save_to(seeds)

    bob = User.new('bob').save_to(seeds)
    100.times do
      iteration = Iterations.new(bob, *Exercise.random(dev))
      if seeds[:user_exercises].where(iteration.to_h).count == 0
        iteration.save_to(seeds)
      end
    end

    system("pg_dump -U exercism exercism_seeds -f db/seeds.sql")
  end
end

task default: "seeds:generate"

