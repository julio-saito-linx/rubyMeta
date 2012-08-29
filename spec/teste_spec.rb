require 'spec_helper'
require 'pry'

describe 'algo sobre ruby, por akita' do

  it 'reduce eh uma boa forma de iterar numa lista pelo total' do
    expect{ (1..100).reduce(0) {|total, i| total += i} }.to be 5050
    expect{ (1..100).reduce(:+) }.to be 5050
  end

  it 'Johann Carl Friedrich Gaus' do
    expect{ (1..100).reduce(:+) }.to be 101 * 50
  end

  it "o zip permite criar hashes a partir de duas listas distintas" do
    listaKeys    = [:a, :b, :c, :d]
    listaValores = [ 1,  2,  3,  4]
    hash = Hash[listaKeys.zip(listaValores)]
    expect { hash[:b] }.to be 2
  end

end

describe "self" do

  class Person
    # quanto escreve SELF.count aqui, ele fica associando a "classe"
    # só no ruby mesmo... kkk
    def self.count
      @count ||= 0
    end

    def self.count=(increment)
      @count = increment
    end

    def initialize(name)
      @name = name
      self.class.count += 1
    end

    def name
      @name
    end
  end

  it "primeiro verifica no receiver padrao" do
    def faca_no_pai
      'DEF'
    end
    class Classe1
      def faca_algo
        'ABC'
      end
      def chama_o_pai
        faca_no_pai # primeiro procura na classe, não vai achar, então sobe um nível
      end
      def chama_outro
        faca_algo # self não é obrigatório aqui
      end
    end

    c1 = Classe1.new
    expect { c1.faca_algo }.to be 'ABC'
    # o self
    expect { c1.chama_outro }.to be 'ABC'
    expect { c1.chama_o_pai }.to be 'DEF'
  end

  it "associar a variavel de instancia diretamente a classe" do
    # @count foi associado a classe
    john = Person.new("John Doe")
    expect{Person.count}.to be 1

    john = Person.new("Mario Pinto")
    expect{Person.count}.to be 2
  end

  it "todo objeto esta associado a classe que o gerou e uma classe anonima" do
    # representa o count da classe
    expect { Person.singleton_methods.length }.to be 1
  end

end

describe "singleton" do

  it "injetar metodos apenas afeta a classe que se injetou" do
    string = "Hi there!"
    another_string = "Hi there!"
    def string.to_yo
      self.gsub(/\b(Hi|Hello)( there)\b?!?/, "Yo! Wassup?")
    end
    expect { string.to_yo }.to be "Yo! Wassup?"
    expect { another_string.respond_to?(:to_yo) }.to be_false
  end

  it "a classe quando definida com new, pega o nome da primeira constante" do
    cls = Class.new
    expect {cls.name}.to be_nil

    MyClass = cls
    expect{MyClass.name}.to be "MyClass"

    OtherClass = cls
    expect{OtherClass.name}.to be "MyClass"
  end

end

describe "modulos" do
  it "podemos inserir pais em classes" do
    module Summable
      def sum
        inject(:+)
      end
    end

    class Array; include Summable; end
    class Range; include Summable; end
    binding.pry

    expect { Array.ancestors[1] }.to be Summable
  end
end

