#
# GitHub URL: https://github.com/aluminous/csci3308_labs/tree/master/Lab2
#

# Part1: Hello World
class HelloWorldClass
  def initialize(name)
    @name = name.capitalize
  end
  def sayHi
    puts "Hello #{@name}!"
  end
end
hello = HelloWorldClass.new("Austin")
hello.sayHi

# Part2: Strings
def palindrome?(string)
  string = string.downcase.gsub(/[^[a-z]]/, '')

  string == string.reverse
end

def count_words(string)
  string = string.downcase.gsub(/[^ a-z]*/, '').gsub(/  +/, ' ')

  words = {}
  string.split(' ').each { |word|
    words[word] = words.key?(word) ? words[word]+1 : 1
  }

  words
end

# Part3: Rock Paper Scissors
class WrongNumberOfPlayersError <  StandardError ; end
class NoSuchStrategyError <  StandardError ; end

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  if game.first.first.kind_of?(Array)
    left = rps_game_winner(game[0])
    right = rps_game_winner(game[1])
  else
    left = game[0]
    right = game[1]
  end

  leftMove = left[1].downcase
  rightMove = right[1].downcase

  # Validate strategy
  moves = ['r', 'p', 's']
  if !(moves.include? leftMove) or !(moves.include? rightMove)
    raise NoSuchStrategyError
  end

  # Determine winner
  if leftMove == rightMove
    return left
  elsif leftMove == "s"
    return rightMove == "r" ? right : left
  elsif leftMove == "r"
    return rightMove == "p" ? right : left
  elsif leftMove == "p"
    return rightMove == "s" ? right : left
  end
end

#
# Part4: Anagrams
#

def combine_anagrams(words)
  groups = {}

  words.map { |word|
    letters = word.downcase.chars.sort.join

    if groups.key? letters
      groups[letters] << word
    else
      groups[letters] = [word]
    end
  }

  groups.values
end
