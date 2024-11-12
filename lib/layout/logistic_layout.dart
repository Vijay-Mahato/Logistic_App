import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:fazeal_logistics/components/adaptive_widget.dart';
import 'package:fazeal_logistics/components/color.dart';
import 'package:fazeal_logistics/components/constants.dart';
import 'package:fazeal_logistics/components/widgets.dart';
import 'package:fazeal_logistics/layout/cubit/states.dart';
import 'package:fazeal_logistics/main.dart';
import 'package:fazeal_logistics/shared/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/constants_empty.dart';
import '../modules/Login/login_screen.dart';
import '../modules/layout_screen/delivery_dashboard.dart';
import '../modules/layout_screen/driving_method_Info_screen.dart';
import '../modules/layout_screen/driving_method_screen.dart';
import '../modules/layout_screen/user_setting_screen.dart';
import 'cubit/cubit.dart';

class LogisticsLayout extends StatefulWidget {
  LogisticsLayout({super.key});

  @override
  State<LogisticsLayout> createState() => _LogisticsLayoutState();
}

class _LogisticsLayoutState extends State<LogisticsLayout> {
  Position? _lastPosition;
  double _updateDistance = 2000; // Default to 1000 meters (1 km)
  List<double> _distanceOptions = [
    500,
    1000,
    2000,
    5000,
    8000,
    10000,
    20000
  ]; // in meters
  @override
  void initState() {
    super.initState();
    ps = Geolocator.getPositionStream().listen((Position position) {
      if (myMarker.isNotEmpty) {
        changeMarker(position.latitude, position.longitude);
        print("#################");
        print(position.latitude);
        print("#################");
        if (_shouldUpdate(position)) {
          updateUserPosition(position);
        }
      }
    });
    _determinePosition();
  }

  bool _shouldUpdate(Position newPosition) {
    if (_lastPosition == null) {
      _lastPosition = newPosition;
      return true;
    }

    double distance = Geolocator.distanceBetween(_lastPosition!.latitude,
        _lastPosition!.longitude, newPosition.latitude, newPosition.longitude);

    if (distance >= _updateDistance) {
      _lastPosition = newPosition;
      return true;
    }
    return false;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();
  GoogleMapController? _controller;
  double? currentLat;
  double? currentLong;
  CameraPosition? _kGooglePlex;
  Position? cl;
  Set<Marker> myMarker = {};
  StreamSubscription<Position>? ps;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    cl = await Geolocator.getCurrentPosition().then((value) {
      print(value);
      return value;
    });
    currentLat = cl!.latitude;
    currentLong = cl!.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(currentLat!, currentLong!),
      zoom: 14.4746,
    );

    addStoresMarkers();

