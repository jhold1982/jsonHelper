import Cocoa

// Day 11 - access control, static properties, and methods, and checkpoint 8

// Structs part 2

// MARK: SECTION 1. How to limit access to internal data using access control

struct BankAccount {
	private var funds = 0
	mutating func deposit(amount: Int) {
		funds += amount
	}
	mutating func withdraw(amount: Int) -> Bool {
		if funds > amount {
			funds -= amount
			return true
		} else {
			return false
		}
	}
}


// private - dont let anything outside the struct use this

// fileprivate - dont let anything outside the current file use this

// public - let anyone, anywhere use this

// private(set) - swift stops you from making mistakes


// MARK: SECTION 2. Static properties and methods


struct School {
	// "static" means var and func belong to struct
	static var studentCount = 0
	static func add(student: String) {
		print("\(student) joined the school.")
		studentCount += 1
	}
}

School.add(student: "Taylor Swift")
print(School.studentCount)


struct AppData {
	static let version = "1.3 beta 2"
	static let saveFilename = "settings.json"
	static let homeURL = "https://www.hackingwithswift.com"
}

struct Employee {
	let username: String
	let password: String
	
	static let example = Employee(username: "cdederighi", password: "h4irF0rce0ne!")
}



// MARK: SECTION 3. Summary: Structs

// you can create your own structs by writing struct, giving it a name, then placing the struct's code inside braces

// structs can have variables and constants (properties) and functions (methods)

// if a method tries to modify properties of it's struct, you must mark it as mutating

// you can store properties in memory, or create computerd properties that calculate a value every time they are accessed

// we can attach didSet and willSet property observers to properties inside a struct, which is helpful when we need to be sure that some code is always executed when the property changes

// initializers are like specialized functions, Swift generates one for all structs using their property names

// you can create your own custom initialiers if you want, but you must always make sure all properties in your sturct have a value by the time the initializer finishes and before you call any other methods

// we can use access to mark any properties and methods as being available or unavailable externally as needed

// its possible to attach a property or methods directly to a struct, so you can use them without creating an instance of the struct





// MARK: SECTION 4. Checkpoint 6

// make a new struct to store info about a car

// info about its model, number of seats, current gear

// add a method to change gears up and down

// dont allow invalid gears - 1...10 is fair


struct MyCar {
	// model wont change, make that a constant
	let model: String
	// number of seats wont change, make that a constant
	let seats: Int
	// current gear will change, make that a variable
	let maximumGear: Int
	private(set) var gear = 1
	
	init(model: String, seats: Int, maximumGear: Int) {
		self.model = model
		self.seats = seats
		self.maximumGear = maximumGear
	}
	
	mutating func changeGear(difference: Int) {
		gear = gear + difference
		if gear < 1 {
			gear = 1
		} else if gear > maximumGear {
			gear = maximumGear
		}
	}
}

var car = MyCar(model: "2021 VW GTI SE", seats: 4, maximumGear: 6)
car.changeGear(difference: 1)
print(car.gear)
car.changeGear(difference: 5)
print(car.gear)
car.changeGear(difference: -7)
print(car.gear)


