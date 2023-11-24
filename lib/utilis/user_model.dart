class UserModel {
  String? userId;
  String? name;
  String? email;
  String? userImage;
  String? id;

  UserModel({this.userId, this.name, this.email, this.userImage, this.id});

  UserModel.fromJson(Map<String, dynamic> json, snapShotId) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    userImage = json['userImage'];
    id = snapShotId;
  }
}
