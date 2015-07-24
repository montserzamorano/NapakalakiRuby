#encoding: UTF-8

# Clase CultistPlayer
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'Player.rb'

module Model
  
  class CultistPlayer < Player
    @@totalCultistPlayers = 0
    
    def initialize(p, c) #p->player, c->Cultist
      #super(p)
      newPlayer(p)
      @myCultistCard = c
      @@totalCultistPlayers += 1
    end
    
    #int
    def getCombatLevel
      super + @myCultistCard.getSpecialValue
    end
    
    #int
    def self.getTotalCultistPlayers
      @@totalCultistPlayers
    end
    
    #Método que devuelve el estado completo del objeto.
    def to_s
      "#{getName} (sectario) \n  Nivel = #{getLevel} \n  Nivel de combate = #{getCombatLevel} \n"
    end
    
    protected
    #boolean
    def shouldConvert
      false
    end
    
    #int
    def getOponentLevel(m) # m->Monster
      m.getSpecialValue
    end
    
    #float
    def computeGoldCoinsValue(t) # t->Treasure[]
      super*2
    end
    
  end
end
