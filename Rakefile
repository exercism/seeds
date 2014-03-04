namespace :seeds do
  desc "Generate seed data"
  task :generate do
    require_relative 'seeds'
    Reset.hard

    dev = Sequel.connect('postgres://exercism:@localhost/exercism_development')
    seeds = Sequel.connect('postgres://exercism:@localhost/exercism_seeds')

    alice = User.new('alice', mastery: Languages.all.to_yaml).save_to(seeds)
    amelie = User.new('amelie').save_to(seeds)
    beth = User.new('beth').save_to(seeds)
    bob = User.new('bob').save_to(seeds)
    charlie = User.new('charlie', mastery: ['ruby'].to_yaml).save_to(seeds)
    claire = User.new('claire').save_to(seeds)
    dawson = User.new('dawson').save_to(seeds)
    diana = User.new('diana', mastery: ['javascript'].to_yaml).save_to(seeds)
    elisa = User.new('elisa').save_to(seeds)
    eve = User.new('eve', mastery: ['python'].to_yaml).save_to(seeds)
    frederique = User.new('frederique').save_to(seeds)
    grace = User.new('grace').save_to(seeds)
    haley = User.new('haley').save_to(seeds)
    isaac = User.new('isaac').save_to(seeds)
    jarrod = User.new('jarrod').save_to(seeds)
    kieran = User.new('kieran').save_to(seeds)
    lisa = User.new('lisa').save_to(seeds)
    mack = User.new('mack').save_to(seeds)
    madison = User.new('madison').save_to(seeds)
    madison = User.new('madison').save_to(seeds)
    marshall = User.new('marshall').save_to(seeds)
    mary = User.new('mary').save_to(seeds)
    mia = User.new('mia').save_to(seeds)
    mike = User.new('mike').save_to(seeds)
    mildred = User.new('mildred').save_to(seeds)
    mitchell = User.new('mitchell').save_to(seeds)
    morris = User.new('morris').save_to(seeds)
    norma = User.new('norma').save_to(seeds)
    opal = User.new('opal').save_to(seeds)
    paula = User.new('paula').save_to(seeds)
    quentin = User.new('quentin').save_to(seeds)
    rachel = User.new('rachel').save_to(seeds)
    randall = User.new('randall').save_to(seeds)
    rick = User.new('rick').save_to(seeds)
    rita = User.new('rita').save_to(seeds)
    river = User.new('river').save_to(seeds)
    rolf = User.new('rolf').save_to(seeds)
    ruben = User.new('ruben').save_to(seeds)
    rudi = User.new('rudi').save_to(seeds)
    russ = User.new('russ').save_to(seeds)
    ryan = User.new('ryan').save_to(seeds)
    shaina = User.new('shaina').save_to(seeds)
    talia = User.new('talia').save_to(seeds)
    ursula = User.new('ursula').save_to(seeds)
    vince = User.new('vince').save_to(seeds)
    wilson = User.new('wilson').save_to(seeds)
    xavier = User.new('xavier').save_to(seeds)
    yvette = User.new('yvette').save_to(seeds)
    zachary = User.new('zachary').save_to(seeds)

    bob.submit(100, dev, seeds)
    diana.submit(15, dev, seeds, 'javascript')
    eve.submit(15, dev, seeds, 'haskell')
    [
      mary, morris, madison, mildred, mack, mike, mitchell, marshall,
      amelie, beth, claire, dawson, elisa, frederique, grace, haley,
      isaac, jarrod, kieran, lisa, mia, norma, opal, paula, quentin,
      ruben, shaina, talia, ursula, vince, wilson, xavier, yvette,
      zachary
    ].each do |user|
      user.submit(20, dev, seeds)
    end
    [rachel, russ, rita, rolf, randall, river, rick, ryan].each do |user|
      user.submit(20, dev, seeds, 'ruby')
    end


    baconesia = Team.new('baconesia', seeds).save
    baconesia.managed_by alice
    baconesia.managed_by bob
    baconesia.managed_by charlie
    [mary, isaac, lisa, mia, elisa, claire, beth, paula, quentin, river].each do |user|
      baconesia.add user
    end
    [jarrod, kieran, opal, rachel, ruben, shaina, talia, xavier].each do |user|
      baconesia.invite user
    end

    chocolades = Team.new('chocolades', seeds).save
    chocolades.managed_by alice
    [bob, river, quentin, xavier].each do |user|
      chocolades.add user
    end
    [mack, ruben].each do |user|
      chocolades.invite user
    end

    ghost = Team.new('ghost', seeds).save
    ghost.managed_by alice
    ghost.invite ruben
    ghost.invite bob

    motley = Team.new('motley', seeds).save
    motley.managed_by alice
    motley.managed_by bob
    [bob, rachel, mary, morris, madison, mildred, mack, mike, mitchell, marshall].each do |user|
      motley.add user
    end
    [ruben, frederique, haley].each do |user|
      motley.invite user
    end

    rugrats = Team.new('rugrats', seeds).save
    rugrats.managed_by charlie
    [rachel, russ, rita, rolf, randall, river, rick, rudi].each do |user|
      rugrats.add user
    end
    [ryan, ruben, bob].each do |user|
      rugrats.invite user
    end

    slate = Team.new('slate', seeds).save
    slate.managed_by bob
    [
      amelie, beth, claire, dawson, elisa, frederique, grace, haley,
      isaac, jarrod, kieran, lisa, mia, norma, opal, paula, quentin,
      rachel, ruben, shaina, talia, ursula, vince, wilson, xavier,
      yvette, zachary
    ].each do |user|
      slate.add user
    end

    polkadots = Team.new('polkadots', seeds).save
    polkadots.managed_by bob
    [bob, rudi, rachel].each do |user|
      polkadots.add user
    end
    polkadots.invite ruben

    system("pg_dump -U exercism exercism_seeds -f db/seeds.sql")
  end
end

task default: "seeds:generate"

