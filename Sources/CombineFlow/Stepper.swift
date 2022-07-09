// CombineFlow
// Written by Bogdan Belogurov

import Combine

public protocol Stepper {

    var steps: PassthroughSubject<Step, Never> { get }

    var initialStep: Step { get }
}
