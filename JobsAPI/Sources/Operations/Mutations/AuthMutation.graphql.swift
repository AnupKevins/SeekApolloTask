// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AuthMutation: GraphQLMutation {
  public static let operationName: String = "Auth"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation Auth($username: String!, $password: String!) { auth(username: $username, password: $password) }"#
    ))

  public var username: String
  public var password: String

  public init(
    username: String,
    password: String
  ) {
    self.username = username
    self.password = password
  }

  public var __variables: Variables? { [
    "username": username,
    "password": password
  ] }

  public struct Data: JobsAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { JobsAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("auth", String?.self, arguments: [
        "username": .variable("username"),
        "password": .variable("password")
      ]),
    ] }

    public var auth: String? { __data["auth"] }
  }
}
