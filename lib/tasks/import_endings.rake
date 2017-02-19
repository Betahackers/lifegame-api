require 'csv'

task import_endings: :environment do
  puts "Importing endings"
  Ending.destroy_all
  CSV.foreach("db/data/endings.csv") do |row|
    Ending.create(reason: [row[0], row[1]].join("_").downcase, cause: row[2], effect: row[3])
  end
end

