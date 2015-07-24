#encoding: UTF-8

# <<interface>>
# Clase Card
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

module Model
  module Card
    def getBasicValue
      raise NotImplementedError.new
    end
    
    def getSpecialValue
      raise NorImplementedError.new
    end
  end
end
