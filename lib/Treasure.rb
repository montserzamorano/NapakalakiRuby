#encoding: UTF-8

# Clase Treasure
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'TreasureKind.rb'
require_relative 'Card.rb'

module Model
  class Treasure
    include Card
    
    attr_reader :name, :goldCoins, :minBonus, :maxBonus, :type 
  
    def initialize(n, g, min, max, t)
      @name = n #string
      @goldCoins = g #int
      @minBonus = min #int
      @maxBonus = max #int
      @type = t #TreasureKind
    end
  
    #Método que devuelve el estado completo del objeto.
    def to_s
      "\nNOMBRE:  #{@name} \n Piezas de oro =  #{@goldCoins} \n Bonus: \n  Mínimo " +
        "= #{@minBonus} \n  Máximo = #{@maxBonus} \n Tipo =  #{@type}"
    end
    
    #int
    def getBasicValue
      minBonus
    end

    #int
    def getSpecialValue
      maxBonus
    end
  end
end