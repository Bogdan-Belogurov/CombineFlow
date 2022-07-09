// CombineFlow
// Written by Bogdan Belogurov

public enum FlowContributor {

    case contribute(Flow)
    case forwardToCurrentFlow(withStep: Step)
    case forwardToParentFlow(withStep: Step)
}
