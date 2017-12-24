import Foundation

extension Bool {
    
    public var asTestResult: String {
        return self ? "passed" : "failed"
    }
}
