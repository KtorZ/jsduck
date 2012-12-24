require "jsduck/builtins/tag"

module JsDuck::Builtins
  # Base class for simple boolean @tags.
  # Subclasses should only define @key and call #super,
  # which will take care of setting up @pattern with the same name.
  class BooleanTag < Tag
    def initialize
      @pattern = @key.to_s
    end

    # Parses just the name of the tag.
    def parse(p)
      p.add_tag(@key)
    end

    # When the tag is found, its value will always be true.
    def process_doc(docs)
      true
    end
  end
end
