import 'package:socialearn/src/core/models/community_model.dart';

class UserModel {
  String username;
  String email;
  String about;
  String role;
  String password;
  List<CommunityModel> subscribedCommunities;
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
  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     username: json["user"]["username"] ?? "",
  //     email: json["user"]["email"] ?? "",
  //     about: json["user"]["about"] ?? "",
  //     role: json["user"]["role"] ?? "",
  //     password: json["user"]["password"] ?? "",
  //     subscribedCommunities:
  //         List<String>.from(json["user"]["subscribedCommunities"] ?? []),
  //     karma: json["user"]["karma"] ?? 0,
  //     createdAt: json["user"]["createdAt"],
  //     upvotedPosts: List<String>.from(json["user"]["upvotedPosts"] ?? []),
  //     downvotedPosts: List<String>.from(json["user"]["downvotedPosts"] ?? []),
  //     upvotedComments: List<String>.from(json["user"]["upvotedComments"] ?? []),
  //     downvotedComments:
  //         List<String>.from(json["user"]["downvotedComments"] ?? []),
  //     id: json["user"]["_id"] ?? "",
  //     version: json["user"]["__v"] ?? 0,
  //   );
  // }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      about: json["about"] ?? "",
      role: json["role"] ?? "",
      password: json["password"] ?? "",
      subscribedCommunities: (json["subscribedCommunities"] as List<dynamic>?)
              ?.map((community) => CommunityModel.fromJson(community))
              .toList() ??
          [],
      karma: json["karma"] ?? 0,
      createdAt: json["createdAt"],
      upvotedPosts: List<String>.from(json["upvotedPosts"] ?? []),
      downvotedPosts: List<String>.from(json["downvotedPosts"] ?? []),
      upvotedComments: List<String>.from(json["upvotedComments"] ?? []),
      downvotedComments: List<String>.from(json["downvotedComments"] ?? []),
      id: json["_id"] ?? "",
      version: json["__v"] ?? 0,
    );
  }

  // Convert the UserModel object to a JSON Map
  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "about": about,
        "role": role,
        "password": password,
        "subscribedCommunities": subscribedCommunities,
        "karma": karma,
        "createdAt": createdAt,
        "upvotedPosts": upvotedPosts,
        "downvotedPosts": downvotedPosts,
        "upvotedComments": upvotedComments,
        "downvotedComments": downvotedComments,
        "_id": id,
        "__v": version,
      };

  // Static method to return an empty UserModel
  static UserModel emptyJson() {
    return UserModel(
      username: '',
      email: '',
      about: '',
      role: '',
      password: '',
      subscribedCommunities: [],
      karma: 0,
      createdAt: null,
      upvotedPosts: [],
      downvotedPosts: [],
      upvotedComments: [],
      downvotedComments: [],
      id: '',
      version: 0,
    );
  }
}
