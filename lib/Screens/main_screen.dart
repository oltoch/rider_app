import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/DataHandler/app_data.dart';
import 'package:rider_app/DataHandler/direction_details_data.dart';
import 'package:rider_app/Screens/ride_request_screen.dart';
import 'package:rider_app/Services/geocodingModel.dart';
import 'package:rider_app/Services/location_class.dart';
import 'package:rider_app/Widgets/bottom_sheet_widget.dart';
import 'package:rider_app/Widgets/navigation_drawer_widget.dart';

class MainScreen extends StatefulWidget {
  static const String id = "mainScreenId";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  LatLng _kGoogleLatLng = LatLng(37.42796133580664, -122.085749655962);
  LatLng _kUserLatLng = GetLocation.latLng;
  static final _kGoogleCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final _kUserCameraPosition = CameraPosition(
    target: GetLocation.latLng,
    zoom: 14,
  );
  final Completer<GoogleMapController> _googleMapController = Completer();

  GoogleMapController? newGoogleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      drawer: NavigationDrawerWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.place,
          size: 28,
        ),
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                      child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: BottomSheetWidget(),
                  ))).whenComplete(() {
            if (Provider.of<AppData>(context, listen: false)
                    .directionDetailsData
                    .encodedPoints !=
                '') {
              setState(() {
                GeocodingModel.drawPolyLine(context);
                newGoogleMapController!.animateCamera(
                    CameraUpdate.newLatLngBounds(
                        Provider.of<AppData>(context, listen: false)
                            .polylineData
                            .bounds,
                        70));
              });
              showModalBottomSheet(
                  isDismissible: false,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: RideRequestScreen(),
                      ))).whenComplete(() {
                DirectionDetailsData data = DirectionDetailsData();
                Provider.of<AppData>(context, listen: false)
                    .updateDirectionDetails(data);
                setState(() {
                  newGoogleMapController!.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: GetLocation.latLng,
                        zoom: 14,
                      ),
                    ),
                  );
                });
              });
            }
          });
        },
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            compassEnabled: true,
            markers: Provider.of<AppData>(context, listen: false)
                .polylineData
                .markers,
            circles: Provider.of<AppData>(context, listen: false)
                .polylineData
                .circles,
            mapToolbarEnabled: true,
            polylines: Provider.of<AppData>(context, listen: false)
                .polylineData
                .polylineSet,
            initialCameraPosition: _kUserLatLng != _kGoogleLatLng
                ? _kUserCameraPosition
                : _kGoogleCameraPosition,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) async {
              _googleMapController.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                newGoogleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: GetLocation.latLng,
                      zoom: 14,
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    initialize();
    GeocodingModel.getCurrentOnlineUserInfo(context);
    super.initState();
  }

  void initialize() async {
    if (LatLng(37.42796133580664, -122.085749655962) == GetLocation.latLng) {
      await GetLocation.getCurrentLocation();
      if (LatLng(37.42796133580664, -122.085749655962) != GetLocation.latLng) {
        await GeocodingModel.getAddressFromCoordinate(
            GetLocation.position, context);
      }
    }
  }
}
