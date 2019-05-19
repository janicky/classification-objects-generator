require 'faker'
require 'nokogiri'
require_relative 'classification_object'

if ARGV.length != 2
    puts "No filename or objects count param."
    return
end

filename = ARGV[0]
count = ARGV[1]

generated = []
generators = [
    ["got", Faker::TvShows::GameOfThrones],
    ["twinpeaks", Faker::TvShows::TwinPeaks],
    ["siliconvalley", Faker::TvShows::SiliconValley],
    ["friends", Faker::TvShows::Friends],
    ["drwho", Faker::TvShows::DrWho],
    ["simpsons", Faker::TvShows::Simpsons]
]

labels_count = Hash.new(0)

while generated.length < count.to_i do
    generator = generators.sample
    object = ClassificationObject.new(generator[0], generator[1].quote)
    f = generated.select { |e| e.text == object.text }
    next unless f.first.nil?
    generated.push object

    print '.'
    labels_count[object.label] += 1
end
puts
labels_count.each {|key, value| puts "#{key}: #{value}" }

builder = Nokogiri::XML::Builder.new do |xml|
xml.root {
    xml.quotes {
        generated.each do |o|
            xml.quote {
                xml.tvserie o.label
                xml.content o.text
            }
        end
    }
}
end

doc = Nokogiri::XML(builder.to_xml)
File.write(filename, doc.to_xml)