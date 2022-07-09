// CombineFlow
// Written by Bogdan Belogurov

import Combine
import Foundation

public final class FlowCoordinator {

    private let id = UUID().uuidString
    private var childCoordinators = [String: FlowCoordinator]()
    private weak var parentCoordinator: FlowCoordinator?
    private let steps = PassthroughSubject<Step, Never>()
    private var bag = Set<AnyCancellable>()

    public init() {}

    public final func coordinate(flow: Flow) {
        Just(flow.stepper.initialStep)
            .append(
                Publishers
                    .Merge(flow.stepper.steps, steps)
            )
            .receive(on: RunLoop.main)
            .map { flow.navigate(to: $0) }
            .sink { [weak self] contributors in
                switch contributors {
                case .none:
                    return
                case .one(let contributor):
                    switch contributor {
                    case .contribute(let flow):
                        let coordinator = FlowCoordinator()
                        coordinator.parentCoordinator = self
                        self?.childCoordinators[coordinator.id] = coordinator
                        coordinator.coordinate(flow: flow)

                    case .forwardToCurrentFlow(let step):
                        self?.steps.send(step)
                        return
                    case .forwardToParentFlow(let step):
                        self?.parentCoordinator?.steps.send(step)
                        return
                    }
                case .end(let step):
                    self?.parentCoordinator?.steps.send(step)
                    self?.childCoordinators.removeAll()
                    self?.parentCoordinator?
                        .childCoordinators
                        .removeValue(forKey: self?.id ?? String())
                }
            }
            .store(in: &bag)
    }
}
