import "dart:io";

import "package:dio/dio.dart";
import "package:fazeal_logistics/components/api_end_point_driver_setting.dart";
import "package:fazeal_logistics/components/api_end_point_driving.dart";
import "package:fazeal_logistics/components/api_end_point_sign_in_up.dart";
import "package:fazeal_logistics/components/color.dart";
import "package:fazeal_logistics/components/widgets.dart";
import 'package:fazeal_logistics/layout/cubit/states.dart';
import "package:fazeal_logistics/main.dart";
import "package:fazeal_logistics/models/driving_method_model.dart";
import "package:fazeal_logistics/models/user_model.dart";
import "package:fazeal_logistics/shared/api.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import "../../components/api_end_point_stores.dart";
import "../../components/constants.dart";
import "../../components/constants_empty.dart";
import "../../models/enviroment.dart";
import "../../models/stores_model.dart";
import "../../shared/cache_helper.dart";

class LogisticsCubit extends Cubit<LogisticsStates> {
  LogisticsCubit() : super(LogisticsInitialState());

  static LogisticsCubit get(context) => BlocProvider.of(context);

  var graphqlEndpoint = "${Enviroment.apiUrl}/graphql";
  var graphqlEndpointBusiness = "${Enviroment.apiUrlBusiness}/graphql";
  Dio dio = Dio();
  File? imageFile;

  bool isRememberMeChecked = false;
  void changeRememberMe(){
    isRememberMeChecked = !isRememberMeChecked;
    emit(LogisticsChangeRememberMeStateState());
  }

  DateTime selectedDate = DateTime.now();

  String genderType = '';
  void changeGender(String type){
    genderType = type;
    emit(LogisticsChangeGenderTypeState());
  }

  bool isAcceptTermAndCondition = false;
  void changeAcceptTermAndCondition(){
    isAcceptTermAndCondition = !isAcceptTermAndCondition;
    emit(LogisticsChangeAcceptTermAndConditionState());
  }

  Future<void> loginUser({required String userName, required String password})async{
    try{
      emit(LogisticsLoginLoadingState());

      FormData data = FormData.fromMap({
        query: buildAuthenticateUserQuery(userName: userName, password: password),
      });

      final response = await Api.post(graphqlEndpoint, data: data);
      print(response.data);

      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"]["errorMessage"]);
      }else{
        accessToken = response.data['data']['authenticateUser']['accessToken'];
        CacheHelper.saveData(key: "token", value: accessToken);
        await getUserData();
        emit(LogisticsLoginSuccessState());
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while login user $error");
      emit(LogisticsLoginErrorState());
    }
  }

