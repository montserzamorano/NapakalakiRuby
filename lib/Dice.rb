#encoding: UTF-8

# <<singleton>>
# Clase Dice
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

#require 'singleton'

module Model

  class Dice
  #  include Singleton
  
    @@instance = nil

    def initialize
    end
  
    def self.instance
      if (@@instance == nil)
        @@instance = new
      end
    
      return @@instance
    end

    # Se privatiza para que no se pueda hacer un new Dice desde otro 
    # lugar que no sea dentro de la misma clase.
    private_class_method :new

    # Genera un número aleatorio entre 1 y 6.
    # Devuelve el número aleatorio generado
    def nextNumber
      numAleatorio = rand(6)+1
      #puts "Resultado de tirar el dado: #{numAleatorio}"
      return numAleatorio
    end
  
  end # Fin Dice
end #Fin Model
