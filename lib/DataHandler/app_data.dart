import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/DataHandler/address_data.dart';
import 'package:rider_app/DataHandler/all_users.dart';
import 'package:rider_app/DataHandler/direction_details_data.dart';
import 'package:rider_app/DataHandler/nearby_drivers.dart';
import 'package:rider_app/DataHandler/polyline_data.dart';

class AppData extends ChangeNotifier {
  AddressData addressData = AddressData();
  AddressData dropOffAddress = AddressData();
  DirectionDetailsData directionDetailsData = DirectionDetailsData();
  PolylineData polylineData = PolylineData();
  Users users = Users();
  NearbyDrivers nearbyDrivers = NearbyDrivers();

  void updateAddress(AddressData userAddressData) {
    addressData = userAddressData;
    notifyListeners();
  }

  void updateDropOffAddress(AddressData dropOffData) {
    dropOffAddress = dropOffData;
    notifyListeners();
  }

  void updateDirectionDetails(DirectionDetailsData directionDetails) {
    directionDetailsData = directionDetails;
    notifyListeners();
  }

  void updatePolylineData(PolylineData data) {
    polylineData = data;
    notifyListeners();
  }

  void usersFromSnapshot(DataSnapshot snapshot) {
    users.id = snapshot.key!;
    users.email = snapshot.value['email'];
    users.name = snapshot.value['name'];
    users.phone = snapshot.value['phone'];
    notifyListeners();
  }

  void updateNearbyDrivers(NearbyDrivers drivers) {
    nearbyDrivers = drivers;
    notifyListeners();
  }

  void removeDriverFromList(String key, NearbyDrivers drivers) {
    int index =
        drivers.nearbyDriversList.indexWhere((element) => element.key == key);
    drivers.nearbyDriversList.removeAt(index);
    notifyListeners();
  }

  void updateDriverLocation(NearbyDrivers nearbyDrivers) {
    int index = nearbyDrivers.nearbyDriversList
        .indexWhere((element) => element.key == nearbyDrivers.key);
    nearbyDrivers.nearbyDriversList[index].latitude = nearbyDrivers.latitude;
    nearbyDrivers.nearbyDriversList[index].longitude = nearbyDrivers.longitude;
  }
}
