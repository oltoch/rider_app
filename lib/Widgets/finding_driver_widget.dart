import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/Services/geocodingModel.dart';

class FindingDriverWidget extends StatefulWidget {
  const FindingDriverWidget({Key? key}) : super(key: key);

  @override
  _FindingDriverWidgetState createState() => _FindingDriverWidgetState();
}

class _FindingDriverWidgetState extends State<FindingDriverWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 40.0,
                color: Colors.black54,
                letterSpacing: 5,
                fontFamily: 'Signatra'),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Finding Driver'),
                WavyAnimatedText('Please wait...'),
                WavyAnimatedText('. . .'),
              ],
              repeatForever: true,
              isRepeatingAnimation: true,
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        GestureDetector(
          onTap: () {
            GeocodingModel.cancelRideRequest();
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(26),
              ),
              border: Border.all(width: 2.0, color: Colors.red),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.close_outlined,
                size: 40,
                color: Colors.red,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text('Cancel Ride'),
      ],
    ));
  }
}
