#encoding: UTF-8

#
#Autora:: Mª del Mar Alguacil Camarero

require_relative 'BCSpecificTreasures.rb'
require_relative 'BCNumberOfTreasures.rb'
require_relative 'BCDeath.rb'
require_relative 'Treasure.rb'
require_relative 'Prize.rb'
require_relative 'Monster.rb'
require_relative 'Cultist.rb'
require_relative 'Player.rb'
require_relative 'CultistPlayer.rb'
require_relative 'TreasureKind.rb'

module Model
  
  class Prueba
    def self.imprimirArray(treasures)
      treasures.each do |t|
        puts t
      end
    end
    
    def self.main
      monstruos = Array.new
      
      bc1 = BCSpecificTreasures.new("Pierdes 1 mano visible", 0, 
        [TreasureKind::ONEHAND], Array.new)
      
      prize = Prize.new(3)
      
      monstruos << Monster.new("El mal indecible impronunciable", 10, bc1, prize, -2)
      
      bc = BCNumberOfTreasures.new("Pierdes todas tus tesoros visibles", 1, 8, 0)
        
      price = Prize.new(4,2)
      
      monstruos << Monster.new("Wiiii", 3, bc, price)
      
#      monstruos.each do |m|
#        puts m
#      end
#      
      cultists = Array.new
      
      cultists << Cultist.new("Sectario 1", 2)
      cultists << c=Cultist.new("Sectario 2", 3)

#      puts "\nSectarios:\n"
#      cultists.each do |c|
#        puts c
#      end

      p = Player.new("j1")
      q = Player.newPlayer(p)
      
      treasures = Array.new
      
      treasures << x=Treasure.new("Tesoro 1", 0, 1, 2, TreasureKind::HELMET)
      treasures << w=Treasure.new("Tesoro 2", 2, 3 ,4, TreasureKind::ONEHAND)
      
      p.setHiddenTreasures(treasures)
      #treasures.delete(w)
      #p.setVisibleTreasures(treasures)
      
      culp = CultistPlayer.new(p, c)
      
      puts culp
      
      puts "\nTesoros ocultos:"
      imprimirArray(culp.getHiddenTreasures)
      
      puts "\nTesoros visibles:"
      imprimirArray(culp.getVisibleTreasures)
      
      puts "\n"
      
#      puts "-----------------------------------------"
#      culp.makeTreasureVisible(x)
#      
#      puts "\nTesoros ocultos:"
#      imprimirArray(culp.getHiddenTreasures)
#      
#      puts "\nTesoros visibles:"
#      imprimirArray(culp.getVisibleTreasures)
#      
##      puts bc
##      
##      bc = bc.adjustToFitTreasureLists(culp.getVisibleTreasures, culp.getHiddenTreasures)
##      
##      puts bc
##      
##      culp.applyBadConsequence(bc)
##      
##      puts "\nVALID STATE: #{culp.validState} \n"
##      
##      culp.discardVisibleTreasure(x)
##      
##      puts "\nVALID STATE: #{culp.validState} \n"

      puts "-----------------------------------------"
      culp.makeTreasureVisible(w)
      
      puts "\nTesoros ocultos:"
      imprimirArray(culp.getHiddenTreasures)
      
      puts "\nTesoros visibles:"
      imprimirArray(culp.getVisibleTreasures)
      
      puts bc
      
      bc1 = bc1.adjustToFitTreasureLists(culp.getVisibleTreasures, culp.getHiddenTreasures)
      
      puts bc1
      
      culp.applyBadConsequence(bc1)
      
      puts "\nVALID STATE: #{culp.validState} \n"
      
      culp.discardVisibleTreasure(w)
      
      puts "\nTesoros visibles:"
      imprimirArray(culp.getVisibleTreasures)
      
      puts "\nVALID STATE: #{culp.validState} \n"
      
    end
  end
  
end

if $0 == __FILE__
  Model::Prueba.main()
end
