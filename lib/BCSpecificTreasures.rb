#encoding: UTF-8

# Clase BCSpecificTreasures
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'TreasureKind.rb'
require_relative 'BadConsequence.rb'
require_relative 'CardDealer.rb'

module Model
  
  class BCSpecificTreasures < BadConsequence
    
    def initialize(aText, someLevels, someSpecificVisibleTreasures, someSpecificHiddenTreasures)
      super(aText, someLevels, 0, 0, someSpecificVisibleTreasures, someSpecificHiddenTreasures, false)
    end
    public_class_method :new
  
    def adjustToFitTreasureLists(v, h) #v, h->Treasure []
      #BadConsequence especificando los tipos de tesoros
      vTreasures = Array.new
      hTreasures = Array.new
     
      @specificVisibleTreasures.each do |visible|
        if((v.detect {|vis| vis.type == visible}) != nil)
          vTreasures << visible
        end
      end
      
      @specificHiddenTreasures.each do |hidden|
        if((h.detect {|oculto| oculto.type == hidden}) != nil)
          hTreasures << hidden
        end
      end
      
      bc = BCSpecificTreasures.new(@text, @levels, vTreasures, 
        hTreasures)
       
      return bc
    end
  
    def substractVisibleTreasure(t)
      if(!@specificVisibleTreasures.empty?)
        @specificVisibleTreasures.delete(t.type)
      end
      
      dealer = CardDealer.instance
      dealer.giveTreasureBack(t)
    end

    def substractHiddenTreasure(t)
      if(!@specificHiddenTreasures.empty?)
        @specificHiddenTreasures.delete(t.type)
      end
      
      dealer = CardDealer.instance
      dealer.giveTreasureBack(t)
    end
  
    def to_s
      texto = "\n Esto es un mal rollo con el siguiente contenido: \n   #{@text} \n   Niveles" +
        " perdidos: #{@levels} \n   Tesoros visibles perdidos:"     
      imprimirTreasures(@specificVisibleTreasures, texto) 
      texto += "\n   Tesoros ocultos perdidos:"
      imprimirTreasures(@specificHiddenTreasures, texto)
      
      return texto  
    end
    
  end #Fin BCSpecificTreasures
end #Fin Model