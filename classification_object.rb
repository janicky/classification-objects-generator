class ClassificationObject
    attr_reader :text, :label
    def initialize(label, text)
        @text = text
        @label = label
    end
end