String buildGetListOfStoresQuery(double lat, double lng, int distance)=> """
   query{

    listBusinessesByLatitudeAndLongitude(latitude: $lat,

       longitude: $lng, distance: $distance){

          businessName,

          contactNo,

          email,

          about,

          longitude,

          latitude

      }

}
""";