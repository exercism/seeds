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
    baconesia.managed_by alice, bob, charlie
    baconesia.add mary, isaac, lisa, mia, elisa, claire, beth, paula, quentin, river
    baconesia.invite jarrod, kieran, opal, rachel, ruben, shaina, talia, xavier

    chocolades = Team.new('chocolades').save
    chocolades.managed_by alice
    chocolades.add bob, river, quentin, xavier
    chocolades.invite mack, ruben

    ghost = Team.new('ghost').save
    ghost.managed_by alice
    ghost.invite ruben, bob

    motley = Team.new('motley').save
    motley.managed_by alice, bob
    motley.add bob, rachel, mary, morris, madison, mildred, mack, mike, mitchell, marshall
    motley.invite ruben, frederique, haley

    rugrats = Team.new('rugrats').save
    rugrats.managed_by charlie
    rugrats.add rachel, russ, rita, rolf, randall, river, rick, rudi
    rugrats.invite ryan, ruben, bob

    slate = Team.new('slate').save
    slate.managed_by bob
    members = [
      amelie, beth, claire, dawson, elisa, frederique, grace, haley,
      isaac, jarrod, kieran, lisa, mia, norma, opal, paula, quentin,
      rachel, ruben, shaina, talia, ursula, vince, wilson, xavier,
      yvette, zachary
    ]
    slate.add *members

    polkadots = Team.new('polkadots').save
    polkadots.managed_by bob
    polkadots.add bob, rudi, rachel
    polkadots.invite ruben

    system("pg_dump -U exercism exercism_seeds -f db/seeds.sql")
  end
end

task default: "seeds:generate"