  File? cardIdImage;
  File? licenseImage;
  File? personalImage;
  File? vehicleImage;
  RegisterData? registerData;
  Future<bool> signupUser({
    required String userName,
    required String password,
    required String firstName,
    required String lastName,
    required String gender,
    required String email,
    required String numberPhone,
    required String dateOfBirth,
  })async{
    try{
      emit(LogisticsSignupLoadingState());

      FormData data = FormData.fromMap({
        query: buildCreateUserInfoQuery(
          userName: userName,
          password: password,
          dateOfBirth: dateOfBirth,
          email: email,
          firstName: firstName,
          gender: gender,
          lastName: lastName,
          numberPhone: numberPhone,
        ),
      });
      
      data.files.addAll([
        MapEntry(files, await MultipartFile.fromFile(cardIdImage!.path,
          filename: cardIdImage!.path.split('/').last)),
        MapEntry(files, await MultipartFile.fromFile(licenseImage!.path,
            filename: licenseImage!.path.split('/').last)),
        MapEntry(files, await MultipartFile.fromFile(personalImage!.path,
            filename: personalImage!.path.split('/').last)),
      ]);
      final response = await Api.post(graphqlEndpoint, data: data);

      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"]["errorMessage"]);
      }else{
        myUserId= response.data['data']['createUserInfo']['userId'];
        emit(LogisticsSignupSuccessState());
        return true;
      }

    }catch(error){
      showToastFailed(error);
      debugPrint("error while signup user $error");
      emit(LogisticsSignupErrorState());
      return false;
    }
  }

  Future<bool> registerVehicle({
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
  })async{
    try{
      emit(LogisticsSignupLoadingState());

      FormData data = FormData.fromMap({
        query: buildRegisterVehicleInfoQuery(userId: myUserId!, type: type, brand: brand, color: color, capacity: capacity, drivingMethod: drivingMethod, fuelType: fuelType, licensePlateNumber: licensePlateNumber, mileAge: mileAge, modelName: modelName, status: status, year: year),
      });

      final response = await Api.post(graphqlEndpoint, data: data);

      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"]["errorMessage"]);
      }else{
        myVehicleId= response.data["data"]["createVehicleDetails"]["vehicleId"];
        myUserId= response.data["data"]["createVehicleDetails"]["userId"];
        print("user $myUserId vehicle $myVehicleId");
        emit(LogisticsSignupSuccessState());
        return true;
      }

    }catch(error){
      showToastFailed(error);
      debugPrint("error while signup user $error");
      emit(LogisticsSignupErrorState());
      return false;
    }
  }

  void removeImageIdCard(){
    cardIdImage= null;
    emit(LogisticsUpdateImageState());
  }

  void addImageIdCard(File? file){
    cardIdImage= file;
    imageFile=null;
    emit(LogisticsUpdateImageState());
  }

  void removeLicenseImage(){
    licenseImage= null;
    emit(LogisticsUpdateImageState());
  }

  void addLicenseImage(File? file){
    licenseImage= file;
    imageFile=null;
    emit(LogisticsUpdateImageState());
  }

  void removePersonalImage(){
    personalImage= null;
    emit(LogisticsUpdateImageState());
  }

  void addPersonalImage(File? file){
    personalImage= file;
    imageFile=null;
    emit(LogisticsUpdateImageState());
  }

  void removeVehicleImage(){
    vehicleImage= null;
    emit(LogisticsUpdateImageState());
  }

  void addVehicleImage(File? file){
    vehicleImage= file;
    imageFile=null;
    emit(LogisticsUpdateImageState());
  }

  void clearRegisterDate() {
    cardIdImage = null;
    licenseImage = null;
    personalImage = null;
    registerData = null;
  }

  String drivingMethod = '';
  void changeDrivingMethod(String type){
    drivingMethod = type;
    emit(LogisticsChangeCarTypeState());
  }

  bool passwordVisible= false;
  void changeVisibilityPassword(){
    passwordVisible=!passwordVisible;
    emit(LogisticsChangeVisiblePassState());
  }

  Future<bool> uploadVehicleImage({required int vehicleId})async{
    try{
      emit(LogisticsUploadImageLoadingState());

      FormData data = FormData.fromMap({
        query: buildUploadImageVehicleQuery(userId: myUserId!, vehicleId: vehicleId),
        files: await MultipartFile.fromFile(
            vehicleImage!.path,
            filename: vehicleImage!.path.split('/').last),
      });

      final response = await Api.post(graphqlEndpoint, data: data);

      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"]["errorMessage"]);
      }else{
        vehicleImage=null;
        emit(LogisticsUploadImageSuccessState());
        return true;
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while upload vehicle image $error");
      emit(LogisticsUploadImageErrorState());
      return false;
    }
  }

  Future<void> getUserData()async{
    try{
      if(accessToken!.isNotEmpty){
        emit(LogisticsGetUserDataLoadingState());

        FormData data = FormData.fromMap({
          query: buildGetUserInfoQuery(),
        });

        final response = await Api.post(graphqlEndpoint, data: data);

        if(response.data["errors"]!=null){
          throw Exception(response.data["errors"][0]["errorMessage"]);
        }else{
          print(response.data.toString());
          MyApp.currentUser=UserDataModel.fromJson(response.data['data']['getLoggedUserDetails']);
          emit(LogisticsGetUserDataSuccessState());
        }
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while get user data $error");
      MyApp.currentUser=null;
      emit(LogisticsGetUserDataErrorState());
    }
  }

  bool isDriverAvailable=false;
  void changeDriverAvailability(){
    isDriverAvailable = !isDriverAvailable;
    emit(LogisticsChangeDriverAvailabilityState());
  }

  String divingMethodGroupValue = '';
  void changeDrivingMethodGroupValue(String newVale){
    divingMethodGroupValue = newVale;
    emit(LogisticsChangeCarTypeState());
  }

  bool isContactNumberOpen=false;
  void changeContactOpen(){
    isContactNumberOpen = !isContactNumberOpen;
    emit(LogisticsChangeFullNameEditOpenState());
  }

  bool isEmailEditOpen=false;
  void changeEmailOpen(){
    isEmailEditOpen = !isEmailEditOpen;
    emit(LogisticsChangeEmailEditOpenState());
  }

  void closeAllUserSettingVariable(){
    isContactNumberOpen=false;
    isChangePasswordOpen=false;
    isDrivingLicenseOpen = false;
    isEmailEditOpen=false;
    isCardIdOpen=false;
    emit(LogisticsCloseUserSettingVariableState());
  }

  Future<bool> selectDrivingMethod({required int vehicleId,}) async {
    try{
      emit(LogisticsSelectDrivingMethodLoadingState());

      FormData data = FormData.fromMap({
        query: buildSelectDrivingMethodQuery(vehicleId: vehicleId),
      });

      final response = await Api.post(graphqlEndpoint, data: data);

      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"]["errorMessage"]);
      }else{
        emit(LogisticsSelectDrivingMethodSuccessState());
        print(response.data.toString());
        return true;
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while Select Driving Method $error");
      emit(LogisticsSelectDrivingMethodErrorState());
      return false;
    }
  }

  List<DrivingMethodModel> listOfDrivingMethodModel = [];
  Future<bool> getUserDrivingMethods() async {
    listOfDrivingMethodModel = [];
    try{
      emit(LogisticsGetDrivingMethodLoadingState());

      FormData data = FormData.fromMap({
        query: buildGetUserDrivingMethodsQuery,
      });

      final response = await Api.post(graphqlEndpoint, data: data);

      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"][0]["errorMessage"]);
      }else{
        emit(LogisticsGetDrivingMethodSuccessState());
        print(response.data['data']['getUserDrivingMethods'].toString());
        response.data['data']['getUserDrivingMethods'].forEach((e){
          listOfDrivingMethodModel.add(DrivingMethodModel.fromJson(e));
          if(e['status'] == 'In use'){
            divingMethodGroupValue=e['drivingMethod'];
          }
          else{
            divingMethodGroupValue='';
          }
        });
        return true;
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while Set Driving Method $error");
      emit(LogisticsGetDrivingMethodErrorState());
      return false;
    }
  }

  Future<bool> setDriverAvailability({required bool available,}) async {
    try{
      emit(LogisticsSetDrivingAvailabilitySuccessState());

      FormData data = FormData.fromMap({
        query: buildSetDriverAvailabilityQuery(available: available),
      });

      final response = await Api.post(graphqlEndpoint, data: data);
      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"][0]["errorMessage"].toString());
      }else{
        emit(LogisticsSetDrivingAvailabilitySuccessState());
        print(response.data.toString());
        return true;
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while Set Driving Availability $error");
      emit(LogisticsSetDrivingAvailabilityErrorState());
      return false;
    }
  }

  List<BusinessModel> listOfStores = [];
  Future<void> getStoresLocations(double lat, double lng, String country) async {
    try{
      emit(LogisticsGetStoresLoadingState());

      FormData data = FormData.fromMap({
        query: buildGetListOfStoresQuery(lat, lng, country),
      });
      final response = await Api.post(graphqlEndpointBusiness, data: data);
      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"][0]["errorMessage"].toString());
      }else{
        response.data["data"]["listBusinessesByLatitudeAndLongitude"].forEach((business){
          listOfStores.add(BusinessModel.fromJson(business));
        });
        emit(LogisticsGetStoresSuccessState());
        print(response.data.toString());
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while update email $error");
      emit(LogisticsGetStoresErrorState());
    }
  }

  Future<void> updateEmail({
    required String updatedEmail,
  }) async {
    try{
      emit(LogisticsUpdatedEmailLoadingState());

      FormData data = FormData.fromMap({
        query: buildUpdateEmailQuery(updatedEmail: updatedEmail,),
      });
      final response = await Api.post(graphqlEndpoint, data: data);
      if(response.data["errors"]!=null){
        changeEmailOpen();
        throw Exception(response.data["errors"][0]["errorMessage"].toString());
      }else{
        MyApp.currentUser!.email=updatedEmail;
        changeEmailOpen();
        emit(LogisticsUpdatedEmailSuccessState());
        print(response.data.toString());
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while get stores locations $error");
      emit(LogisticsUpdatedEmailErrorState());
    }
  }

  Future<void> updateContactNumber({
    required String countryCode,
    required String contactNumber,
  }) async {
    try{
      emit(LogisticsUpdatedContactLoadingState());

      FormData data = FormData.fromMap({
        query: buildUpdateContactNumberQuery(countryCode: countryCode, contactNumber: contactNumber),
      });
      final response = await Api.post(graphqlEndpoint, data: data);
      if(response.data["errors"]!=null){
        changeContactOpen();
        throw Exception(response.data["errors"][0]["errorMessage"].toString());
      }else{
        MyApp.currentUser!.contactNumber=contactNumber;
        changeContactOpen();
        emit(LogisticsUpdatedContactSuccessState());
        print(response.data.toString());
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while update Contact number $error");
      emit(LogisticsUpdatedContactErrorState());
    }
  }


  bool isChangePasswordOpen=false;
  void changePasswordOpen(){
    isChangePasswordOpen = !isChangePasswordOpen;
    emit(LogisticsChangePasswordEditOpenState());
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try{
      emit(LogisticsUpdatedPasswordLoadingState());

      FormData data = FormData.fromMap({
        query: buildUpdatePasswordQuery(oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword),
      });
      final response = await Api.post(graphqlEndpoint, data: data);
      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"][0]["errorMessage"].toString());
      }else{
        showToast('change password successfully', primaryLogisticColor);
        changePasswordOpen();
        emit(LogisticsUpdatedPasswordSuccessState());
        print(response.data.toString());
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while update password $error");
      emit(LogisticsUpdatedPasswordErrorState());
    }
  }


  File? profileImage;
  void removeProfileImage(){
    profileImage= null;
    emit(LogisticsUpdateImageState());
  }

  void addProfileImage(File? file){
    profileImage= file;
    imageFile=null;
    emit(LogisticsUpdateImageState());
  }

  Future<bool> uploadProfileImageDriverSetting()async{
    try{
      emit(LogisticsUploadImageLoadingState());

      FormData data = FormData.fromMap({
        query: buildUpdateProfileImageQuery,
        files: await MultipartFile.fromFile(
            profileImage!.path,
            filename: profileImage!.path.split('/').last),
      });

      final response = await Api.post(graphqlEndpoint, data: data);

      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"]["errorMessage"]);
      }else{
        profileImage=null;
        getUserData();
        showToast('update profile image successfully', primaryLogisticColor);
        emit(LogisticsUploadImageSuccessState());
        return true;
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while upload vehicle image $error");
      emit(LogisticsUploadImageErrorState());
      return false;
    }
  }

  File? drivingLicenseImageForDrivingSetting;
  void removeDrivingLicenseImage(){
    drivingLicenseImageForDrivingSetting= null;
    emit(LogisticsUpdateImageState());
  }

  void addDrivingLicenseImage(File? file){
    drivingLicenseImageForDrivingSetting= file;
    imageFile=null;
    emit(LogisticsUpdateImageState());
  }

  Future<bool> uploadDrivingLicenseImageDriverSetting()async{
    try{
      emit(LogisticsUploadImageLoadingState());

      FormData data = FormData.fromMap({
        query: buildUpdateLicenceNumberImageQuery,
        files: await MultipartFile.fromFile(
            drivingLicenseImageForDrivingSetting!.path,
            filename: drivingLicenseImageForDrivingSetting!.path.split('/').last),
      });

      final response = await Api.post(graphqlEndpoint, data: data);

      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"]["errorMessage"]);
      }else{
        drivingLicenseImageForDrivingSetting=null;
        getUserData();
        showToast('update driving license image successfully', primaryLogisticColor);
        emit(LogisticsUploadImageSuccessState());
        return true;
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while upload vehicle image $error");
      emit(LogisticsUploadImageErrorState());
      return false;
    }
  }

  bool isDrivingLicenseOpen=false;
  void changeDrivingLicenseOpen(){
    isDrivingLicenseOpen = !isDrivingLicenseOpen;
    emit(LogisticsUpdatedDrivingLicenseState());
  }

  File? cardIdForDriverSettingImage;
  void removeCardIdForDriverSettingImage(){
    cardIdImage= null;
    emit(LogisticsUpdateImageState());
  }

  void addCardIdForDriverSettingImage(File? file){
    cardIdForDriverSettingImage= file;
    imageFile=null;
    emit(LogisticsUpdateImageState());
  }

  Future<bool> uploadCardIdImageDriverSetting()async{
    try{
      emit(LogisticsUploadImageLoadingState());

      FormData data = FormData.fromMap({
        query: buildUpdateCardIdImageQuery,
        files: await MultipartFile.fromFile(
            cardIdForDriverSettingImage!.path,
            filename: cardIdForDriverSettingImage!.path.split('/').last),
      });

      final response = await Api.post(graphqlEndpoint, data: data);

      if(response.data["errors"]!=null){
        throw Exception(response.data["errors"]["errorMessage"]);
      }else{
        cardIdForDriverSettingImage=null;
        getUserData();
        showToast('update Card Id image successfully', primaryLogisticColor);
        emit(LogisticsUploadImageSuccessState());
        return true;
      }

    }catch(error){
      showToastFailed(error.toString());
      debugPrint("error while upload vehicle image $error");
      emit(LogisticsUploadImageErrorState());
      return false;
    }
  }

  bool isCardIdOpen=false;
  void changeCardIdOpen(){
    isCardIdOpen = !isCardIdOpen;
    emit(LogisticsUpdatedDrivingLicenseState());
  }

}
