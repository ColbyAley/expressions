require 'spec_helper'

describe Expression do
  describe '#initialize' do
    it 'should return an Expression' do
      expect(Expression.new('A+1')).to be_kind_of(Expression)
    end

    it 'should return an expression with formula set' do
      formula = 'A+1'
      expect(Expression.new(formula).formula).to eq(formula)
    end
  end

  describe '#set_variable' do
    subject(:expression) { Expression.new('A+1') }

    it 'should add variable to #variables' do
      expression.set_variable(:a, 5)
      expect(expression.variables[:A]).to eq(5)


      expression.set_variable(:B, 5)
      expect(expression.variables[:B]).to eq(5)

      expression.set_variable('c', 5)
      expect(expression.variables[:C]).to eq(5)
    end
  end

  describe '#to_i' do
    it 'should evaluate expression and return an int' do
      expect(Expression.new('1').to_i).to eq(1)
    end

    context 'with undefined variables' do
      it 'should raise an UndefinedVariableException when there is an undefined variable.' do
        e = Expression.new('A+1')
        expect{ e.to_i }.to raise_error(UndefinedVariableException)
      end
    end

    context 'with variables' do
      it 'should calculate expression with variable and return an int' do
        e = Expression.new('A+1')
        e.set_variable(:a, 100)
        expect(e.to_i).to eq(101)
      end

      it 'should handle multiple variables and return an int' do
        e = Expression.new('A+Z')
        e.set_variable(:a, 5)
        e.set_variable(:z, 10)
        expect(e.to_i).to eq(15)
      end

      context 'with expressions as variables' do
        it 'should allow expressions to be variables' do
          e = Expression.new('Z/4')
          e.set_variable(:z, Expression.new('95+5'))
          expect(e.to_i).to eq(25)
        end
      end
    end
  end

  describe '#to_s' do
    it 'should evaluate expression and return a string' do
      expect(Expression.new('1').to_s).to be_kind_of(String)
    end
  end

  describe '#+' do
    it 'should add two values and return int' do
      expect(Expression.new('1') + Expression.new('2')).to eq(3)
      expect(Expression.new('100') + Expression.new('200')).to eq(300)
      expect(Expression.new('1+1') + Expression.new('2+2')).to eq(6)
      expect(5 + Expression.new('1+1') + 5).to eq(12)
    end
  end
end
