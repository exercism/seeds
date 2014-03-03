namespace :seeds do
  desc "Generate seed data"
  task :generate do
    require_relative 'seeds'
    Reset.hard

    dev = Sequel.connect('postgres://exercism:@localhost/exercism_development')
    seeds = Sequel.connect('postgres://exercism:@localhost/exercism_seeds')

    alice = User.new('alice', mastery: Languages.all.to_yaml).save_to(seeds)
    ghost = Team.new('ghost', seeds).save
    ghost.managed_by alice

    bob = User.new('bob').save_to(seeds)
    100.times do
      Iterations.new(bob, *Exercise.random(dev)).save_to(seeds)
    end

    charlie = User.new('charlie', mastery: ['ruby'].to_yaml).save_to(seeds)

    diana = User.new('diana', mastery: ['javascript'].to_yaml).save_to(seeds)
    15.times do
      Iterations.new(diana, *Exercise.random(dev, 'javascript')).save_to(seeds)
    end

    eve = User.new('eve', mastery: ['python'].to_yaml).save_to(seeds)
    15.times do
      Iterations.new(eve, *Exercise.random(dev, 'haskell')).save_to(seeds)
    end

    motley = Team.new('motley', seeds).save
    motley.managed_by bob
    motley.add bob

    ['mary', 'morris', 'madison', 'mildred', 'mack', 'mike', 'mitchell', 'marshall'].each do |username|
      user = User.new(username).save_to(seeds)
      20.times do
        Iterations.new(user, *Exercise.random(dev)).save_to(seeds)
      end
      motley.add user
    end

    rugrats = Team.new('rugrats', seeds).save
    rugrats.managed_by charlie

    ['rachel', 'russ', 'rita', 'rolf', 'randall', 'river', 'rick'].each do |username|
      user = User.new(username).save_to(seeds)
      20.times do
        Iterations.new(user, *Exercise.random(dev, 'ruby')).save_to(seeds)
      end
      rugrats.add user
    end
    rudi = User.new('rudi').save_to(seeds)
    rugrats.add rudi

    ryan = User.new('ryan').save_to(seeds)
    20.times do
      Iterations.new(ryan, *Exercise.random(dev, 'ruby')).save_to(seeds)
    end
    rugrats.invite ryan

    slate = Team.new('slate', seeds).save
    slate.managed_by bob

    [
      "amelie", "beth", "claire",
      "dawson", "elisa", "frederique",
      "grace", "haley", "isaac",
      "jarrod", "kieran", "lisa",
      "mia", "norma", "opal",
      "paula", "quentin", "ruben",
      "shaina", "talia", "ursula",
      "vince", "wilson", "xavier",
      "yvette", "zachary"
    ].each do |username|
      user = User.new(username).save_to(seeds)
      20.times do
        Iterations.new(user, *Exercise.random(dev)).save_to(seeds)
      end
      slate.add user
    end

    system("pg_dump -U exercism exercism_seeds -f db/seeds.sql")
  end
end

task default: "seeds:generate"

