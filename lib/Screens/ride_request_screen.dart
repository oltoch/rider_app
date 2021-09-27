import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/DataHandler/app_data.dart';
import 'package:rider_app/DataHandler/polyline_data.dart';
import 'package:rider_app/Services/geocodingModel.dart';
import 'package:rider_app/Widgets/finding_driver_widget.dart';

class RideRequestScreen extends StatefulWidget {
  static const String id = "rideRequestScreenId";
  const RideRequestScreen({Key? key}) : super(key: key);

  @override
  _RideRequestScreenState createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 16.0,
            spreadRadius: 0.5,
            offset: Offset(0.7, 0.7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              PolylineData data = PolylineData();

              Provider.of<AppData>(context, listen: false)
                  .updatePolylineData(data);

              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              //add circleAvatar here
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  border: Border.all(width: 1.5, color: Colors.red),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.close_outlined,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              color: Colors.teal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Image.asset(
                      'images/taxi.png',
                      height: 70,
                      width: 80,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Car',
                          style: TextStyle(fontSize: 22.0),
                        ),
                        Text(
                          Provider.of<AppData>(context, listen: false)
                                      .directionDetailsData
                                      .distanceValue !=
                                  0
                              ? Provider.of<AppData>(context, listen: false)
                                  .directionDetailsData
                                  .distanceText
                              : '',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      Provider.of<AppData>(context, listen: false)
                                  .directionDetailsData
                                  .durationValue !=
                              0
                          ? '\$${GeocodingModel.calculateFare(context)}'
                          : '',
                      style: TextStyle(fontSize: 22.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.money,
                  color: Colors.black54,
                  size: 34,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  'CASH',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 28,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).accentColor),
                overlayColor: MaterialStateProperty.all(Colors.teal),
                shadowColor: MaterialStateProperty.all(Colors.blueGrey),
              ),
              onPressed: () {
                GeocodingModel.saveRideRequest(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FindingDriverWidget()));
              },
              //color: Theme.of(context).accentColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Request',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.local_taxi_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
