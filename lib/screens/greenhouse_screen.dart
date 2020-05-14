import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/design/icons.dart';
import 'package:greenhouses/models/greenhouse.dart';

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
                GreenhousesIcons.lightning,
                'Lightning',
                greenhouse.lightningToggled,
              ),
              GreenhouseToggle(
                GreenhousesIcons.temperature,
                'Temperature',
                greenhouse.temperatureToggled,
              )
            ]),
            TableRow(children: [
              GreenhouseToggle(
                GreenhousesIcons.watering,
                'Watering',
                greenhouse.wateringToggled,
              ),
              GreenhouseToggle(
                GreenhousesIcons.ventilation,
                'Ventilation',
                greenhouse.ventilationToggled,
              )
            ])
          ],
        ),
      ),
    );
  }
}

class GreenhouseToggle extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool toggled;

  GreenhouseToggle(this.iconData, this.title, this.toggled);

  @override
  _GreenhouseToggleState createState() => _GreenhouseToggleState(toggled);
}

class _GreenhouseToggleState extends State<GreenhouseToggle> {
  var toggled = false;

  _GreenhouseToggleState(this.toggled);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = toggled ? GreenhousesColors.green : Colors.white;
    final borderColor =
        toggled ? GreenhousesColors.green : GreenhousesColors.border;
    final controlsColor = toggled ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                      widget.iconData,
                      size: 24,
                      color: controlsColor,
                    ),
                    Spacer(),
                    CupertinoSwitch(
                      activeColor: Color(0xFF006729),
                      value: toggled,
                      onChanged: (checked) {
                        setState(() {
                          toggled = checked;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  widget.title,
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
    );
  }
}
