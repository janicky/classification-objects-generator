require 'faker'
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
    ["friends", Faker::TvShows::Friends]
]

while generated.length < count.to_i do
    generator = generators.sample
    object = ClassificationObject.new(generator[0], generator[1].quote)
    
    f = generated.select { |e| e.text == object.text }
    next unless f.first.nil?
    generated.push object
end