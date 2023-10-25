class Animal {
    var energy: Int
    var weight: Int
    var currentAge: Int
    var isTooOld: Bool {
        if currentAge >= maxAge {
            return true
        } else {
            return false
        }
    }
    
    let maxAge: Int
    let name: String
    
    init(energy: Int, weight: Int, currentAge: Int, maxAge: Int, name: String) {
        self.energy = energy
        self.weight = weight
        self.currentAge = currentAge
        self.maxAge = maxAge
        self.name = name
    }
    
    func sleep() {
        self.energy += 5
        self.currentAge += 1
        if isTooOld == false {
            print("\(self.name) спит")
        }
    }
    
    func eat() {
        self.energy += 3
        self.weight += 1
        tryIncrementAge()
        if self.isTooOld == false {
            print("\(self.name) ест")
        }
    }
    
    func move() -> Bool {
        self.energy -= 5
        self.weight -= 1
        tryIncrementAge()
        if self.isTooOld == false && self.energy >= 0 && self.weight >= 0 {
            print("\(self.name) передвигается")
            return true
        } else {
            return false
        }
    }
    
    func giveOffspring() -> Animal? {
        if isTooOld == false {
            var child = Animal(energy: Int.random(in: 0...50),
                               weight: Int.random(in: 1...5),
                               currentAge: 0,
                               maxAge: self.maxAge,
                               name: self.name
            )
            print("\(name) родился с весом \(weight), энергией \(energy)")
            return child
        } else {
            return nil
        }
    }
    
    private func tryIncrementAge() {
        if Bool.random() {
          currentAge += 1
        }
    }
}

class Bird: Animal {
    
    override func move() -> Bool {
        if super.move() == true {
            print("Летит")
        }
        
        return true
    }
    
    override func giveOffspring() -> Bird? {
        var animal = super.giveOffspring()
        guard let unwrappedAnimal = animal else {
            return nil
        }
        
        var birdChild = Bird(
            energy: unwrappedAnimal.energy,
            weight: unwrappedAnimal.weight,
            currentAge: unwrappedAnimal.currentAge,
            maxAge: unwrappedAnimal.maxAge,
            name: unwrappedAnimal.name)
        return birdChild
    }
}

class Fish: Animal {
    
    override func move() -> Bool {
        if super.move() == true {
            print("Плывет")
        }
        
        return true
    }
    
    override func giveOffspring() -> Fish? {
        var animal = super.giveOffspring()
        guard let unwrappedAnimal = animal else {
            return nil
        }
        
        var fishChild = Fish(
            energy: unwrappedAnimal.energy,
            weight: unwrappedAnimal.weight,
            currentAge: unwrappedAnimal.currentAge,
            maxAge: unwrappedAnimal.maxAge,
            name: unwrappedAnimal.name)
        return fishChild
    }
}

class Dog: Animal {
    
    override func move() -> Bool {
        if super.move() == true {
            print("Идет")
        }
        return true
    }
    
    override func giveOffspring() -> Dog? {
        var animal = super.giveOffspring()
        guard let unwrappedAnimal = animal else {
            return nil
        }
        
        var puppy = Dog(
            energy: unwrappedAnimal.energy,
            weight: unwrappedAnimal.weight,
            currentAge: unwrappedAnimal.currentAge,
            maxAge: unwrappedAnimal.maxAge,
            name: unwrappedAnimal.name)
        return puppy
    }
}

class Cat: Animal {
    
    override func move() -> Bool {
        if super.move() == true {
            print("Крадется")
        }
        return true
    }
    
    override func giveOffspring() -> Cat? {
        var animal = super.giveOffspring()
        guard let unwrappedAnimal = animal else {
            return nil
        }
        
        var kitten = Cat(
            energy: unwrappedAnimal.energy,
            weight: unwrappedAnimal.weight,
            currentAge: unwrappedAnimal.currentAge,
            maxAge: unwrappedAnimal.maxAge,
            name: unwrappedAnimal.name)
        return kitten
    }
}

class NatureReserve {
    var animals: [Animal]
    
    init() {
        self.animals = [
            Bird(energy: 5, weight: 2, currentAge: 1, maxAge: 3, name: "chirik"),
            Bird(energy: 5, weight: 1, currentAge: 1, maxAge: 4, name: "kesha"),
            Bird(energy: 5, weight: 1, currentAge: 0, maxAge: 2, name: "woody"),
            Bird(energy: 5, weight: 3, currentAge: 2, maxAge: 5, name: "kerry"),
            Bird(energy: 5, weight: 2, currentAge: 2, maxAge: 6, name: "kasha"),
            Fish(energy: 5, weight: 1, currentAge: 0, maxAge: 3, name: "dory"),
            Fish(energy: 5, weight: 1, currentAge: 0, maxAge: 3, name: "nemo"),
            Fish(energy: 5, weight: 1, currentAge: 1, maxAge: 4, name: "fobo"),
            Dog(energy: 5, weight: 10, currentAge: 4, maxAge: 13, name: "sharik"),
            Dog(energy: 5, weight: 11, currentAge: 5, maxAge: 12, name: "hatiko"),
            Cat(energy: 5, weight: 4, currentAge: 3, maxAge: 17, name: "casper"),
            Animal(energy: 5, weight: 4, currentAge: 11, maxAge: 23, name: "zhora"),
            Animal(energy: 5, weight: 4, currentAge: 12, maxAge: 31, name: "chelsey")
        ]
    }
    
    func reserveStart() {
        var iteration = 0
        while iteration < 3 {
            for animal in animals {
                var whatToDo = Int.random(in: 0...3)
                switch whatToDo {
                    
                case 0:
                    animal.sleep()
                    
                case 1:
                    animal.eat()
                    
                case 2:
                    animal.move()
                    
                case 3:
                    guard let unwrappedAnimal = animal.giveOffspring() else {
                        break
                    }
                    
                    animals.append(unwrappedAnimal)
                    
                default:
                    break
                }
            }
            
            iteration += 1
            animals.removeAll(where: {$0.isTooOld == true})
            if animals.isEmpty {
                print("all animals is too old")
                break
            }
        }
        print("Число животных оставшихся в заповеднике: \(animals.count)")
    }
}

var reserve = NatureReserve()

reserve.reserveStart()
