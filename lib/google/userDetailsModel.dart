


class UserDetailsModel{
  String? displayName;
  String? email;
  String? photoURL;

  UserDetailsModel({this.displayName, this.email, this.photoURL});

  UserDetailsModel.fromJson(Map<String, dynamic> json){
    displayName = json["displayName"];
    photoURL = json["photoURL"];
    email = json["email"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> mapData = new Map<String, dynamic>();

    mapData["displayName"] = this.displayName;
    mapData["photoURL"] = this.photoURL;
    mapData["email"] = this.email;
    return mapData;
  }

}