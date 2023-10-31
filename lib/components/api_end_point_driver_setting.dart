
String buildUpdateEmailQuery({
  required String updatedEmail,
}) {
  final String buildUpdateEmailQuery = '''
    mutation{
      updateEmail(email: "$updatedEmail"){
          message
      }
  }
''';
  return buildUpdateEmailQuery;
}

String buildUpdateContactNumberQuery({
  required String countryCode,
  required String contactNumber,
}) {
  final String buildUpdateContactNumberQuery = '''
    mutation{
    updateContactNumber(updateContactNumberDTO:{
        countryCode : "$countryCode"
        contactNumber: "$contactNumber"
    }){
        message
    }
}
''';
  return buildUpdateContactNumberQuery;
}

String buildUpdatePasswordQuery({
  required String oldPassword,
  required String newPassword,
  required String confirmPassword,
}) {
  final String buildUpdatePasswordQuery = '''
   mutation{
    updatePassword(updatePasswordDTO:{
        oldPassword:"$oldPassword"
        newPassword: "$newPassword"
        confirmPassword: "$confirmPassword"
    }){
        message
    }
}
''';
  return buildUpdatePasswordQuery;
}


 const String buildUpdateProfileImageQuery ="""
  mutation{
    updateProfileImage {
        message
    }
}""";

 const String buildUpdateLicenceNumberImageQuery ="""
 mutation{
    updateLicenceNumberImage{
        message
    }
}""";

 const String buildUpdateCardIdImageQuery ="""
 mutation{
    updateIdImage{
        message
    }
}""";
