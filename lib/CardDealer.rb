#encoding: UTF-8

# <<singleton>>
# Clase CarDealer
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'Cards.rb'
require_relative 'TreasureKind.rb'

module Model
  
  class CardDealer
    @@instance = nil

    def initialize
      @unusedMonsters = Array.new
      @usedMonsters = Array.new
      @unusedTreasures = Array.new
      @usedTreasures = Array.new
      @unusedCultists = Array.new
    end
  
    def self.instance
      if (@@instance == nil)
        @@instance = new
      end
    
      return @@instance
    end

    # Se privatiza para que no se pueda hacer un new CardDealer desde otro 
    # lugar que no sea dentro de la misma clase.
    private_class_method :new

      
    private
    # Inicializa el mazo de cartas de Tesoros (unusedTreasures) con todas las 
    # cartas de tesoros proporcionadas en el pdf de cartas de tesoros.
    #void 
    def initTreasureCardDeck
      Cards.newTreasures
      @unusedTreasures = Cards.treasures 
      shuffleTreasures
    end
    
    # Inicializa el mazo de cartas de monstruos (unusedMonsters), con todas las
    # cartas de monstruos proporcionadas en el pdf de cartas de monstruos.
    #void 
    def initMonsterCardDeck
      Cards.newMonsters
      @unusedMonsters = Cards.monstruos #referencia a la lista Cards.monstruos
      shuffleMonsters
    end
    
    # Baraja el mazo de cartas de tesoros unusedTreasures.
    #void 
    def shuffleTreasures
      #creo que sin la exclamación devuelve un nuevo array. Con la exclamación
      #"baraja" el mismo array
      @unusedTreasures.shuffle!
    end
    
    # Baraja el mazo d cartas de monstruos unusedMonsters.
    #void 
    def shuffleMonsters
      @unusedMonsters.shuffle!
    end
    
     
    public 
    # Devuelve el siguiente tesoro que hay en el mazo de tesoros (unusedTreasures)
    # y lo elimina de él. Si el mazo está vacío, pasa el mazo de descartes 
    # (usedTreasures) al mazo de tesoros y lo baraja, dejando el mazo de 
    # descartes vacío. 
    #Treasure 
    def nextTreasure
      if (@unusedTreasures.empty?)
        @unusedTreasures = @usedTreasures
        @usedTreasures.clear
        
        shuffleTreasures
      end
      
      tesoro = @unusedTreasures[0]
      @unusedTreasures.delete_at(0)
      @usedTreasures << tesoro
       
      return tesoro
    end
    
    #Monster 
    def nextMonster
      if (@unusedMonsters.empty?)
        @unusedMonsters = @usedMonsters.clone
        @usedMonsters.clear
        
        shuffleMonsters
      end
      
      monstruo = @unusedMonsters[0]
      @unusedMonsters.delete_at(0)
      @usedMonsters << monstruo
      
      return monstruo
    end
    
    # Introduce en el mazo de descartes de tesoros (usedTreasures) el tesoro t.
    #void 
    def giveTreasureBack(t) #t->Treasure 
      @unusedTreasures.delete(t)
      @usedTreasures << t
    end
    
    #Introduce en el mazo de dscartes de monstruos (usedMonsters) al monstruo m.
    #void 
    def giveMonsterBack(m) #m->Monster
      @unusedMonsters.delete(m)
      @usedMonsters << m
    end
    
    #void 
    def initCards
      initMonsterCardDeck
      initTreasureCardDeck
      
      initCultistCardDeck
    end
    
    private
    #void
    def shuffleCultists
      @unusedCultists.shuffle!
    end
    
    #void
    def initCultistCardDeck
      Cards.newCultists
      @unusedCultists = Cards.cultists
      shuffleCultists
    end
    
    public
    #Cultist
    def nextCultist
      cultist = @unusedCultists[0]
      @unusedCultists.delete_at(0)
      
      return cultist
    end
    
  end # Fin CardDealer
end #Fin Model