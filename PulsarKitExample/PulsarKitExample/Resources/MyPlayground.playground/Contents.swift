import UIKit

protocol Animal: class {
    static var roar: Bool { get }
}

extension Animal {
    static var roar: Bool { return false }
}

extension Leopard: Animal { }

class Leopard {
    static var roard: Bool = true
}

print(Leopard.roard)

func test<A: Leopard>(animal: A) {
    print(type(of: animal.self).roar)
}

test(animal: Leopard())
