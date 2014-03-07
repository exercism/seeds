namespace :seeds do
  desc "Generate seed data"
  task :generate do
    require_relative 'seeds'
    Reset.hard

    alice = User.create('alice', mastery: Languages.all.to_yaml)
    amelie = User.create('amelie')
    beth = User.create('beth')
    bob = User.create('bob')
    charlie = User.create('charlie', mastery: ['ruby'].to_yaml)
    claire = User.create('claire')
    dawson = User.create('dawson')
    diana = User.create('diana', mastery: ['javascript'].to_yaml)
    elisa = User.create('elisa')
    eve = User.create('eve', mastery: ['python'].to_yaml)
    frederique = User.create('frederique')
    grace = User.create('grace')
    haley = User.create('haley')
    isaac = User.create('isaac')
    jarrod = User.create('jarrod')
    kieran = User.create('kieran')
    lisa = User.create('lisa')
    mack = User.create('mack')
    madison = User.create('madison')
    madison = User.create('madison')
    marshall = User.create('marshall')
    mary = User.create('mary')
    mia = User.create('mia')
    mike = User.create('mike')
    mildred = User.create('mildred')
    mitchell = User.create('mitchell')
    morris = User.create('morris')
    norma = User.create('norma')
    opal = User.create('opal')
    paula = User.create('paula')
    quentin = User.create('quentin')
    rachel = User.create('rachel')
    randall = User.create('randall')
    rick = User.create('rick')
    rita = User.create('rita')
    river = User.create('river')
    rolf = User.create('rolf')
    ruben = User.create('ruben')
    rudi = User.create('rudi')
    russ = User.create('russ')
    ryan = User.create('ryan')
    shaina = User.create('shaina')
    talia = User.create('talia')
    ursula = User.create('ursula')
    vince = User.create('vince')
    wilson = User.create('wilson')
    xavier = User.create('xavier')
    yvette = User.create('yvette')
    zachary = User.create('zachary')

    bob.submit(100)
    diana.submit(15, 'javascript')
    eve.submit(15, 'haskell')
    [
      mary, morris, madison, mildred, mack, mike, mitchell, marshall,
      amelie, beth, claire, dawson, elisa, frederique, grace, haley,
      isaac, jarrod, kieran, lisa, mia, norma, opal, paula, quentin,
      ruben, shaina, talia, ursula, vince, wilson, xavier, yvette,
      zachary
    ].each do |user|
      user.submit(20)
    end
    [rachel, russ, rita, rolf, randall, river, rick, ryan].each do |user|
      user.submit(20, 'ruby')
    end


    baconesia = Team.new('baconesia').save
    baconesia.managed_by alice
    baconesia.managed_by bob
    baconesia.managed_by charlie
    [mary, isaac, lisa, mia, elisa, claire, beth, paula, quentin, river].each do |user|
      baconesia.add user
    end
    [jarrod, kieran, opal, rachel, ruben, shaina, talia, xavier].each do |user|
      baconesia.invite user
    end

    chocolades = Team.new('chocolades').save
    chocolades.managed_by alice
    [bob, river, quentin, xavier].each do |user|
      chocolades.add user
    end
    [mack, ruben].each do |user|
      chocolades.invite user
    end

    ghost = Team.new('ghost').save
    ghost.managed_by alice
    ghost.invite ruben
    ghost.invite bob

    motley = Team.new('motley').save
    motley.managed_by alice
    motley.managed_by bob
    [bob, rachel, mary, morris, madison, mildred, mack, mike, mitchell, marshall].each do |user|
      motley.add user
    end
    [ruben, frederique, haley].each do |user|
      motley.invite user
    end

    rugrats = Team.new('rugrats').save
    rugrats.managed_by charlie
    [rachel, russ, rita, rolf, randall, river, rick, rudi].each do |user|
      rugrats.add user
    end
    [ryan, ruben, bob].each do |user|
      rugrats.invite user
    end

    slate = Team.new('slate').save
    slate.managed_by bob
    [
      amelie, beth, claire, dawson, elisa, frederique, grace, haley,
      isaac, jarrod, kieran, lisa, mia, norma, opal, paula, quentin,
      rachel, ruben, shaina, talia, ursula, vince, wilson, xavier,
      yvette, zachary
    ].each do |user|
      slate.add user
    end

    polkadots = Team.new('polkadots').save
    polkadots.managed_by bob
    [bob, rudi, rachel].each do |user|
      polkadots.add user
    end
    polkadots.invite ruben

    system("pg_dump -U exercism exercism_seeds -f db/seeds.sql")
  end
end

task default: "seeds:generate"

