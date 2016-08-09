namespace :generate do
  desc "generate markov chains"
  task :markov do
    Dir.glob("./nitpicks/*dat").each do |infile|
      language = infile[/([^\/]+)\.dat/, 1]
      outfile = "./fixtures/markov/#{language}.json"
      system("arkov b -f #{infile} -o #{outfile}")
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

    ##
    # users
    ##
    User.create('rikki-', avatar_url: "https://avatars.githubusercontent.com/u/8341419", github_id: 8341419)
    User.create('alice', track_mentor: Curriculum.languages.to_yaml)
    User.create('bob', track_mentor: ['ruby', 'haskell'].to_yaml)
    User.create('charlie', track_mentor: ['javascript', 'erlang', 'elixir'].to_yaml)
    User.create('diana', track_mentor: ['python'].to_yaml)
    [
      'amelie', 'beth', 'claire', 'dawson', 'eve', 'elisa', 'frederique', 'grace',
      'haley', 'isaac', 'jarrod', 'kieran', 'lisa', 'mack', 'madison', 'marshall',
      'mary', 'mia', 'mike', 'mildred', 'mitchell', 'morris', 'norma', 'opal',
      'paula', 'quentin', 'rachel', 'randall', 'rick', 'rita', 'river', 'rolf',
      'ruben', 'rudi', 'russ', 'ryan', 'shaina', 'talia', 'ursula', 'vince',
      'wilson', 'xavier', 'yvette', 'zachary'
    ].each do |username|
      user = User.create username
    end

    ##
    # teams
    ##
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

    submitted = ["lisa", "mike", "shaina", "morris", "vince"]
    received_feedback = ["haley", "ryan", "amelie", "rick", "jarrod"]
    completed = ["madison", "marshall", "river", "paula", "rita"]
    commented = ["zachary", "mitchell", "beth", "mia", "kieran"]
    onboarded = ["dawson", "elisa", "frederique", "isaac", "mary", "norma", "opal", "quentin", "randall", "ruben", "russ", "ursula", "wilson", "yvette"]
    track_mentor = ["alice", "bob", "charlie", "diana"]
    nitpickers = onboarded + track_mentor

    # Create submissions
    (onboarded + commented + completed + received_feedback + submitted).each do |username|
      user = User.find(username)

      Some.times.each { |i|
        ##
        # source
        ##
        e = Source.random_exercise

        next if Exercise.exists?(e, user)

        sx = Source.submissions_in(e)
        tsx = Chronology.random(sx.length+1, user.created_at)

        ##
        # destination
        ##
        exercise = Exercise.create(e, user, tsx.first, tsx.last)

        sx.zip(tsx).each do |s, ts|
          submission = Submission.create(s, exercise, ts)

          if rand(3) == 0
            # about 1/3 of the time, comment on your own submission first
            Comment.on(submission, user.id, Timestamp.soon_after(submission.created_at))
          end

          if !submitted.member?(username)
            Discussion.about(submission, nitpickers)
          end

          if rand(7) == 0
            if completed.member?(username)
              submission.archive!
            end

            if nitpickers.member?(username)
              submission.archive! if rand(3) > 0
            end
          end
        end
      }
    end

    commented.each do |username|
      user = User.find(username)
      scope = TARGET[:submissions].where("created_at > '#{user.created_at}' AND user_id != #{user.id}")
      attributes = scope.limit(1, rand(scope.count)).first
      next if attributes.nil?
      submission = Submission.new(attributes)
      Comment.on(submission, user.id, Timestamp.sometime_after(submission.created_at))
    end

    TARGET[:submissions].all.each do |attributes|
      Notification.process(Submission.new(attributes))
    end

    system("arkov seed --dir=fixtures/markov")

    system("pg_dump -U exercism exercism_seeds --data-only --exclude-table=schema_migrations -f db/seeds.sql")
  end
end

task default: "seeds:generate"
