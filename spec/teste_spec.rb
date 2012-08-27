require 'spec_helper'

describe "self" do

  it "primeiro verifica no receiver padrao" do
    def faca_no_pai
      'DEF'
    end
    class Classe1
      def faca_algo
        'ABC'
      end
      def chama_o_pai
        faca_no_pai # primeiro procura na classe, não vai achar, então sobe
      end
      def chama_outro
        faca_algo # self não é obrigatório aqui
      end
    end

    c1 = Classe1.new
    expect { 'ABC' }.to be c1.faca_algo
    # o self
    expect { 'ABC' }.to be c1.chama_outro
    expect { 'DEF' }.to be c1.chama_o_pai
  end

end


