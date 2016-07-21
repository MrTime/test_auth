class MyCSV
  def self.parse path, options
    options[:row_sep] ||= "\n"
    options[:col_sep] ||= ";"
    rows = []
    text = File.read(path)
    text.split(options[:row_sep]).each do |row|
      rows << row.split(options[:col_sep])
    end
    rows
  end

  def self.foreach path, &block
    rows = []
    text = File.read(path)
    text.split("\n").each do |row|
      rows << row.split(';')
      yield(row.split(';'))
    end
    rows
  end

end

namespace :parser do
  desc "TODO"
  task csv: :environment do
    path = ENV['CSV']
    #rows = MyCSV.parse(path)
    #puts rows.inspect
    #rows.each do |row|
    #  Car.create!(title: row[0], price: row[1])
    #end

    MyCSV.foreach(path) do |row| 
      puts "CALED"
      Car.create!(title: row[0], price: row[1]) 
    end
  end

end
