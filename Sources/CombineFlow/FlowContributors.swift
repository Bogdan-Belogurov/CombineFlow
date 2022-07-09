// CombineFlow
// Written by Bogdan Belogurov

public enum FlowContributors {

    case one(FlowContributor)
    case end(forwardToParentFlowWithStep: Step)
    case none
}
