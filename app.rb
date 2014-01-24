class SpellChecker

  def initialize
    @dictionary = Dictionary.new
  end

  def call env
    pattern = env['REQUEST_PATH'][1..-1]

    if @dictionary.search pattern
      [ 200,
        {"Content-Type" => "text/html"},
        ["#{@dictionary.search pattern}"]
      ]
    else
      [ 404,
        {"Content-Type" => "text/plain"},
        ["Not found"]
      ]
    end
  end
end

class Dictionary
  def initialize
    @words = []

    File.open("words.txt","r") do |file|
      while (line = file.gets)
        @words << line.chomp
      end
    end
  end

  def search (word)
    @words.include? word
  end
end
