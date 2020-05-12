import 'package:flutter/material.dart';
import 'package:greenhouses/colors.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index == 0) {
              return WeatherSection();
            }
            if (index == 1) {
              return ParametersSection();
            }
            if (index == 2) {
              return GreenhouseTitle();
            } else {
              return GreenhouseItem();
            }
          },
        ),
      ),
    );
  }
}

class WeatherSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/cloudy.png',
            height: 46.0,
          ),
          SizedBox(
            width: 16.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '16 марта, пн',
                style: TextStyle(
                  fontFamily: 'Graphik',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: GreenhousesColors.blackText,
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                'Cloudy',
                style: TextStyle(
                  fontFamily: 'Graphik',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: GreenhousesColors.blackMediumText,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ParametersSection extends StatelessWidget {
  static const _kTitleStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: GreenhousesColors.blackMediumText,
      fontSize: 18);
  static const _kValueStyle = TextStyle(
      fontWeight: FontWeight.w400,
      color: GreenhousesColors.grayText,
      fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Table(
          children: <TableRow>[
            TableRow(children: [
              Text('54%', style: _kTitleStyle, textAlign: TextAlign.center),
              Text('11°C', style: _kTitleStyle, textAlign: TextAlign.center),
              Text('0,5 cm', style: _kTitleStyle, textAlign: TextAlign.center)
            ]),
            TableRow(children: [
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 8,
              ),
            ]),
            TableRow(children: [
              Text('Humidity',
                  style: _kValueStyle, textAlign: TextAlign.center),
              Text('Temperature',
                  style: _kValueStyle, textAlign: TextAlign.center),
              Text('Precipitation',
                  style: _kValueStyle, textAlign: TextAlign.center)
            ])
          ],
        ));
  }
}

class GreenhouseTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, bottom: 12.0, top: 24.0),
      child: Text(
        'Greenhouses:',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: GreenhousesColors.blackMediumText,
        ),
      ),
    );
  }
}

class GreenhouseItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        height: 240,
        child: Column(
          children: <Widget>[
            Container(
              height: 138,
              child: Stack(
                children: <Widget>[
                  Image.network('https://cdn.britannica.com/69/123269-050-4F69A7A7/Greenhouse-Braunschweig-Germany.jpg')
                ],
              ),
            ),
            Container(
              height: 102,
            ),
          ],
        ),
      ),
    );
  }
}
