require 'csv'

task import: :environment do
  importer = Importer.new(SimpleXlsxReader.open("db/data/data.xlsx"))
  importer.call
end

