require 'expressions/version'

module Expressions
  class UndefinedVariableException < Exception; end

  class Expression
    attr_accessor :formula, :variables

    OPERATORS = ['+', '-', '*', '/']

    # @param [String] formula formula to evaluate
    def initialize(formula)
      @formula   = formula.to_s
      @variables = Hash.new
    end

    # Set a variable to be evaluated in the expression.
    #
    # @param [String, Symbol] k
    # @param [Integer, String, Expression] v
    def set_variable(k,v)
      key = k.to_s.upcase.to_sym
      variables[key] = v
    end

    # Allow us to treat an Expression like a string or an integer.
    def to_i;          evaluate.to_i;                      end
    def to_s;          evaluate.to_s;                      end
    def +(other);      to_i + other.to_i;                  end
    def coerce(other); [self.class.new(other.to_s), self]; end

    private

    # @return [Integer]
    def evaluate
      f = extract_variables(formula)
      calculate(f)
    end

    # Extract variables from formula
    #
    # @param [String] formula formula to evaluate
    # @return [String]
    def extract_variables(formula)
      f = formula.split('')
      f.map! {|t| is_variable?(t) ? evaluate_variable(t) : t}
      f.join('')
    end

    # calculate string using order of operations.
    #
    # @param [String] string string to calculate
    # @return [Integer]
    def calculate(string)
      int = string

      OPERATORS.each do |operator|
        parts = int.to_s.split(operator)

        if parts.length > 1 # only if there are actually multiple parts to operate on.
          int = parts
                .map {|p| calculate(p) } # turtles all the way down
                .map(&:to_i) # convert everything to ints
                .reduce(operator.to_sym) # "combine" parts using operator
        end
      end

      int
    end

    # It's a variable if it's an uppercased letter.
    #
    # @param [String] k
    # @return [Boolean]
    def is_variable?(k)
      k =~ /[A-Z]/
    end

    # Grab a variable given a key, otherwise raise an exception if variable is not set.
    #
    # @param [String] k
    def evaluate_variable(k)
      key = k.upcase.to_sym

      if variables.has_key?(key)
        return variables[key].to_i
      else
        raise UndefinedVariableException
      end
    end
  end
end

include Expressions