    setState(() {});
    print("////////////////////");
  }

  void updateUserPosition(Position position) {
    setState(() {
      currentLat = position.latitude;
      currentLong = position.longitude;
      _kGooglePlex = CameraPosition(
        target: LatLng(currentLat!, currentLong!),
        zoom: 14.4746,
      );
    });
    addStoresMarkers();
    if (_controller != null) {
      _controller!.animateCamera(
          CameraUpdate.newLatLng(LatLng(currentLat!, currentLong!)));
    }
  }

  void addStoresMarkers() async {
    final cubit = LogisticsCubit.get(context);
    if (currentLat != null && currentLong != null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(currentLat!, currentLong!);

      final iconMarker =
          await getBytesFromAsset('assets/logisticAssets/store_icon.png', 120);
      await cubit.getStoresLocations(currentLat ?? 0.0, currentLong ?? 0.0,
          _updateDistance.toInt() ?? 2000);

      myMarker.add(Marker(
          markerId: MarkerId("1"),
          position: LatLng(currentLat!, currentLong!),
          infoWindow: InfoWindow(title: "Me"),
          draggable: true,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen)));

      myMarker.addAll(List.generate(
          cubit.listOfStores.length,
          (index) => Marker(
              markerId:
                  MarkerId("${cubit.listOfStores[index].contactNo}$index"),
              position: LatLng(cubit.listOfStores[index].latitude,
                  cubit.listOfStores[index].longitude),
              infoWindow:
                  InfoWindow(title: cubit.listOfStores[index].businessName),
              draggable: false,
              icon: BitmapDescriptor.fromBytes(iconMarker),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryDashboard(),
                    ));
                // builder: (context) => StoreDetailsScreen(store: cubit.listOfStores[index])));
              })));
      setState(() {});
    }
  }

  void calculateDistance() {
    var distance =
        Geolocator.distanceBetween(32.4780728, 35.860136, 32.545150, 35.851484);
    print(distance / 1000);
  }

  void changeMarker(newLat, newLong) {
    //myMarker.clear();
    myMarker.remove(Marker(markerId: MarkerId("1")));
    myMarker.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(newLat, newLong),
        infoWindow: InfoWindow(title: "Me"),
        draggable: true,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));
    _controller!.animateCamera(CameraUpdate.newLatLng(LatLng(newLat, newLong)));
    setState(() {});
  }

  void _showDistanceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text('Select Distance Range'),
                tileColor: Colors.grey[200],
              ),
              ..._distanceOptions
                  .map((distance) => ListTile(
                        title:
                            Text('${(distance / 1000).toStringAsFixed(1)} km'),
                        onTap: () {
                          setState(() {
                            _updateDistance = distance;
                          });
                          addStoresMarkers();
                          Navigator.pop(context);
                        },
                        trailing: _updateDistance == distance
                            ? Icon(Icons.check)
                            : null,
                      ))
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isMobileDevice = mediaQuery.size.shortestSide < screenSize;
    final cubit = LogisticsCubit.get(context);

    return BlocConsumer<LogisticsCubit, LogisticsStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        key: homeKey,
        appBar: AppBar(
          toolbarHeight: zero,
        ),
        drawer: Drawer(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: mediaQuery.size.width * 0.75,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(twenty),
                  left: Radius.circular(twenty))),
          child: MyApp.currentUser != null
              ? Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.all(isMobileDevice ? twenty : thirty),
                          height: mediaQuery.size.height * 0.25,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: const [
                                primaryLogisticColor,
                                secondaryLogisticColor,
                                subColorLogisticColor,
                              ],
                            ),
                          ),
                          child: SafeArea(
                            child: Row(
                              children: [
                                Container(
                                  width: isMobileDevice ? seventy : seventy,
                                  height: isMobileDevice ? seventy : seventy,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: four,
                                        color: Colors.grey[300]!,
                                      )
                                    ],
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child:
                                      MyApp.currentUser!.userPersonalImageUrl ==
                                              null
                                          ? Image.asset(
                                              'assets/logisticAssets/defultProfileImage.png',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              '$amazonImagePath/${MyApp.currentUser!.userPersonalImageUrl}',
                                              fit: BoxFit.cover,
                                            ),
                                ),
                                SizedBox(
                                  width: isMobileDevice ? ten : fourteen,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${MyApp.currentUser!.firstName} ${MyApp.currentUser!.lastName}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isMobileDevice
                                              ? eighteen
                                              : twentyFour,
                                          shadows: [
                                            BoxShadow(
                                              blurRadius: three,
                                              color: Colors.grey[300]!,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: isMobileDevice ? five : ten,
                                      ),
                                      Text(
                                        MyApp.currentUser!.userName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isMobileDevice
                                              ? fourteen
                                              : twenty,
                                          shadows: [
                                            BoxShadow(
                                              blurRadius: two,
                                              color: Colors.grey[300]!,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(fourteen),
                          child: GestureDetector(
                            onTap: () {
                              cubit.getUserData();
                              cubit.closeAllUserSettingVariable();
                              navigateTo(context, UserSettingScreen());
                            },
                            child: Image.asset(
                              'assets/logisticAssets/settings-01.png',
                              width: isMobileDevice ? thirty : thirtyFour,
                              height: isMobileDevice ? thirty : thirtyFour,
                              fit: BoxFit.cover,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: isMobileDevice ? ten : fourteen,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobileDevice ? ten : sixteen,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/logisticAssets/check-circle.png',
                                    width: isMobileDevice ? thirty : thirtyFour,
                                    height:
                                        isMobileDevice ? thirty : thirtyFour,
                                    fit: BoxFit.cover,
                                    color: primaryLogisticColor,
                                  ),
                                  SizedBox(
                                    width: isMobileDevice ? ten : fourteen,
                                  ),
                                  Expanded(
                                    child: Text(
                                      available.tr,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            isMobileDevice ? sixteen : twenty,
                                      ),
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: isMobileDevice ? one : onePointTwo,
                                    child: Switch.adaptive(
                                      value: cubit.isDriverAvailable,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      activeColor: subColorLogisticColor,
                                      onChanged: (v) {
                                        cubit.changeDriverAvailability();
                                        setState(() {});
                                        cubit.setDriverAvailability(
                                            available: cubit.isDriverAvailable);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              spacesDivider(
                                sizedBoxSize: isMobileDevice ? twelve : sixteen,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.getUserDrivingMethods();
                                  navigateTo(context, DrivingMethodScreen());
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/signUpAssets/car-02.png',
                                      width:
                                          isMobileDevice ? thirty : thirtyFour,
                                      height:
                                          isMobileDevice ? thirty : thirtyFour,
                                      fit: BoxFit.cover,
                                      color: primaryLogisticColor,
                                    ),
                                    SizedBox(
                                      width: isMobileDevice ? ten : fourteen,
                                    ),
                                    Expanded(
                                      child: Text(
                                        drivingMethod.tr,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              isMobileDevice ? sixteen : twenty,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              spacesDivider(
                                sizedBoxSize: isMobileDevice ? twelve : sixteen,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.getUserDrivingMethods();
                                  navigateTo(
                                      context, DrivingMethodInfoScreen());
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/signUpAssets/speedometer-04.png',
                                      width:
                                          isMobileDevice ? thirty : thirtyFour,
                                      height:
                                          isMobileDevice ? thirty : thirtyFour,
                                      fit: BoxFit.cover,
                                      color: primaryLogisticColor,
                                    ),
                                    SizedBox(
                                      width: isMobileDevice ? ten : fourteen,
                                    ),
                                    Expanded(
                                      child: Text(
                                        drivingMethodInfo.tr,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              isMobileDevice ? sixteen : twenty,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              spacesDivider(
                                sizedBoxSize: isMobileDevice ? twelve : sixteen,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.getUserDrivingMethods();
                                  navigateTo(context, DeliveryDashboard());
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/signUpAssets/car-02.png',
                                      width:
                                          isMobileDevice ? thirty : thirtyFour,
                                      height:
                                          isMobileDevice ? thirty : thirtyFour,
                                      fit: BoxFit.cover,
                                      color: primaryLogisticColor,
                                    ),
                                    SizedBox(
                                      width: isMobileDevice ? ten : fourteen,
                                    ),
                                    Expanded(
                                      child: Text(
                                        dashBoard.tr,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              isMobileDevice ? sixteen : twenty,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: babyGrey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobileDevice ? ten : sixteen,
                          vertical: isMobileDevice ? thirty : forty,
                        ),
                        child: InkWell(
                          onTap: () {
                            accessToken = null;
                            MyApp.currentUser = null;
                            CacheHelper.removeData(key: 'token');
                            navigatePushAndRemoveUntil(context, LoginScreen());
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/logisticAssets/log-out-04.png',
                                width: isMobileDevice ? thirty : thirtyFour,
                                height: isMobileDevice ? thirty : thirtyFour,
                                fit: BoxFit.cover,
                                color: primaryLogisticColor,
                              ),
                              SizedBox(
                                width: isMobileDevice ? ten : fourteen,
                              ),
                              Expanded(
                                child: Text(
                                  logout.tr,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobileDevice ? sixteen : twenty,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Spacer(),
                    Container(
                      color: babyGrey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobileDevice ? ten : sixteen,
                          vertical: isMobileDevice ? thirty : forty,
                        ),
                        child: InkWell(
                          onTap: () {
                            accessToken = null;
                            MyApp.currentUser = null;
                            CacheHelper.removeData(key: 'token');
                            navigatePushAndRemoveUntil(context, LoginScreen());
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/logisticAssets/log-out-04.png',
                                width: isMobileDevice ? thirty : thirtyFour,
                                height: isMobileDevice ? thirty : thirtyFour,
                                fit: BoxFit.cover,
                                color: primaryLogisticColor,
                              ),
                              SizedBox(
                                width: isMobileDevice ? ten : fourteen,
                              ),
                              Expanded(
                                child: Text(
                                  logout.tr,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobileDevice ? sixteen : twenty,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        body: Stack(
          children: [
            _kGooglePlex == null
                ? Center(child: AdaptiveIndicator(os: getOS()))
                : GoogleMap(
                    markers: myMarker,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    padding: EdgeInsets.all(twenty),
                    onTap: (latLng) {
                      print(latLng.latitude);
                      print(latLng.longitude);
                      // also we can add or remove markers from here.
                    },
                  ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: ten,
                  horizontal: twenty,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.getUserData();
                        homeKey.currentState!.openDrawer();
                      },
                      child: Card(
                        color: babyGrey,
                        elevation: four,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(
                            fifty,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            isMobileDevice ? eight : ten,
                          ),
                          child: Icon(
                            Icons.menu,
                            size: isMobileDevice ? thirty : forty,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10, // Adjust this value to position the button vertically
              right:
                  16, // Adjust this value to position the button horizontally
              child: FloatingActionButton(
                child: Icon(Icons.filter_list),
                onPressed: () {
                  _showDistanceOptions(context);
                },
                mini: true, // Makes the FAB smaller
              ),
            ),
          ],
        ),
      ),
    );
  }
}
