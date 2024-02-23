// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetJobsQuery: GraphQLQuery {
  public static let operationName: String = "GetJobsQuery"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetJobsQuery($limit: Int, $page: Int) { active(limit: $limit, page: $page) { __typename hasNext jobs { __typename _id description haveIApplied industry location positionTitle salaryRange { __typename max min } } page size total } }"#
    ))

  public var limit: GraphQLNullable<Int>
  public var page: GraphQLNullable<Int>

  public init(
    limit: GraphQLNullable<Int>,
    page: GraphQLNullable<Int>
  ) {
    self.limit = limit
    self.page = page
  }

  public var __variables: Variables? { [
    "limit": limit,
    "page": page
  ] }

  public struct Data: JobsAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { JobsAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("active", Active?.self, arguments: [
        "limit": .variable("limit"),
        "page": .variable("page")
      ]),
    ] }

    public var active: Active? { __data["active"] }

    /// Active
    ///
    /// Parent Type: `GetJobsResponse`
    public struct Active: JobsAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { JobsAPI.Objects.GetJobsResponse }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("hasNext", Bool?.self),
        .field("jobs", [Job?]?.self),
        .field("page", Int?.self),
        .field("size", Int?.self),
        .field("total", Int?.self),
      ] }

      public var hasNext: Bool? { __data["hasNext"] }
      public var jobs: [Job?]? { __data["jobs"] }
      public var page: Int? { __data["page"] }
      public var size: Int? { __data["size"] }
      public var total: Int? { __data["total"] }

      /// Active.Job
      ///
      /// Parent Type: `Job`
      public struct Job: JobsAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { JobsAPI.Objects.Job }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("_id", String?.self),
          .field("description", String?.self),
          .field("haveIApplied", Bool?.self),
          .field("industry", Int?.self),
          .field("location", Int?.self),
          .field("positionTitle", String?.self),
          .field("salaryRange", SalaryRange?.self),
        ] }

        public var _id: String? { __data["_id"] }
        public var description: String? { __data["description"] }
        public var haveIApplied: Bool? { __data["haveIApplied"] }
        public var industry: Int? { __data["industry"] }
        public var location: Int? { __data["location"] }
        public var positionTitle: String? { __data["positionTitle"] }
        public var salaryRange: SalaryRange? { __data["salaryRange"] }

        /// Active.Job.SalaryRange
        ///
        /// Parent Type: `SalaryRange`
        public struct SalaryRange: JobsAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { JobsAPI.Objects.SalaryRange }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("max", Int?.self),
            .field("min", Int?.self),
          ] }

          public var max: Int? { __data["max"] }
          public var min: Int? { __data["min"] }
        }
      }
    }
  }
}
