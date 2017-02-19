require 'csv'

task import: :environment do
  importer = Importer.new(SimpleXlsxReader.open("db/data/data.xlsx"))
  importer.call
end

task import_endings: :environment do
  importer = Importer.new(SimpleXlsxReader.open("db/data/data.xlsx"))
  importer.import_endings
end

