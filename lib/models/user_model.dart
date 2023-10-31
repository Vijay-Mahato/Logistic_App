class RegisterData {
  late String firstName;
  late String lastName;
  late String userName;
  late String password;
  late String phoneNumber;
  late String gender;
  late String email;
  late String dateOfBirth;

  RegisterData({required this.firstName, required this.lastName, required this.userName, required this.password,
    required this.phoneNumber, required this.gender, required this.email, required this.dateOfBirth});
}


class UserDataModel{
  late int userId;
  late String firstName;
  late String lastName;
  late String userName;
  late bool availability;
  late String contactNumber;
  late String dateOfBirth;
  late String email;
  late bool enabled;
  late String genderType;
  late String signUpProcess;
  late String? userIdImageUrl;
  late String? userLicenceNumberImageUrl;
  late String? userPersonalImageUrl;
  late AddressResponse addressResponse;

  UserDataModel(this.userId, this.firstName, this.lastName, this.userName);

  UserDataModel.fromJson(Map<String, dynamic> json){
    userId= json['userId'];
    firstName= json['firstName'];
    lastName= json['lastName'];
    userName= json['userName'];
    availability = json['availability'];
    contactNumber = json['contactNumber'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    enabled = json['enabled'];
    genderType = json['genderType'];
    signUpProcess = json['signUpProcess'];
    userIdImageUrl = json['userIdImageUrl'];
    userLicenceNumberImageUrl = json['userLicenceNumberImageUrl'];
    userPersonalImageUrl = json['userPersonalImageUrl'];
    addressResponse = AddressResponse.fromJson(json['addressResponse']);
  }
}

class AddressResponse {
  late int id;
  late String locationName;
  late String description;
  late String country;
  late String city;
  late String state;
  late String zipCode;
  late String addressLineOne;
  late String addressLineTwo;

  AddressResponse(
      this.id,
      this.locationName,
      this.description,
      this.country,
      this.city,
      this.state,
      this.zipCode,
      this.addressLineOne,
      this.addressLineTwo);

  AddressResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationName = json['locationName'];
    description = json['description'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    addressLineOne = json['addressLineOne'];
    addressLineTwo = json['addressLineTwo'];
  }
}