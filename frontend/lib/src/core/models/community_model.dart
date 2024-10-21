import 'package:socialearn/src/core/models/user_model.dart';

class CommunityModel {
  String creator; // Expecting a UserModel
  String name;
  int subscribers;
  List<String> moderators;
  List<String> bannedUsers;
  String avatar;
  String cover;
  String description;
  int score;
  String? createdAt;
  String id;
  int version;

  CommunityModel({
    this.creator = '',
    this.name = '',
    this.subscribers = 0,
    this.moderators = const [],
    this.bannedUsers = const [],
    this.avatar = '',
    this.cover = '',
    this.description = '',
    this.score = 0,
    this.createdAt,
    this.id = '',
    this.version = 0,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      creator: json["creator"] ?? '',
      name: json["name"] ?? '',
      subscribers: json["subscribers"] ?? 0,
      moderators: json["moderators"] == null
          ? []
          : List<String>.from(json["moderators"].map((x) => x)),
      bannedUsers: json["bannedUsers"] == null
          ? []
          : List<String>.from(json["bannedUsers"].map((x) => x)),
      avatar: json["avatar"] ?? '',
      cover: json["cover"] ?? '',
      description: json["description"] ?? '',
      score: json["score"] ?? 0,
      createdAt: json["createdAt"],
      id: json["_id"] ?? '',
      version: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "creator": creator,
        "name": name,
        "subscribers": subscribers,
        "moderators": moderators,
        "bannedUsers": bannedUsers,
        "avatar": avatar,
        "cover": cover,
        "description": description,
        "score": score,
        "createdAt": createdAt,
        "_id": id,
        "__v": version,
      };

  static CommunityModel emptyJson() {
    return CommunityModel(
      creator: '',
      name: '',
      subscribers: 0,
      moderators: [],
      bannedUsers: [],
      avatar: '',
      cover: '',
      description: '',
      score: 0,
      createdAt: null,
      id: '',
      version: 0,
    );
  }
}
