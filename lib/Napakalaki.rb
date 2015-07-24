#encoding: UTF-8

# <<singleton>>
# Clase Napakalaki
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano.
 
require_relative 'CardDealer.rb'
require_relative 'Player.rb'
require_relative 'Monster.rb'
require_relative 'Treasure.rb'
require_relative 'TreasureKind.rb'
require_relative 'Cards.rb'

module Model
  
  class Napakalaki
    MAX = 3
  
    #attr_reader :currentPlayer, :currentMonster
    @@instance = nil

    def initialize
      @currentPlayer #0,1->Player
      @players = Array.new
      @currentMonster #0,1
      @currentPlayerIndex = nil #indice del jugador que posee el turno.
    end
  
    def self.instance
      if (@@instance == nil)
        @@instance = new
      end
    
      return @@instance
    end
  
    # Se privatiza para que no se pueda hacer un new Napakalaki desde otro 
    # lugar que no sea dentro de la misma clase.
    private_class_method :new
  
    private
    # Inicializa el array de jugadores que contiene Napakalaki, creando tantos
    # jugadores como elementos haya en names, que es el array de String que 
    # contiene el nombre de los jugadores.
    # Precondición: El tamaño del array no puede ser mayor que el número máximo 
    # de jugadores.
    def initPlayers(names) 
      if(names.size > MAX)
        puts "Demasiados jugadores"
      else
        names.each do |name|
          @players << Player.new(name)
        end
      end
    end
  
    # Decide que jugador es el siguiente en jugar. Se pueden dar dos posibilidades
    # para calcular el índice que ocupa dicho jugador en la lista de jugadores, 
    # que se trate del primer turno o no. Para el primer turno se calculará la 
    # posición del primer jugador utilizando un número aleatorio.
    # Devuelve: Player 
    def nextPlayer
      if (@currentPlayerIndex == nil) # Primer turno
      @currentPlayerIndex = rand(@players.size)
      else
        if(@currentPlayerIndex == @players.size-1) # Último jugador de la ronda
          @currentPlayerIndex = 0
        else
         @currentPlayerIndex += 1
        end
      end
   
      #if(@players != nil)
        @currentPlayer = @players[@currentPlayerIndex]
      #else
      #  puts "vaciiio"
      #end
      return @currentPlayer
    end
  
    public 
    #CombatResult 
    def combat
      combatResult = @currentPlayer.combat(@currentMonster)
      dealer = CardDealer.instance
      dealer.giveMonsterBack(@currentMonster)
      
      if(combatResult == CombatResult::LOSEANDCONVERT)
        c = dealer.nextCultist
        @currentPlayer = CultistPlayer.new(@currentPlayer, c)
        @players[@currentPlayerIndex] = @currentPlayer
      end
    
      return combatResult
    end
    
    #void 
    def discardVisibleTreasure(t) #t->Treasure
      @currentPlayer.discardVisibleTreasure(t)
    end
    
    #void 
    def discardHiddenTreasure(t) #t->Treasure
      @currentPlayer.discardHiddenTreasure(t)
    end
  
    #boolean 
    def makeTreasureVisible(t) #t->Treasure 
      @currentPlayer.makeTreasureVisible(t)
    end
  
    #boolean
    def buyLevels(visible, hidden) #visible, hidden->Treasure[]
      @currentPlayer.buyLevels(visible, hidden)
    end
  
    #boolean 
    def nextTurn
      stateOK = nextTurnAllowed
    
      if(stateOK)
        dealer = CardDealer.instance
        @currentMonster = dealer.nextMonster
        @currentPlayer = nextPlayer
      
        dead = @currentPlayer.isDead
      
        if(dead)
          @currentPlayer.initTreasures
        end
      end
    
    return stateOK
  end
  
    #void 
    def initGame(players) #players->String [] 
      dealer = CardDealer.instance
      dealer.initCards
      initPlayers(players)
      nextTurn
    end

    # Player 
    def getCurrentPlayer
      @currentPlayer
    end
    # Monster
    def getCurrentMonster
      @currentMonster
    end

    #boolean 
    def canMakeTreasureVisible(t) #t->Treasure 
      @currentPlayer.canMakeTreasureVisible(t)
    end
  
    #Treasure [] 
    def getVisibleTreasures
      @currentPlayer.visibleTreasures
    end
  
    #Treasure [] 
    def getHiddenTreasures
      @currentPlayer.hiddenTreasures
    end
  
    #boolean 
    def nextTurnAllowed
      if(@currentPlayer == nil)
        return true
      else
        return @currentPlayer.validState
      end
    end
  
    #boolean 
    def endOfGame(result) #result->CombatResult 
      result == (CombatResult::WINANDWINGAME)
    end
    
  end # Fin Napakalaki
end #Fin Model