#encoding: UTF-8

# Clase Monster
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'Card.rb'

module Model
  
  class Monster
    include Card
  
    #Variable de instancia de las que se genera de forma automática el consultor 
    #de estos atributos y público
    attr_reader :name, :level, :bc, :price, :levelChangeAgainstCultistPlayer
  
    # Constructor de los objetos de la clase Monster.
    # Parámetros:
    # name Nombre del montruo 
    # level  Nivel de combate del monstruo
    # bc de tipo BadConsequence
    # price  de tipo Prize


    def initialize(name, level, bc, price, lC=0)
      @name = name;
      @level = level;
      @bc = bc;
      @price = price;
      @levelChangeAgainstCultistPlayer = lC
    end
  
    # Constructor de copia
    # m objeto a copiar
#    def self.newMonster(m)
#      new(m.name, m.level, BadConsequence.newBadConsequence(m.bc),
#        Prize.newPrize(m.price), m.levelChangeAgainstCultistPlayer)
#    
#    end
  
    #Método que devuelve el estado completo del objeto.
    def to_s
      "\nNOMBRE:  #{@name} \n Nivel de combate =  #{@level} " +
        "\n Nivel sectario: #{@levelChangeAgainstCultistPlayer} #{@bc} #{@price}"
    end
    
    private
    #int
    def levelChangeAgainstCultistPlayer
      @levelChangeAgainstCultistPlayer
    end
    
    public
    #int
    def getLevel
      @level
    end
    
    #int
    def getBasicValue
      self.getLevel
    end
    
    #int
    def getSpecialValue
      self.getLevel + @levelChangeAgainstCultistPlayer
    end
  
  end # Fin Monster
end #Fin Model