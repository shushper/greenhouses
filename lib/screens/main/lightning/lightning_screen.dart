import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/design/icons.dart';
import 'package:greenhouses/models/lightning.dart';
import 'package:greenhouses/screens/main/lightning/lightning_bloc.dart';
import 'package:greenhouses/screens/main/lightning/lightning_event.dart';
import 'package:greenhouses/screens/main/lightning/lightning_state.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class LightningScreen extends StatelessWidget {
  static final route = 'lightning_screen';

  final Lightning lightning;

  LightningScreen(this.lightning);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LightningBloc>(
      create: (context) {
        return LightningBloc(lightning.value.toDouble(), lightning.enabled);
      },
      child: LightningScreenContent(),
    );
  }
}

class LightningScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final LightningBloc lightningBloc = BlocProvider.of<LightningBloc>(context);

    return WillPopScope(
      onWillPop: () {
        lightningBloc.add(LeavingScreen());
        return Future.value(false);
      },
      child: BlocConsumer<LightningBloc, LightningState>(
        listener: (context, state) {
          if (state is PopBack) {
            Navigator.pop(
              context,
              Lightning(
                enabled: state.toggled,
                value: state.value.toInt(),
              ),
            );
          }
        },
        buildWhen: (previous, current) {
          return !(current is PopBack);
        },
        builder: (context, state) {
          if (state is Values) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text('Lightning'),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SwitchSection(
                    toggled: state.toggled,
                    onToggled: (value) {
                      lightningBloc.add(LightningToggled(value));
                    },
                  ),
                  LightningControl(
                    toggled: state.toggled,
                    value: state.value,
                    animate: state.animate,
                    onChanged: (value) {
                      lightningBloc.add(LightningValueChanged(value));
                    },
                  ),
                  SettingsSection(
                    toggled: state.toggled,
                  )
                ],
              ),
            );
          }

          throw Exception('Unknown state $state');
        },
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
            color: toggled ? Colors.black : GreenhousesColors.gray,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            toggled ? 'On' : 'Off',
            style: TextStyle(color: toggled ? Colors.black : GreenhousesColors.gray, fontSize: 18),
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
  final bool toggled;
  final double value;
  final bool animate;
  final Function(double) onChanged;

  LightningControl({this.toggled, this.value, this.animate, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !toggled,
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(45.0),
          child: CustomPaint(
            painter: CrossLinesPainter(),
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                animationEnabled: animate,
                startAngle: 270,
                angleRange: 360,
                spinnerMode: false,
                customWidths: CustomSliderWidths(
                  trackWidth: 1,
                  handlerSize: 9,
                  progressBarWidth: 1,
                ),
                customColors: CustomSliderColors(
                  dotColor: toggled
                      ? GreenhousesColors.green
                      : GreenhousesColors.lightGreen,
                  trackColor: Colors.white,
                  progressBarColor: GreenhousesColors.green,
                ),
              ),
              min: 0,
              max: 100,
              initialValue: value.toDouble(),
              innerWidget: (double value) {
                return LightningInnerWidget(value.toInt());
              },
              onChangeEnd: (double value) {
                onChanged(value);
              },
            ),
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
                      color: GreenhousesColors.grayText),
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

class SettingsSection extends StatelessWidget {

  final bool toggled;

  SettingsSection({this.toggled});

  static const _kTitleStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: GreenhousesColors.blackMediumText,
      fontSize: 16);

  static const _kValueStyle = TextStyle(
      fontWeight: FontWeight.w400,
      color: GreenhousesColors.grayText,
      fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !toggled,
      child: AnimatedOpacity(
        opacity: toggled ? 1.0 : 0.5,
        duration: Duration(milliseconds: 400),
        child: Table(
          children: [
            TableRow(children: [
              CircleColor(Color(0xFFFFD233)),
              CircleIcon(GreenhousesIcons.timer),
              CircleIcon(GreenhousesIcons.date),
            ]),
            TableRow(children: [
              SizedBox(height: 12),
              SizedBox(height: 12),
              SizedBox(height: 12)
            ]),
            TableRow(children: [
              Text('Color', style: _kTitleStyle, textAlign: TextAlign.center),
              Text('Timer', style: _kTitleStyle, textAlign: TextAlign.center),
              Text('Date', style: _kTitleStyle, textAlign: TextAlign.center),
            ]),
            TableRow(children: [
              SizedBox(height: 12),
              SizedBox(height: 12),
              SizedBox(height: 12)
            ]),
            TableRow(children: [
              Text('Yellow', style: _kValueStyle, textAlign: TextAlign.center),
              Text('17:00-22:00', style: _kValueStyle, textAlign: TextAlign.center),
              Text('Everyday', style: _kValueStyle, textAlign: TextAlign.center),
            ]),
          ],
        ),
      ),
    );
  }
}

class CircleColor extends StatelessWidget {
  final Color color;

  CircleColor(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(color: GreenhousesColors.border),
        ),
      ),
      child: Center(
        child: Container(
          width: 22,
          height: 22,
          decoration: ShapeDecoration(
            color: color,
            shadows: [
              BoxShadow(
                  color: color.withAlpha(40),
                  offset: Offset(0, 4),
                  blurRadius: 10)
            ],
            shape: CircleBorder(
              side: BorderSide(color: Colors.white, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  final IconData iconData;

  CircleIcon(this.iconData);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: ShapeDecoration(
          shape:
              CircleBorder(side: BorderSide(color: GreenhousesColors.border))),
      child: Icon(iconData),
    );
  }
}
