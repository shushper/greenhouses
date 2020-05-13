import 'package:flutter/material.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/design/icons.dart';
import 'package:greenhouses/models/greenhouse.dart';

class MainScreen extends StatelessWidget {
  final greenhouses = <Greenhouse>[
    Greenhouse(
        image: 'assets/images/greenhouse_thumb_1.jpg',
        lightningToggled: true,
        temperatureToggled: true,
        wateringToggled: false,
        ventilationToggled: false,
        lightning: '59%',
        temperature: '30°C',
        watering: null,
        ventilation: null),
    Greenhouse(
        image: 'assets/images/greenhouse_thumb_1.jpg',
        lightningToggled: true,
        temperatureToggled: true,
        wateringToggled: false,
        ventilationToggled: true,
        lightning: '23%',
        temperature: '42°C',
        watering: null,
        ventilation: '20 m³/h')
  ];

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
              final i = index - 2;
              return GreenhouseItem(i, greenhouses[i - 1]);
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
                'March 16, Mon',
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('54%', style: _kTitleStyle, textAlign: TextAlign.center),
              SizedBox(height: 8),
              Text('Humidity',
                  style: _kValueStyle, textAlign: TextAlign.center),
            ],
          ),
          Column(
            children: <Widget>[
              Text('11°C', style: _kTitleStyle, textAlign: TextAlign.center),
              SizedBox(height: 8),
              Text('Temperature',
                  style: _kValueStyle, textAlign: TextAlign.center),
            ],
          ),
          Column(
            children: <Widget>[
              Text('0,5 cm', style: _kTitleStyle, textAlign: TextAlign.center),
              SizedBox(height: 8),
              Text('Precipitation',
                  style: _kValueStyle, textAlign: TextAlign.center),
            ],
          )
        ],
      ),
    );
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
  final int index;
  final Greenhouse greenhouse;

  GreenhouseItem(this.index, this.greenhouse);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          height: 240,
          child: Column(
            children: <Widget>[
              Container(
                height: 138,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        greenhouse.image,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      top: 24,
                      left: 16,
                      child: Container(
                        decoration: BoxDecoration(
                            color: GreenhousesColors.green,
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 14),
                          child: Text(
                            'Greenhouse $index',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 102,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GreenhousesColors.border,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GreenhouseToggleCompact(
                        GreenhousesIcons.lightning,
                        greenhouse.lightning,
                        greenhouse.lightningToggled,
                      ),
                      GreenhouseToggleCompact(
                        GreenhousesIcons.temperature,
                        greenhouse.temperature,
                        greenhouse.temperatureToggled,
                      ),
                      GreenhouseToggleCompact(
                        GreenhousesIcons.watering,
                        greenhouse.watering,
                        greenhouse.wateringToggled,
                      ),
                      GreenhouseToggleCompact(
                        GreenhousesIcons.ventilation,
                        greenhouse.ventilation,
                        greenhouse.ventilationToggled,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GreenhouseToggleCompact extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool toggled;

  GreenhouseToggleCompact(this.iconData, this.title, this.toggled);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          iconData,
          size: 24,
          color: toggled ? Colors.black : GreenhousesColors.gray,
        ),
        SizedBox(
          height: 16.0,
        ),
        Text(
          toggled ? title : 'Off',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: toggled ? Colors.black : GreenhousesColors.gray),
        )
      ],
    );
  }
}
