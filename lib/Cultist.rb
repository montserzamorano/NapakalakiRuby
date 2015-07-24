#encoding: UTF-8

# Clase Cultist
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'Card.rb'
require_relative 'CultistPlayer.rb'

module Model
  
  class Cultist
    include Card
    
    def initialize(name, gainedLevels)
      @name = name #string
      @gainedLevels = gainedLevels
    end
    
    def getBasicValue
      @gainedLevels
    end
    
    def getSpecialValue
      getBasicValue * CultistPlayer.getTotalCultistPlayers
    end
    
    def to_s
      "Sectario: #{@name} \n Niveles ganados: #{@gainedLevels}"
    end
  end
end
