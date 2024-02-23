import Apollo
import Foundation

protocol Requestable {
   
    
    var endpoint: String { get }
    var parameters: [String: Any] { get }
    var headers: [String: String]? { get }
    var baseUrl: URL { get }
}

enum AppError: LocalizedError {
    case unknownError
    case networkError(status: Int, description: String)
    case dataError(description: String)

    var localizedDescription: String {
        switch self {
        case .unknownError:
            return "Unknown Error has Occurred"
        case .networkError(status: let status, description: let desc):
            return "\(status): \(desc)"
        case .dataError(description: let desc):
            return desc
        }
    }
}

final class NetworkService {
    
    static let shared = NetworkService()
    
    private(set) var apollo = ApolloClient(url: URL(string: "http://localhost:3002/")!)
    
    private init() { }
}
