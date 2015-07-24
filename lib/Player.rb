#encoding: UTF-8

# Clase Player
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'BadConsequence.rb'
require_relative 'Treasure.rb'
require_relative 'TreasureKind.rb'
require_relative 'Prize.rb'
require_relative 'Dice.rb'
require_relative 'CombatResult.rb'

module Model
  
  class Player
    attr_reader :dead, :level, :hiddenTreasures, :visibleTreasures, :name, 
      :pendingBadConsequence
    MAXHIDDENTREASURES = 4
    LEVELVALUE = 1000.0
  
    #@dead = true
  
    def initialize(name)
      @name = name  
      @dead = true
      @level = 1 
      @pendingBadConsequence # 0,1->BadConsequence
      @hiddenTreasures = Array.new
      @visibleTreasures = Array.new
    end
    
    def self.newPlayer(p)
      @name = p.name  
      @dead = p.dead
      @level = p.level
      @pendingBadConsequence = p.pendingBadConsequence
      @hiddenTreasures = p.hiddenTreasures
      @visibleTreasures = p.visibleTreasures
    end
    
    private
    def newPlayer(p)
      @name = p.name  
      @dead = p.dead
      @level = p.level
      @pendingBadConsequence = p.pendingBadConsequence
      @hiddenTreasures = p.hiddenTreasures
      @visibleTreasures = p.visibleTreasures
    end
  
    private
    # Devuelve la vida al jugador, modificando el atributo correspondiente.
    def bringToLive
      @dead = false
    end

    # Incrementa el nivel del jugador en i niveles, teniendo en cuenta las reglas
    # del juego.
    def incrementLevels(i) #i->int
      @level += i
    end
  
    # Decrementa el nivel del jugador en i niveles, teniendo en cuenta las reglas
    # del juego.
    def decrementLevels(i) #i->int
      if ((@level-i) >= 1) 
        @level -= i
      else
        @level = 1
      end
    end
  
    # Asigna el mal rollo al jugador, dándole valor a su atributo 
    # pendingBadConsequence.
    def setPendingBadConsequence(b) #b->BadConsequence
      @pendingBadConsequence = b
    end
  
    def die
      dealer = CardDealer.instance
    
      @visibleTreasures.each do |treasure|
        dealer.giveTreasureBack(treasure)
      end
      @hiddenTreasures.each do |treasure|
        dealer.giveTreasureBack(treasure)
      end
    
      @hiddenTreasures.clear
      @visibleTreasures.clear
      @level = 1
      @dead = true
    end
  
    def discardNecklaceIfVisible 
      collar = @visibleTreasures.detect {|v| v.type == TreasureKind::NECKLACE}
      if(collar != nil)
        dealer = CardDealer.instance
        dealer.giveTreasureBack(collar)
        @visibleTreasures.delete(collar)
      end
    end
  
    # Cambia el estado de jugador a muerto si no tiene ni tesoros visibles ni 
    # ocultos, modificando el correspodiente atributo.
    def dieIfNoTreasures
      if ((@hiddenTreasures.empty?) && (@visibleTreasures.empty?))
        @dead = true
      end
    end
  
    # Devuelve true si con los niveles que compra no gana la partida
    # y false en caso contrario. 
    def canIBuyLevels(l) #l->int
      (@level+l) < 10
    end
  
    protected
    def computeGoldCoinsValue(t) #t->Treasure[]
      coins = 0
    
      t.each do |treasure|
        coins += treasure.goldCoins
      end
    
      nivel = coins/LEVELVALUE
    
      return nivel
    end
  
    public
  
    # Devuelve true si el jugador esta muerto, false en caso contrario.
    def isDead
      @dead
    end
  
    #void
    def applyPrize(p) #p->Prize
      nLevels = p.levels
      incrementLevels(nLevels)
      nPrize = p.treasures
    
      dealer = CardDealer.instance
      for i in (0...nPrize)
        treasure = dealer.nextTreasure
        @hiddenTreasures << treasure
      end
    
    end
  
    #CombatResult
    def combat(m) #m->Monster
      myLevel = getCombatLevel
      levelMonster = getOponentLevel(m)
    
      if (myLevel > levelMonster)
        prize = Prize.newPrize(m.price)
        applyPrize(prize)
      
        if (myLevel < 10)
          combatResult = CombatResult::WIN
        else
          combatResult = CombatResult::WINANDWINGAME
        end
      else
        dice = Dice.instance
        escape = dice.nextNumber
      
        if(escape < 5)
          bad = m.bc
          amIDead = bad.kills
        
          if(amIDead)
            die
            combatResult = CombatResult::LOSEANDDIE
          else
            applyBadConsequence(bad)
            
            if(shouldConvert)
              combatResult = CombatResult::LOSEANDCONVERT
            else
              combatResult = CombatResult::LOSE
            end
          end
        else # 5 ó 6
          combatResult  = CombatResult::LOSEANDESCAPE
        end
      end
    
      discardNecklaceIfVisible 
    
      return combatResult
    end
  

    def applyBadConsequence(bad) #bad->BadConsequence
      nLevels = bad.levels
      decrementLevels(nLevels)
    
      pendingBad = bad.adjustToFitTreasureLists(@visibleTreasures, @hiddenTreasures)
      setPendingBadConsequence(pendingBad)  
    end
  
    #boolean
    def canMakeTreasureVisible(t) #t->Treasure
      can = false
      
      if(t.type == TreasureKind::ONEHAND)
        if((@visibleTreasures.detect {|v| v.type == TreasureKind::BOTHHANDS}) == nil)
          if((@visibleTreasures.count {|v| v.type == TreasureKind::ONEHAND}) < 2)
            can = true
          end
        end
      elsif(t.type == TreasureKind::BOTHHANDS) 
        if((@visibleTreasures.detect {|v| v.type == TreasureKind::BOTHHANDS}) == nil)
          if((@visibleTreasures.detect {|v| v.type == TreasureKind::ONEHAND}) == nil)
            can = true
          end
        end
      else
        if((@visibleTreasures.detect {|v| v.type == t.type}) == nil)
          can = true
        end
      end
    
      return can
    end
  
    #boolean
    def makeTreasureVisible(t)
      can = canMakeTreasureVisible(t)
      
      if(can)
        @visibleTreasures << t
        @hiddenTreasures.delete(t)
      end
    
      return can
    end
  
  
    #void
    def discardVisibleTreasure(t) #t->Treasure 
      @visibleTreasures.delete(t)
    
      if(@pendingBadConsequence != nil) && (!@pendingBadConsequence.isEmpty)
        @pendingBadConsequence.substractVisibleTreasure(t)
      end
    
      dealer = CardDealer.instance
      dealer.giveTreasureBack(t)
      dieIfNoTreasures
    end
    
    # void
    def discardHiddenTreasure(t) #t->Treasure 
      @hiddenTreasures.delete(t)
    
      if(@pendingBadConsequence != nil) && (!@pendingBadConsequence.isEmpty)
        @pendingBadConsequence.substractHiddenTreasure(t)
      end
    
      dealer = CardDealer.instance
      dealer.giveTreasureBack(t)
      dieIfNoTreasures
    end
  
    #boolean 
    def buyLevels(visible, hidden) #visible, hidden -> Treasure []
      levels = computeGoldCoinsValue(visible)
      levels += computeGoldCoinsValue(hidden)
    
      canI = canIBuyLevels(levels.floor)
    
      if(canI)
        incrementLevels(levels.floor)
      
        visible.each do |v|
          discardVisibleTreasure(v)
        end
        hidden.each do |h|
          discardHiddenTreasure(h)
        end
      end
    
      return canI
    end
  
    # Devuelve el nivel de combate del jugador, que viene dado por su nivel más 
    # los bonus que le proporcionan los tesoros que tenga equipados, según las 
    # reglas del juego.
    #int
    def getCombatLevel
      combatLevel = @level

      collar = @visibleTreasures.detect {|v| v.type == TreasureKind::NECKLACE}
    
      @visibleTreasures.each do |vtreasure|
        if(collar)
          combatLevel += vtreasure.maxBonus
        else
          combatLevel += vtreasure.minBonus
        end
      end
     
      return combatLevel
    end
  
    # Devuelve true cuando el jugador no tiene ningun mal rollo que cumplir y no 
    # tiene más de 4 tesoros ocultos y false en caso contrario. 
    #boolean
    def validState
      (@hiddenTreasures.size <= 4) && ((@pendingBadConsequence == nil) || 
          (@pendingBadConsequence.isEmpty))
    end
  
    #boolean
    def initTreasures
      bringToLive
    
      dice = Dice.instance
      number = dice.nextNumber
    
      dealer = CardDealer.instance
      
      #Obtenciones en el dado (number)
      if (number == 1) # Roba 1 tesoro
        max = 1
      elsif(number < 6) # 2 tesoros
        max = 2
      else #if (number == 6) # 3 tesoros
        max = 3
      end
    
      for i in (0...max)
        treasure = dealer.nextTreasure
        @hiddenTreasures << treasure
      end
    end
  
    # Devuelve true cuando el jugador tiene algún tesoro visible y false en caso
    # contrario.
    #boolean
    def hasVisibleTreasures
      !(@visibleTreasures.empty?)
    end
  
    #Treasure [] 
    def getVisibleTreasures
      @visibleTreasures
    end
  
    #Treasure [] 
    def getHiddenTreasures
      @hiddenTreasures
    end
    
    def getName
      @name
    end
    
    def getLevel
      @level
    end
  
    #Método que devuelve el estado completo del objeto.
    def to_s
      "#{@name} \n  Nivel = #{@level} \n  Nivel de combate = #{getCombatLevel} "
    end
    
    protected
    #int
    def getOponentLevel(m) #m->Monster
      m.getBasicValue
    end
    
    #boolean
    def shouldConvert
      dice = Dice.instance
      return (dice.nextNumber == 6)
    end
    
    public
    #Modificadores
    def setVisibleTreasures(v) #v->ArrayList<Treasure>
        v.each do |t|
            @visibleTreasures << t
        end
    end
    
    def setHiddenTreasures(h) #h->ArrayList<Treasure>
        h.each do |t|
            @hiddenTreasures << t
        end
    end
  
  end # Fin Player
end #Fin Model