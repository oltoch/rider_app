import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/DataHandler/app_data.dart';
import 'package:rider_app/DataHandler/place_prediction_data.dart';
import 'package:rider_app/Services/geocodingModel.dart';
import 'package:rider_app/Widgets/divider_widget.dart';
import 'package:rider_app/Widgets/prediction_tile.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "searchScreenId";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController whereToTextEditingController = TextEditingController();
  List<PlacePrediction> placePredictionList = [];

  @override
  Widget build(BuildContext context) {
    String address =
        Provider.of<AppData>(context).addressData.placeFormattedAddress != ''
            ? Provider.of<AppData>(context).addressData.placeFormattedAddress
            : '';
    pickUpTextEditingController.text = address;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 215.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        Center(
                          child: Text(
                            'Set drop off',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'images/pickicon.png',
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 18.0,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.grey[400],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(
                                controller: pickUpTextEditingController,
                                decoration: InputDecoration(
                                  hintText: 'Pickup Location',
                                  //fillColor: Colors.grey[400],
                                  filled: true,
                                  isDense: true,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 11),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'images/desticon.png',
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 18.0,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.grey[400],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextField(
                                onChanged: (value) {
                                  GeocodingModel.findPlace(value);
                                  setState(() {
                                    placePredictionList = GeocodingModel.list;
                                  });
                                },
                                controller: whereToTextEditingController,
                                decoration: InputDecoration(
                                  hintText: 'Where to?',
                                  //fillColor: Colors.grey[400],
                                  filled: true,
                                  isDense: true,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 11),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //tile for prediction
            SizedBox(
              height: 0.0,
            ),
            (placePredictionList.length > 0)
                ? Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return PredictionTile(
                              placePrediction: placePredictionList[index],
                            );
                          },
                          separatorBuilder: (context, int index) =>
                              DividerWidget(),
                          itemCount: placePredictionList.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
