import 'package:rider_app/DataHandler/nearby_drivers.dart';

class GeofireAssistant {
  static List<NearbyDrivers> nearbyDriversList = [];

  static void removeDriverFromList(String key) {
    int index = nearbyDriversList.indexWhere((element) => element.key == key);
    nearbyDriversList.removeAt(index);
  }

  static void updateDriverLocation(NearbyDrivers nearbyDrivers) {
    int index = nearbyDriversList
        .indexWhere((element) => element.key == nearbyDrivers.key);
    nearbyDriversList[index].latitude = nearbyDrivers.latitude;
    nearbyDriversList[index].longitude = nearbyDrivers.longitude;
  }
}
