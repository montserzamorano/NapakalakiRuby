#encoding: UTF-8

# Clase BadConsequenceDeath
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'TreasureKind.rb'
require_relative 'BadConsequence.rb'
require_relative 'CardDealer.rb'

module Model
  
  class BCDeath < BadConsequence
    
    def initialize(aText)
      super(aText, 0, 0, 0, nil, nil, true)
    end
    public_class_method :new
    

    def adjustToFitTreasureLists(v, h) #v,h->ArrayList <Treasure>
        self
    end
    
    def substractVisibleTreasure(t)
      dealer = CardDealer.instance
      dealer.giveTreasureBack(t)
    end

    def substractHiddenTreasure(t)
      dealer = CardDealer.instance
      dealer.giveTreasureBack(t)
    end
    
    def to_s
      "\n Esto es un mal rollo con el siguiente contenido: \n   #{@text} \n   Estás muerto"
    end 
    
  end #Fin BCDeath
end #Fin Model