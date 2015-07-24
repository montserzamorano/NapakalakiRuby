#encoding: UTF-8

# Clase Cards
#
#Autora:: Mª del Mar Alguacil Camarero
#Autora:: Montse Rodríguez Zamorano

require_relative 'Monster.rb'
require_relative 'TreasureKind.rb'
require_relative 'BCSpecificTreasures.rb'
require_relative 'BCNumberOfTreasures.rb'
require_relative 'BCDeath.rb'
require_relative 'Cultist.rb'

module Model

  class Cards
    #------------------------------------------------------------#
    #---------------------CARTAS DE MONSTRUOS--------------------#
    #------------------------------------------------------------#
    @@max = 8

    #attr_reader :max

    def self.newMonsters
      @@monstruos = Array.new # Array con las cartas de los monstruos

      # 3 Byakhees de bonanza
      badConsequence = BCSpecificTreasures.new("(Pierdes tu armadura" +
          "visible y otra oculta", 0, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
      prize = Prize.new(2, 1)
      @@monstruos << Monster.new("3 Byakhees de bonanza", 8, badConsequence, prize)


      # Chibithulhu
      badConsequence = BCSpecificTreasures.new("Embobados con el lindo" +
          "primigenio te descartas de tu casco visible", 0, [TreasureKind::HELMET], Array.new)
      prize = Prize.new(1, 1)
      @@monstruos << Monster.new("Chibithulhu", 2, badConsequence, prize)


      # El sopor de Dunwich
      badConsequence = BCSpecificTreasures.new("El primordial bostezo" +
           " contaguioso.Pierdes el calzado visible\n", 0, [TreasureKind::SHOE],
         Array.new)

      prize = Prize.new(1,1)
      @@monstruos << Monster.new("El sopor de Dunwich", 2, badConsequence, prize)


      # Ángeles de la noche ibicenca
      badConsequence = BCSpecificTreasures.new("Te atrapan para" +
          " llevarte de fiesta y te dejan car en mitad del vuelo. Descarta 1 mano" +
          "visible y 1 mano oculta", 0, [TreasureKind::ONEHAND],[TreasureKind::ONEHAND])
      prize = Prize.new(4,1)
      @@monstruos << Monster.new("Ángeles de la noche ibicenca", 14, badConsequence, prize)


      # El gorrón en el umbral
      badConsequence = BCNumberOfTreasures.new("Pierdes todos tus " +
          "tesores visibles.", 1, @@max, 0)
      prize = Prize.new(3,1)
      @@monstruos << Monster.new("El gorrón en el umbral", 10, badConsequence, prize)


      # H.P. Munchcraft
      badConsequence = BCSpecificTreasures.new("Pierdes la armadura " +
          "visible.", 0, [TreasureKind::ARMOR], Array.new)
      prize = Prize.new(2,1)
      @@monstruos << Monster.new("H.P. Munchcraft", 6, badConsequence, prize)


      # Bichgooth
      badConsequence = BCSpecificTreasures.new("Sientes bichos bajo la" +
          " ropa. Descarta la armadura visible",0,[TreasureKind::ARMOR], Array.new)
      prize = Prize.new(1,1)
      @@monstruos << Monster.new("Bichgooth", 2, badConsequence, prize)


      # El rey de rosa
      badConsequence = BCNumberOfTreasures.new("Pierdes 5 niveles y" +
          " 3 tesoros visibles",5, 3, 0)
      prize = Prize.new(4,2)
      @@monstruos << Monster.new("El rey de rosa", 13, badConsequence, prize)


      # La que redacta en las tinieblas
      badConsequence = BCNumberOfTreasures.new("Toses los pulmones y"+
          " pierdes 2 niveles", 2, 0, 0)
      prize = Prize.new(1,1)
      @@monstruos << Monster.new("La que redacta en las tinieblas", 2,
        badConsequence, prize)


      # Los hondos
      badConsequence = BCDeath.new("Estos monstruos resultan bastante"+
          " superficiales y te aburren mortalmente. Estas muerto")
      prize = Prize.new(2,1)
      @@monstruos << Monster.new("Los hondos", 8 ,badConsequence,prize)

      # Semillas Cthulhu
      badConsequence = BCNumberOfTreasures.new("Pierdes 2 niveles y "+
          "2 tesoros ocultos", 2, 0, 2)
      prize = Prize.new(2,1)
      @@monstruos << Monster.new("Semillas Cthulhu", 4, badConsequence, prize)

      # Dameargo
      badConsequence = BCSpecificTreasures.new("Te intentas escaquear."+
          " Pierdes una mano visible",0,[TreasureKind::ONEHAND],Array.new)
      prize = Prize.new(2,1)
      @@monstruos << Monster.new("Dameargo", 1, badConsequence, prize)

      # Pollipólipo volante
      badConsequence = BCNumberOfTreasures.new("Da mucho asquito. " +
          "Pierdes 3 niveles\n",3, 0, 0)
      prize = Prize.new(1,1)
      @@monstruos << Monster.new("Pollipólipo volante", 3, badConsequence, prize)

      #Yskhtihyssq-Goth
      badConsequence = BCDeath.new("No le hace gracia que pronuncien"+
          " mal su nombre. Estas muerto")
      prize = Prize.new(3,1)
      @@monstruos << Monster.new("Yskhtihyssq-Goth", 12, badConsequence, prize)


      # Familia feliz
      badConsequence = BCDeath.new("La familia te atrapa. Estas muerto")
      prize = Prize.new(4,1)
      @@monstruos << Monster.new("Familia feliz", 1, badConsequence, prize)


      # Roboggoth
      badConsequence = BCSpecificTreasures.new("La quinta directiva "+
          "primaria te obliga a perder 2 niveles y un tesoro 2 manos visible", 2,
        [TreasureKind::BOTHHANDS], Array.new)
      prize = Prize.new(2, 1)
      @@monstruos << Monster.new("Roboggoth", 8, badConsequence, prize)

      # El espia
      badConsequence = BCSpecificTreasures.new("Te asusta en la noche."+
          " Pierdes un casco visible.",0,[TreasureKind::HELMET],Array.new)
      prize = Prize.new(1, 1)
      @@monstruos << Monster.new("El espia", 5, badConsequence, prize)

      # El lenguas
      badConsequence = BCNumberOfTreasures.new("Menudo susto te llevas."+
          " Pierdes 2 niveles y 5 tesoros visibles.",2,5,0)
      prize = Prize.new(1, 1)
      @@monstruos << Monster.new("El lenguas", 20, badConsequence, prize)

      # Bicéfalo
      badConsequence = BCSpecificTreasures.new("Te faltan manos para"+
          " tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.\n",
        3,[TreasureKind::ONEHAND, TreasureKind::ONEHAND, TreasureKind::BOTHHANDS],Array.new)
      prize = Prize.new(1, 1)
      @@monstruos << Monster.new("Bicéfalo", 20, badConsequence, prize)
      
      
      # CARTAS CON SECTARIOS #
     
      # El mal indecible impronunciable
      badConsequence = BCSpecificTreasures.new("Pierdes 1 mano" + 
          " visible", 0,[TreasureKind::ONEHAND],Array.new)
      prize = Prize.new(3, 1)
      @@monstruos << Monster.new("El mal indecible impronunciable", 10, 
                badConsequence, prize, -2)
              
      # Testigos oculares
      badConsequence = BCNumberOfTreasures.new("Pierdes tus " +
          "tesoros visibles. Jajaja", 0, @@max, 0)
      prize = Prize.new(2,1)
      @@monstruos << Monster.new("Testigos oculares", 6, badConsequence, 
        prize, 2)
        
      # El gran cthulhu
      badConsequence = BCDeath.new("Hoy no es tu día de suerte."+
          " Mueres")
      prize = Prize.new(2,5)
      @@monstruos << Monster.new("El gran cthulhu", 20, badConsequence, prize, 4)
      
      # Serpiente político 
      badConsequence = BCNumberOfTreasures.new("Tu gobierno " +
          "te recorta 2 niveles", 2, 0, 0)
      prize = Prize.new(2,1)
      @@monstruos << Monster.new("Serpiente político", 8, badConsequence, 
          prize, -2)
        
      # Felpuggoth
      badConsequence = BCSpecificTreasures.new("Pierdes tu casco y"+
          " tu armadura visible. Pierdes tus manos ocultas", 0, 
        [TreasureKind::HELMET, TreasureKind::ARMOR], 
        [TreasureKind::ONEHAND, TreasureKind::ONEHAND, TreasureKind::BOTHHANDS])
      prize = Prize.new(1,1)
      @@monstruos << Monster.new("Felpuggoth", 2, badConsequence, prize, 5)
      
      # Shoggoth
      badConsequence = BCNumberOfTreasures.new("Pierdes 2 niveles",
        2, 0, 0)
      prize = Prize.new(4, 2)
      @@monstruos << Monster.new("Shoggoth", 16, badConsequence, prize, -4)
      
      # Lolitagoth 
      badConsequence = BCNumberOfTreasures.new("Pintalabios negro."+
          " Pierdes 2 niveles", 2, 0, 0)
      prize = Prize.new(1, 1)
      @@monstruos << Monster.new("Lolitagooth", 2, badConsequence, prize, 3)
          
    end

    def self.monstruos
      return @@monstruos
    end

    #------------------------------------------------------------#
    #----------------------CARTAS DE TESOROS---------------------#
    #------------------------------------------------------------#
    def self.newTreasures
      @@treasures = Array.new

      @@treasures << Treasure.new("¡Sí mi amo!", 0, 4, 7, TreasureKind::HELMET)
      @@treasures << Treasure.new("Botas de investigación", 600, 3, 4,
        TreasureKind::SHOE)
      @@treasures << Treasure.new("Capucha de Cthulhu", 500, 3, 5,
        TreasureKind::HELMET)
      @@treasures << Treasure.new("A prueba de babas", 400, 2, 5,
        TreasureKind::ARMOR)
      @@treasures << Treasure.new("Botas de lluvia ácida", 800, 1, 1,
        TreasureKind::BOTHHANDS)
      @@treasures << Treasure.new("Casco minero", 400, 2, 4, TreasureKind::HELMET)
      @@treasures << Treasure.new("Ametralladora Thompson", 600, 4, 8,
        TreasureKind::BOTHHANDS)
      @@treasures << Treasure.new("Camiseta de la UGR", 100, 1, 7,
        TreasureKind::HELMET)
      @@treasures << Treasure.new("Clavo de rail ferroviario", 400, 3, 6,
        TreasureKind::ONEHAND)

      @@treasures << Treasure.new("Cuchillo de sushi arcano", 300, 2, 3,
        TreasureKind::ONEHAND)
      @@treasures << Treasure.new("Fez alópodo", 700, 3, 5, TreasureKind::HELMET)
      @@treasures << Treasure.new("Hacha prehistórica", 500, 2, 5,
        TreasureKind::ONEHAND)
      @@treasures << Treasure.new("El aparato del Pr. Tesla", 900, 4, 8,
        TreasureKind::ARMOR)
      @@treasures << Treasure.new("Gaita", 500, 4, 5, TreasureKind::BOTHHANDS)
      @@treasures << Treasure.new("Insecticida", 300, 2, 3, TreasureKind::ONEHAND)
      @@treasures << Treasure.new("Escopeta de 3 cañones", 700, 4, 6,
        TreasureKind::BOTHHANDS)
      @@treasures << Treasure.new("Garabato místico", 300, 2, 2,
        TreasureKind::ONEHAND)
      @@treasures << Treasure.new("La fuerza de Mr. T", 1000, 0, 0,
        TreasureKind::NECKLACE)

      @@treasures << Treasure.new("La rebeca metálica", 400, 2, 3,
        TreasureKind::ARMOR)
      @@treasures << Treasure.new("Mazo de los antiguos", 200, 3, 4,
        TreasureKind::ONEHAND)
      @@treasures << Treasure.new("Necroplayboycón", 300, 3, 5,
        TreasureKind::ONEHAND)
      @@treasures << Treasure.new("Lanzallamas", 800, 4, 8, TreasureKind::BOTHHANDS)
      @@treasures << Treasure.new("Necrocomicón", 100, 1, 1, TreasureKind::ONEHAND)
      @@treasures << Treasure.new("Necronomicón", 800, 5, 7,
        TreasureKind::BOTHHANDS)
      @@treasures << Treasure.new("Linterna a 2 manos", 400, 3, 6,
        TreasureKind::BOTHHANDS)
      @@treasures << Treasure.new("Necrognomicón", 200, 2, 4, TreasureKind::ONEHAND)
      @@treasures << Treasure.new("Necrotelecom", 300, 2, 3, TreasureKind::HELMET)

      @@treasures << Treasure.new("Porra preternatural", 200, 2, 3,
        TreasureKind::ONEHAND)
      @@treasures << Treasure.new("Tentáculo de pega", 200, 0, 1,
        TreasureKind::HELMET)
      @@treasures << Treasure.new("Zapato deja-amigos", 500, 0, 1,
        TreasureKind::SHOE)
      @@treasures << Treasure.new("Shogulador", 600, 1, 1, TreasureKind::BOTHHANDS)
      @@treasures << Treasure.new("Varita de atizamiento", 400, 3, 4,
        TreasureKind::ONEHAND)
    end

    def self.treasures
      return @@treasures
    end
    
    def self.newCultists
      @@cultists = Array.new
      
      @@cultists << Cultist.new("Sectario 1", 1)
      @@cultists << Cultist.new("Sectario 2", 2)
      @@cultists << Cultist.new("Sectario 3", 1)
      @@cultists << Cultist.new("Sectario 4", 2)
      @@cultists << Cultist.new("Sectario 5", 1)
      @@cultists << Cultist.new("Sectario 6", 1)
    end

    def self.cultists
      return @@cultists
    end
    #Anula el método constructor new para que no podamos usarlo tal cual
    private_class_method :new

  end # Fin Cards
end #Fin Model
