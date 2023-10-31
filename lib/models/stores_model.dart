class BusinessModel {
  late String businessName;
  late String contactNo;
  late String email;
  late String? about;
  late double longitude;
  late double latitude;

  BusinessModel.fromJson(Map<String, dynamic> json) {
      businessName= json['businessName']??"";
      contactNo= json['contactNo']??"";
      email= json['email']??"";
      about= json['about'];
      longitude= json['longitude'].toDouble();
      latitude= json['latitude'].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'businessName': businessName,
      'contactNo': contactNo,
      'email': email,
      'about': about,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
