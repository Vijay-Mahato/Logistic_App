
String buildSetDriverAvailabilityQuery({
  required bool available,
}){
  final String buildSetDriverAvailabilityQuery = """
    mutation{
    setDriverAvailability(available: $available){
        message
      }
    }
""";
  return buildSetDriverAvailabilityQuery;
}

const String buildGetUserDrivingMethodsQuery = """
      query{
          getUserDrivingMethods {
              id,
              brand,
              capacity,
              color,
              drivingMethod,
              fuelType,
              licensePlateNumber,
              mileAge,
              modelName,
              status,
              type,
              userId,
              year,
              vehicleImages,
          }
  }""";

String buildSelectDrivingMethodQuery({
  required int vehicleId,
}){
  final String buildSelectDrivingMethodQuery = """
    mutation{
    selectDrivingMethod(vehicleId: $vehicleId) {
        message
    }
}
""";
  return buildSelectDrivingMethodQuery;
}
