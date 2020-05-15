import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/design/icons.dart';
import 'package:greenhouses/models/greenhouse.dart';
import 'package:greenhouses/screens/main/lightning/lightning_screen.dart';

class GreenhouseScreen extends StatelessWidget {
  static final route = 'greenhouse_screen';

  final Greenhouse greenhouse;

  GreenhouseScreen(this.greenhouse);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(greenhouse.name),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ImagesSection(greenhouse),
            ),
            ControlsSection(greenhouse),
          ],
        ));
  }
}

class ImagesSection extends StatelessWidget {
  final Greenhouse greenhouse;

  ImagesSection(this.greenhouse);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          greenhouse.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ControlsSection extends StatelessWidget {
  final Greenhouse greenhouse;

  ControlsSection(this.greenhouse);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenWidth,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Table(
          children: <TableRow>[
            TableRow(children: [
              GreenhouseToggle(
                iconData: GreenhousesIcons.lightning,
                title: 'Lightning',
                toggled: greenhouse.lightningToggled,
                onTap: () {
                  Navigator.pushNamed(context, LightningScreen.route, arguments: greenhouse);
                },
              ),
              GreenhouseToggle(
                iconData: GreenhousesIcons.temperature,
                title: 'Temperature',
                toggled: greenhouse.temperatureToggled,
                onTap: () {},
              )
            ]),
            TableRow(children: [
              GreenhouseToggle(
                iconData: GreenhousesIcons.watering,
                title: 'Watering',
                toggled: greenhouse.wateringToggled,
                onTap: () {},
              ),
              GreenhouseToggle(
                iconData: GreenhousesIcons.ventilation,
                title: 'Ventilation',
                toggled: greenhouse.ventilationToggled,
                onTap: () {},
              )
            ])
          ],
        ),
      ),
    );
  }
}

class GreenhouseToggle extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool toggled;
  final Function onTap;

  GreenhouseToggle({this.iconData, this.title, this.toggled, this.onTap});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = toggled ? GreenhousesColors.green : Colors.white;
    final borderColor =
        toggled ? GreenhousesColors.green : GreenhousesColors.border;
    final controlsColor = toggled ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: borderColor,
                width: toggled ? 0 : 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        iconData,
                        size: 24,
                        color: controlsColor,
                      ),
                      Spacer(),
                      Indicator(toggled)
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: controlsColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final toggled;

  const Indicator(this.toggled);

  @override
  Widget build(BuildContext context) {
    if (toggled) {
      return Container(
        width: 16.0,
        height: 16.0,
        decoration: ShapeDecoration(shadows: [
          BoxShadow(
              color: Color(0x26000000), offset: Offset(0, 3), blurRadius: 8),
          BoxShadow(
              color: Color(0x29000000), offset: Offset(0, 1), blurRadius: 1),
          BoxShadow(
              color: Color(0x1A000000), offset: Offset(0, 3), blurRadius: 1)
        ], color: Colors.white, shape: CircleBorder()),
      );
    } else {
      return Container(
        width: 16.0,
        height: 16.0,
        decoration: ShapeDecoration(
            color: GreenhousesColors.lightGreen, shape: CircleBorder()),
      );
    }
  }
}
