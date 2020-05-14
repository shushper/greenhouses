import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/design/icons.dart';
import 'package:greenhouses/models/greenhouse.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class LightningScreen extends StatefulWidget {
  static final route = 'lightning_screen';

  final Greenhouse greenhouse;

  LightningScreen(this.greenhouse);

  @override
  _LightningScreenState createState() =>
      _LightningScreenState(greenhouse.lightningToggled);
}

class _LightningScreenState extends State<LightningScreen> {
  var toggled = false;

  _LightningScreenState(this.toggled);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Lightning'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SwitchSection(
            toggled: toggled,
            onToggled: (value) {
              setState(() {
                toggled = value;
              });
            },
          ),
          LightningControl()
        ],
      ),
    );
  }
}

class SwitchSection extends StatelessWidget {
  final bool toggled;
  final Function(bool) onToggled;

  SwitchSection({this.toggled, this.onToggled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: <Widget>[
          Icon(
            GreenhousesIcons.lightning,
            color: Colors.black,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            'On',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Spacer(),
          CupertinoSwitch(
            value: toggled,
            activeColor: GreenhousesColors.green,
            onChanged: (value) {
              onToggled(value);
            },
          )
        ],
      ),
    );
  }
}

class LightningControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(45.0),
        child: CustomPaint(
          painter: CrossLinesPainter(),
          child: SleekCircularSlider(
            appearance: CircularSliderAppearance(
                startAngle: 270,
                angleRange: 360,
                spinnerMode: false,
                customWidths: CustomSliderWidths(
                  trackWidth: 1,
                  handlerSize: 9,
                  progressBarWidth: 1,
                ),
                customColors: CustomSliderColors(
                    dotColor: GreenhousesColors.green,
                    trackColor: Colors.white,
                    progressBarColor: GreenhousesColors.green)),
            min: 0,
            max: 100,
            innerWidget: (double value) {
              return LightningInnerWidget(value.toInt());
            },
            onChange: (double value) {},
          ),
        ),
      ),
    );
  }
}

class LightningInnerWidget extends StatelessWidget {
  final int value;

  LightningInnerWidget(this.value);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final padding = constraints.maxWidth * 0.2;
        return Padding(
          padding: EdgeInsets.all(padding),
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                  offset: Offset(10 * value / 100, 16 * value / 100),
                  blurRadius: 48 * value / 100,
                  color: Color(0x42006729),
                )
              ],
              shape: CircleBorder(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$value%',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Yellow light',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: GreenhousesColors.grayText
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CrossLinesPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = GreenhousesColors.grayText.withAlpha(80)
      ..strokeWidth = 1;

    final v1 = Offset(size.width * 0.5, size.width * 0.1);
    final v2 = Offset(size.width * 0.5, size.width * 0.9);

    final h1 = Offset(size.height * 0.1, size.height * 0.5);
    final h2 = Offset(size.height * 0.9, size.height * 0.5);

    canvas.drawLine(v1, v2, paint);
    canvas.drawLine(h1, h2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}


