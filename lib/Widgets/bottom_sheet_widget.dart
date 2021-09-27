import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/DataHandler/app_data.dart';
import 'package:rider_app/Screens/search_screen.dart';
import 'package:rider_app/Services/geocodingModel.dart';

import 'divider_widget.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({Key? key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.only(
        //   topRight: Radius.circular(18),
        //   topLeft: Radius.circular(18.0),
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 16.0,
            spreadRadius: 0.5,
            offset: Offset(0.7, 0.7),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6,
            ),
            Text(
              'Hey there',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              'Where to?',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'bolt-semibold',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                var response =
                    await Navigator.pushNamed(context, SearchScreen.id);
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
                if (response == 'yes') {
                  await GeocodingModel.getDirection(context);
                  Navigator.pop(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Search destination'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Provider.of<AppData>(context)
                                    .addressData
                                    .placeFormattedAddress !=
                                ''
                            ? Provider.of<AppData>(context)
                                .addressData
                                .placeFormattedAddress
                            : 'Add Home',
                        softWrap: true,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'Residential Address',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            DividerWidget(),
            SizedBox(
              height: 14.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.work,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Work',
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'Office Address',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
