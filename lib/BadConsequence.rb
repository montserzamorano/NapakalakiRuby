#encoding: UTF-8

# Clase BadConsequence
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'TreasureKind.rb'

module Model
  
  class BadConsequence
  
    #Variable de instancia de las que se genera de forma automática el consultor 
    #de estos atributos y público
    attr_reader :text, :levels, :nVisibleTreasures, :nHiddenTreasures,
      :specificVisibleTreasures, :specificHiddenTreasures, :death
  
    #Constructor de los objetos de la clase BadConsequence.
    #Parámetros:
    #* aText  Representar lo que dice un mal rollo. 
    #* someLevels Niveles que se pierden.
    #* someVisibleTreasures Número de tesoros visibles que se pierden. 
    #* someHiddenTreasures Número de tesoros ocultos que se pierden.
    #* someSpecificVisibleTreasures Lista de tesoros visibles.
    #* someSpecificHiddenTreasures Lista de tesoros ocultos.
    #* death  Mal rollo de tipo muerte.
  
    def initialize(aText, someLevels, someVisibleTreasures, someHiddenTreasures, 
      someSpecificVisibleTreasures, someSpecificHiddenTreasures, death)
        @text = aText
        @levels = someLevels
        @nVisibleTreasures = someVisibleTreasures
        @nHiddenTreasures = someHiddenTreasures
      
        @specificVisibleTreasures = Array.new
        if(someSpecificVisibleTreasures != nil)
          someSpecificVisibleTreasures.each do |vtreasure|
            @specificVisibleTreasures << vtreasure
          end
        end
      
        @specificHiddenTreasures = Array.new
        if (someSpecificHiddenTreasures != nil)
          someSpecificHiddenTreasures.each do |htreasure|
            @specificHiddenTreasures  << htreasure
          end
        end
        @death = death
    end
=begin
*******************************************************************
* Métodos de instancia de clase que son los nuevos constructores. *
*******************************************************************
=end  
    
#    def self.newBadConsequence(bc)
#      new(bc.text, bc.levels, bc.nVisibleTreasures, bc.nHiddenTreasures,
#      bc.specificVisibleTreasures, bc.specificHiddenTreasures, bc.death)
#    end
# 
    #Anula el método constructor new para que no podamos usarlo tal cual  
    private_class_method :new
  
    # Devuelve true cuando el mal rollo está vacío. Eso significa que el conjunto
    # de atributos de mal rollo indican que no hay mal rollo que cumplir, planteate
    # que valores deberán tener.
    def isEmpty
      (@nVisibleTreasures == 0) && (@nHiddenTreasures == 0) && 
        (@specificVisibleTreasures.empty?) && (@specificHiddenTreasures.empty?)
    end
  
    # Devuelve true si es un mal rollo es muerte, false en caso contrario.
    def kills
      @death
    end
  
    #void
    def substractVisibleTreasure(t) #t->Treasure
      raise NotImplementedError.new
    end
  
    #void
    def substractHiddenTreasure(t) #t->Treasure
      raise NotImplementedError.new
    end
    
    #BadConsequence
    def adjustToFitTreasureLists(v, h) #v, h->Treasure [] 
       raise NotImplementedError.new
#      # BadConsequence especificando el número de tesoros
#      if((@nVisibleTreasures != 0) || (@nHiddenTreasures != 0)) 
#        if(@nVisibleTreasures > v.size)
#          nVisible = v.size
#        else
#          nVisible = @nVisibleTreasures 
#        end
#        
#        if(@nHiddenTreasures > h.size)
#          nHidden = h.size
#        else
#          nHidden = @nHiddenTreasures 
#        end
#         
#        bc = BadConsequenceSpecific.new(@text, @levels, nVisible, nHidden)
#      else # BadConsequence especificando los tipos de tesoros
#        vTreasures = Array.new
#        hTreasures = Array.new
#     
#        @specificVisibleTreasures.each do |visible|
#          if((v.detect {|vis| vis.type == visible}) != nil)
#            vTreasures << visible
#          end
#        end
#      
#        @specificHiddenTreasures.each do |hidden|
#          if((h.detect {|oculto| oculto.type == hidden}) != nil)
#            hTreasures << hidden
#          end
#        end
#      
#        bc = BadConsequenceSpecific.new(@text, @levels, vTreasures, 
#          hTreasures)
#      end
#      
#      return bc
    end
  
    def imprimirTreasures(treasures, texto)
      unless treasures.empty?
        texto << "\n    Lista: "
        treasures.each do |treasure|
          if(treasure == TreasureKind::ONEHAND)
            texto << "\n    -Una mano"
          elsif(treasure == TreasureKind::ARMOR)
            texto << "\n    -Armadura"
          elsif(treasure == TreasureKind::BOTHHANDS)
            texto << "\n    -Ambas manos" 
          elsif(treasure == TreasureKind::HELMET)
            texto << "\n    -Casco"  
          elsif(treasure == TreasureKind::SHOE)
            texto << "\n    -Zapato"  
          elsif(treasure == TreasureKind::NECKLACE)
            texto << "\n    -Collar"
          end
        end
      end # Fin de unless
    end
    
    #Método que devuelve el estado completo del objeto.
    def to_s
      raise NotImplementedError.new
    end
  
  end # Fin BadConsequence
end #Fin Model

