class UserProfileModel {
  String id;
  String name;
  String email;
  String profilePic;
  String contactNo;

  UserProfileModel(
      {this.id, this.name, this.email, this.profilePic, this.contactNo});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    email = json['Email'];
    profilePic = json['Profile_Pic'];
    contactNo = json['contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Profile_Pic'] = this.profilePic;
    data['contact_no'] = this.contactNo;
    return data;
  }
}