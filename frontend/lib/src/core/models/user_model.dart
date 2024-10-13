class UserModel {
  String username;
  String email;
  String about;
  String role;
  String password;
  List<String> subscribedCommunities;
  int karma;
  String? createdAt; // Make createdAt nullable
  List<String> upvotedPosts;
  List<String> downvotedPosts;
  List<String> upvotedComments;
  List<String> downvotedComments;
  String id;
  int version;

  UserModel({
    this.username = '',
    this.email = '',
    this.about = '',
    this.role = '',
    this.password = '',
    this.subscribedCommunities = const [],
    this.karma = 0,
    this.createdAt, // Nullable field
    this.upvotedPosts = const [],
    this.downvotedPosts = const [],
    this.upvotedComments = const [],
    this.downvotedComments = const [],
    this.id = '',
    this.version = 0,
  });

  // Factory method to create a User from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json["user"]["username"] ?? "",
      email: json["user"]["email"] ?? "",
      about: json["user"]["about"] ?? "",
      role: json["user"]["role"] ?? "",
      password: json["user"]["password"] ?? "",
      subscribedCommunities:
          List<String>.from(json["user"]["subscribedCommunities"] ?? []),
      karma: json["user"]["karma"] ?? 0,
      createdAt: json["user"]
          ["createdAt"], // No need for ?? '' because it's nullable
      upvotedPosts: List<String>.from(json["user"]["upvotedPosts"] ?? []),
      downvotedPosts: List<String>.from(json["user"]["downvotedPosts"] ?? []),
      upvotedComments: List<String>.from(json["user"]["upvotedComments"] ?? []),
      downvotedComments:
          List<String>.from(json["user"]["downvotedComments"] ?? []),
      id: json["user"]["_id"] ?? "",
      version: json["user"]["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "about": about,
        "role": role,
        "password": password,
        "subscribedCommunities": subscribedCommunities,
        "karma": karma,
        "createdAt": createdAt, // Nullable value in JSON serialization
        "upvotedPosts": upvotedPosts,
        "downvotedPosts": downvotedPosts,
        "upvotedComments": upvotedComments,
        "downvotedComments": downvotedComments,
        "_id": id,
        "__v": version,
      };
}
