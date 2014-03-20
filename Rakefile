namespace :generate do
  desc "generate markov chains"
  task :markov do
    Dir.glob("./nitpicks/*dat").each do |infile|
      language = infile[/([^\/]+)\.dat/, 1]
      outfile = "./markov/#{language}.json"
      system("bin/markov b -f #{infile} -o #{outfile}")
    end
  end
end

namespace :extract do
  desc "Extract nitpicks into a file"
  task :nitpicks do
    require 'sequel'
    require 'pg'
    require 'faker'
    I18n.enforce_available_locales = false

    db = Sequel.connect('postgres://exercism:@localhost/exercism_development')

    usernames = db["SELECT DISTINCT language FROM user_exercises"].map {|row| row[:language]}

    languages = db["SELECT DISTINCT language FROM user_exercises"].map {|row| row[:language]}

    languages.each do |language|
      comments = db["SELECT comments.body FROM comments INNER JOIN submissions ON submissions.id=comments.submission_id WHERE submissions.language = '#{language}'"].map {|row| row[:body]}
      File.open("nitpicks/#{language}.dat", 'w') do |file|
        comments.each do |comment|
          ivar = /@\w+/
          fake_ivar = "@#{Faker::Name.first_name.downcase}"
          code_block = /```.*?```\n/m
          text = comment.gsub(ivar, fake_ivar).gsub(code_block, '')
          file.puts text
        end
      end
    end
  end
end

namespace :seeds do
  desc "Generate seed data"
  task :generate do
    require './lib/seeds'
    Reset.hard

    alice = User.create('alice', mastery: Languages.all.to_yaml)
    charlie = User.create('charlie', mastery: ['ruby'].to_yaml)
    diana = User.create('diana', mastery: ['javascript'].to_yaml)
    eve = User.create('eve', mastery: ['python'].to_yaml)

    [
      'amelie', 'beth', 'bob', 'claire', 'dawson', 'elisa', 'frederique', 'grace',
      'haley', 'isaac', 'jarrod', 'kieran', 'lisa', 'mack', 'madison', 'marshall',
      'mary', 'mia', 'mike', 'mildred', 'mitchell', 'morris', 'norma', 'opal',
      'paula', 'quentin', 'rachel', 'randall', 'rick', 'rita', 'river', 'rolf',
      'ruben', 'rudi', 'russ', 'ryan', 'shaina', 'talia', 'ursula', 'vince',
      'wilson', 'xavier', 'yvette', 'zachary'
    ].each do |username|
      User.create username
    end

    Iterations.create(100, 'bob')
    Iterations.create(15, 'diana', 'javascript')
    Iterations.create(15, 'eve', 'haskell')
    [
      'mary', 'morris', 'madison', 'mildred', 'mack', 'mike', 'mitchell', 'marshall',
      'amelie', 'beth', 'claire', 'dawson', 'elisa', 'frederique', 'grace', 'haley',
      'isaac', 'jarrod', 'kieran', 'lisa', 'mia', 'norma', 'opal', 'paula', 'quentin',
      'ruben', 'shaina', 'talia', 'ursula', 'vince', 'wilson', 'xavier', 'yvette',
      'zachary'
    ].each do |username|
      Iterations.create(20, username)
    end
    ['rachel', 'russ', 'rita', 'rolf', 'randall', 'river', 'rick', 'ryan'].each do |username|
      Iterations.create(20, username, 'ruby')
    end

    baconesia = Team.new('baconesia').save
    baconesia.managed_by 'alice', 'bob', 'charlie'
    baconesia.add 'mary', 'isaac', 'lisa', 'mia', 'elisa', 'claire', 'beth', 'paula', 'quentin', 'river'
    baconesia.invite 'jarrod', 'kieran', 'opal', 'rachel', 'ruben', 'shaina', 'talia', 'xavier'

    chocolades = Team.new('chocolades').save
    chocolades.managed_by 'alice'
    chocolades.add 'bob', 'river', 'quentin', 'xavier'
    chocolades.invite 'mack', 'ruben'

    ghost = Team.new('ghost').save
    ghost.managed_by 'alice'
    ghost.invite 'ruben', 'bob'

    motley = Team.new('motley').save
    motley.managed_by 'alice', 'bob'
    motley.add 'bob', 'rachel', 'mary', 'morris', 'madison', 'mildred', 'mack', 'mike', 'mitchell', 'marshall'
    motley.invite 'ruben', 'frederique', 'haley'

    rugrats = Team.new('rugrats').save
    rugrats.managed_by 'charlie'
    rugrats.add 'rachel', 'russ', 'rita', 'rolf', 'randall', 'river', 'rick', 'rudi'
    rugrats.invite 'ryan', 'ruben', 'bob'

    slate = Team.new('slate').save
    slate.managed_by 'bob'
    members = [
      'amelie', 'beth', 'claire', 'dawson', 'elisa', 'frederique', 'grace', 'haley',
      'isaac', 'jarrod', 'kieran', 'lisa', 'mia', 'norma', 'opal', 'paula', 'quentin',
      'rachel', 'ruben', 'shaina', 'talia', 'ursula', 'vince', 'wilson', 'xavier',
      'yvette', 'zachary'
    ]
    slate.add *members

    polkadots = Team.new('polkadots').save
    polkadots.managed_by 'bob'
    polkadots.add 'bob', 'rudi', 'rachel'
    polkadots.invite 'ruben'

    system("pg_dump -U exercism exercism_seeds -f db/seeds.sql")
  end
end

task default: "seeds:generate"

