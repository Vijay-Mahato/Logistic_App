String buildGetListOfStoresQuery(double lat, double lng, String country)=> """
   query{

    listBusinessesByLatitudeAndLongitude(latitude: $lat,

       longitude: $lng, country: "$country"){

          businessName,

          contactNo,

          email,

          about,

          longitude,

          latitude

      }

}
""";