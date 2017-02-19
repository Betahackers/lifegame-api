require 'csv'

# Card Title,Character,Left/Right,Answer Text,Love,Money,Fun,Health,Possible Death?,Age Constraint,Base Probability,Probability change per year
# "You have an STD, you have to stop having sex for a month, until we're completely sure you're healed.",doctor,Left,"No way, man.",0,0,10,-5,,-100,,
# "You have an STD, you have to stop having sex for a month, until we're completely sure you're healed.",doctor,Right,Alright man.,3,-3,3,0,,-100,,

task import: :environment do
  importer = Importer.new(SimpleXlsxReader.open("db/data/data.xlsx"))
  importer.call
end

