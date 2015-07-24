#encoding: UTF-8

# Clase Prize
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

module Model 
  class Prize
    #Variables de instancia de las que se genera de forma automática el consultor 
    #de estos atributos y público.
    attr_reader :treasures, :levels
  
    #Constructor de los objetos de la clase Prize.
    #Parámetros:
    #* treasures Tesoros que se ganan.
    #* levels Niveles que se ganan. Por defecto se gana 1 nivel.

    def initialize(treasures, levels=1)
      @treasures = treasures;
      @levels = levels;
    end
  
    def self.newPrize(p)
      new(p.treasures, p.levels)
    end
  
    #Método que devuelve el estado completo del objeto.
    def to_s
      "\n (prize) \n   Tesoros ganados: #{@treasures} \n   Niveles ganados: #{@levels}"
    end
    
  end # Fin Prize 
end #Fin Model