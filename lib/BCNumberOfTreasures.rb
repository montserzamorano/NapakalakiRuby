#encoding: UTF-8

# Clase BCNumberOfTreasures
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'TreasureKind.rb'
require_relative 'BadConsequence.rb'
require_relative 'CardDealer.rb'

module Model
  
  class BCNumberOfTreasures < BadConsequence
    def initialize(aText, someLevels, someVisibleTreasures, someHiddenTreasures)
      super(aText, someLevels, someVisibleTreasures, someHiddenTreasures, Array.new, Array.new, false)
    end
    public_class_method :new
  
    def adjustToFitTreasureLists(v, h) #v, h->Treasure [] 
      #BadConsequence especificando el número de tesoros 
        if(@nVisibleTreasures > v.size)
          nVisible = v.size
        else
          nVisible = @nVisibleTreasures 
        end
        
        if(@nHiddenTreasures > h.size)
          nHidden = h.size
        else
          nHidden = @nHiddenTreasures 
        end
         
        bc = BCNumberOfTreasures.new(@text, @levels, nVisible, nHidden)
    end
    
    def substractVisibleTreasure(t)
      if (@nVisibleTreasures > 0)
        @nVisibleTreasures-=1
      end
      
      dealer = CardDealer.instance
      dealer.giveTreasureBack(t)
    end

    def substractHiddenTreasure(t)
      if(@nHiddenTreasures > 0)
        @nHiddenTreasures-=1
      end
      
      dealer = CardDealer.instance
      dealer.giveTreasureBack(t)
    end
    
    def to_s
      "\n Esto es un mal rollo con el siguiente contenido: \n  #{@text} \n   Niveles" +
        "  perdidos: #{@levels} \n    Número de tesoros visibles perdidos: " +
        " #{@nVisibleTreasures} \n    Número de tesoros ocultos perdidos: " +
        " #{@nHiddenTreasures}"
    end
    
  end #Fin BCNumberOfTreasures
end #Fin Model