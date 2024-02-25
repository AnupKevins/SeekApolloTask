import Apollo
import Foundation
import JobsAPI

protocol Requestable {
    var baseUrl: URL { get }
}

protocol NetworkServiceProtocol {
    
    func setGraphQLURL(_ url: URL)
    
    func fetchDataWithGraphQLQuery<Query: GraphQLQuery>(
        query: Query,
        completion: @escaping (Result<Query.Data?, Error>) -> Void
    )
    
    func performMutationWithGraphQLQuery<Mutation: GraphQLMutation>(
        mutation: Mutation,
        completion: @escaping (Result<Mutation.Data?, Error>) -> Void
    )
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    private(set) var apollo: ApolloClient?
    
    private init() {
        let baseUrl = URL(string: AppConstants.baseUrls.appBaseUrl)!
        self.apollo = ApolloClient(url: baseUrl)
    }
    
    func setGraphQLURL(_ url: URL) {
        apollo = ApolloClient(url: url)
    }
    
    func fetchDataWithGraphQLQuery<Query: GraphQLQuery>(
        query: Query,
        completion: @escaping (Result<Query.Data?, Error>) -> Void
    ) {
        self.apollo?.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                
                DispatchQueue.main.async {
                    completion(.success(graphQLResult.data))
                }
                
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func performMutationWithGraphQLQuery<Mutation: GraphQLMutation>(
        mutation: Mutation,
        completion: @escaping (Result<Mutation.Data?, Error>) -> Void
    ) {
        self.apollo?.perform(mutation: mutation) { result in
            switch result {
            case .success(let graphQLResult):
                
                DispatchQueue.main.async {
                    completion(.success(graphQLResult.data))
                }
                
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
}

enum AppError: LocalizedError {
    case dataError(description: String)
    
    var localizedDescription: String {
        switch self {
        case .dataError(description: let desc):
            return desc
        }
    }
}
