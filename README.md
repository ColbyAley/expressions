# Expressions

Allows users to create and evaluate simple mathematical expressions with changing variables.

## Installation

Add this line to your application's Gemfile:

    gem 'expressions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install expressions

## Usage

    e = Expression.new('A+12/2')
    e.set_variable(:a, 5)
    e.to_i # => 7

## Contributing

1. Fork it ( https://github.com/ColbyAley/expressions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
