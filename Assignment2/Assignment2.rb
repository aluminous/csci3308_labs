#
# GitHub URL: https://github.com/aluminous/csci3308_labs/tree/master/Assignment2
#

#
# Part 1
#

class Dessert
  # Automatically generate getters and setters
  attr_accessor :name, :calories

  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  def healthy?
    @calories < 200
  end

  def delicious?
    true
  end
end

class JellyBean < Dessert
  attr_accessor :flavor

  def initialize(name, calories, flavor)
    super(name, calories);

    @flavor = flavor
  end

  def delicious?
    @flavor != "black licorice"
  end
end

lavaCake = Dessert.new("Lava Cake", 750)
fruitPlate = Dessert.new("Fruit Plate", 160)

puts lavaCake.name, lavaCake.healthy?, lavaCake.delicious?
puts fruitPlate.name, fruitPlate.healthy?, fruitPlate.delicious?

lavaCake.name = "Chocolate Lava Cake"
puts lavaCake.name, lavaCake.healthy?, lavaCake.delicious?

alphaBean = JellyBean.new("JellyBelly", 20, "Green Apple")
betaBean = JellyBean.new("JellyBelly", 20, "black licorice")

puts alphaBean.name, alphaBean.flavor, alphaBean.delicious?
puts betaBean.name, betaBean.flavor, betaBean.delicious?

#
# Part 2
#

class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s       # make sure it's a string
    attr_reader attr_name            # create the attribute's getter

    class_eval %Q{
      @#{attr_name}_history = []

      def #{attr_name}= (val)
        self.#{attr_name}_history << val
        @#{attr_name} = val
      end

      def #{attr_name}_history
        if @#{attr_name}_history.nil?
          @#{attr_name}_history = [self.#{attr_name}]
        end

        @#{attr_name}_history
      end
    }
  end
end

class Foo
  attr_accessor_with_history :bar
end

puts f = Foo.new     # => #<Foo:0x127e678>
puts f.bar_history.inspect   # => [nil, 3, :wowzo, 'boo!']
puts f.bar = 3       # => 3
puts f.bar = :wowzo  # => :wowzo
puts f.bar = 'boo!'  # => 'boo!'
puts f.bar_history.inspect   # => [nil, 3, :wowzo, 'boo!']

f = Foo.new
f.bar = 1
f.bar = 2
puts f.bar_history.inspect # => if your code works, should be [nil, 1, 2]

#
# Part 3
#
class UnsupportedCurrencyError <  StandardError ; end

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
  def method_missing(currency)
    singular_currency = currency.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end

  def in(method_id)
    singular_currency = method_id.to_s.gsub( /s$/, '')

    if @@currencies.key?(singular_currency)
      self / @@currencies[singular_currency]
    else
      raise UnsupportedCurrencyError
    end
  end
end

puts 42.yen.in(:yen)
puts 1.yen.in(:dollars)
puts 1.dollar.in(:yen)
puts 1.dollars.in(:euros)
#puts 1.yen.in(:btc) # Unsupported currency

class String
  def palindrome?
    self.downcase.gsub(/[^[a-z]]/, '') == self.downcase.gsub(/[^[a-z]]/, '').reverse
  end
end

puts "Never odd or even".palindrome?

module Enumerable
  def palindrome?
    self.respond_to? :reverse and self == self.reverse
  end
end

puts 'Array:', [1,2,3,2,1].palindrome?.inspect # => true
test = { :foo => "bar", :tuna => "fish"}
puts 'Hash:', test.palindrome?.inspect # => false

#
# Part 4
#

class CartesianProduct
  include Enumerable

  def initialize(a, b)
    @left = a
    @right = b
  end

  def each
    @left.each { |l|
      @right.each { |r|
        yield [l, r]
      }
    }
  end
end

c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }

c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
