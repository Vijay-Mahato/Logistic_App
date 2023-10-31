

import 'package:fazeal_logistics/components/constants.dart';
import 'package:intl/intl.dart';

String buildAuthenticateUserQuery({
  required String userName,
  required String password,
}){
  final String buildAuthenticateUserQuery = """
    mutation{
        authenticateUser(
            loginRequestDTO: {
            userName: "$userName",
            password: "$password"
        }){
            id,
            userId,
            username,
            firstName,
            lastName,
            email,
            accessToken,
            refreshToken,
            tokenType,
            roles
        }
    }
""";
  return buildAuthenticateUserQuery;
}

String buildCreateUserInfoQuery({
  required String userName,
  required String firstName,
  required String lastName,
  required String gender,
  required String email,
  required String numberPhone,
  required String dateOfBirth,
  required String password,
}){
  DateTime date = DateFormat("yyyy/MM/dd").parse(dateOfBirth);
  String formattedDate = DateFormat("MMMM d, yyyy").format(date);
  final String buildCreateUserInfoQuery = """
    mutation{
    createUserInfo(signUpUserDTO: {
        firstName: "$firstName",
        lastName: "$lastName",
        username: "$userName",
        password: "$password",
        genderType: "${gender.toUpperCase()}",
        email: "$email",
        contactNumber: "$numberPhone",
        dateOfBirth: "$formattedDate"
    }){
        message,
        userId
    }
}
""";
  print(buildCreateUserInfoQuery);
  return buildCreateUserInfoQuery;
}

String buildRegisterVehicleInfoQuery({
  required int userId,
  required String type,
  required String licensePlateNumber,
  required String brand,
  required String modelName,
  required String capacity,
  required String fuelType,
  required String mileAge,
  required String year,
  required String status,
  required String drivingMethod,
  required String color,
}){
  final String buildRegisterVehicleInfoQuery = """
    mutation{
    createVehicleDetails(vehicleDetailsDTO:{
        userId: $userId,
        type: "$type",
        licensePlateNumber: "$licensePlateNumber",
        brand: "$brand",
        modelName: "$modelName",
        capacity: "$capacity",
        fuelType: "$fuelType",
        mileAge: "$mileAge",
        year: "$year",
        status: "$status",
        drivingMethod: $drivingMethod,
        color: "$color"
    }){
        message,
        userId,
        vehicleId
    }
}
""";
  return buildRegisterVehicleInfoQuery;
}

String buildUploadImageVehicleQuery({
  required int userId,
  required int vehicleId,
})=> """
   mutation{
    uploadVehicleImages(userId: $userId, vehicleId: $vehicleId){
        message,
        userId,
        vehicleId
    }
}
""";

String buildGetUserInfoQuery()=> """
   query{
    getLoggedUserDetails {
        userId,
        firstName,
        lastName,
        userName,
        availability,
        contactNumber,
        dateOfBirth,
        email,
        enabled,
        genderType,
        signUpProcess,
        userIdImageUrl,
        userLicenceNumberImageUrl,
        userPersonalImageUrl,
        addressResponse{
            id,
            locationName,
            description,
            country,
            city,
            state,
            zipCode,
            addressLineOne,
            addressLineTwo
        }
    }
}
""";