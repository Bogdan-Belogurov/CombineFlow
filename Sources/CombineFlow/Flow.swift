// CombineFlow
// Written by Bogdan Belogurov

#if canImport(UIKit)

import UIKit

public protocol Flow {

    var root: UIViewController { get }
    var stepper: Stepper { get }
    func navigate(to step: Step) -> FlowContributors
}

#endif
