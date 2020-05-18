import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouses/data/greenhouse_repository.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/design/icons.dart';
import 'package:greenhouses/models/greenhouse.dart';
import 'package:greenhouses/screens/main/greenhouse/greenhouse_event.dart';
import 'package:greenhouses/screens/main/greenhouse/greenhouse_state.dart';
import 'package:greenhouses/screens/main/lightning/lightning_screen.dart';

import 'greenhouse_bloc.dart';

class GreenhouseScreen extends StatelessWidget {
  static final route = 'greenhouse_screen';

  final int greenhouseId;

  GreenhouseScreen(this.greenhouseId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GreenhouseBloc>(
      create: (context) {
        return GreenhouseBloc(
          greenhouseId: greenhouseId,
          repo: context.repository<GreenhouseRepository>(),
        )..add(FetchGreenhouse());
      },
      child: GreenhouseScreenContent(),
    );
  }
}

class GreenhouseScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GreenhouseBloc, GreenhouseState>(
      builder: (context, state) {
        if (state is GreenhouseLoading) {
          return Container(color: Colors.white);
        }

        if (state is GreenhouseLoaded) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(state.greenhouse.name),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ImagesSection(state.greenhouse),
                ),
                ControlsSection(state.greenhouse),
              ],
            ),
          );
        }

        throw Exception('Unknown state $state');
      },
    );
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
                toggled: greenhouse.lightning.enabled,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    LightningScreen.route,
                    arguments: greenhouse.lightning,
                  ).then((value) {
                    BlocProvider.of<GreenhouseBloc>(context)
                        .add(LightningWasChanged(value));
                  });
                },
              ),
              GreenhouseToggle(
                iconData: GreenhousesIcons.temperature,
                title: 'Temperature',
                toggled: greenhouse.temperature.enabled,
                onTap: () {},
              )
            ]),
            TableRow(children: [
              GreenhouseToggle(
                iconData: GreenhousesIcons.watering,
                title: 'Watering',
                toggled: greenhouse.watering.enabled,
                onTap: () {},
              ),
              GreenhouseToggle(
                iconData: GreenhousesIcons.ventilation,
                title: 'Ventilation',
                toggled: greenhouse.ventilation.enabled,
                onTap: () {},
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
  final Function onTap;

  GreenhouseToggle({this.iconData, this.title, this.toggled, this.onTap});

  @override
  _GreenhouseToggleState createState() => _GreenhouseToggleState();
}

class _GreenhouseToggleState extends State<GreenhouseToggle>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> backgroundAnimation;
  Animation<Color> borderAnimation;
  Animation<Color> controlsAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    backgroundAnimation =
        ColorTween(begin: Colors.white, end: GreenhousesColors.green).animate(
      CurvedAnimation(
          parent: controller, curve: Interval(0.3, 0.6, curve: Curves.easeIn)),
    );
    borderAnimation = ColorTween(
            begin: GreenhousesColors.border, end: GreenhousesColors.green)
        .animate(
      CurvedAnimation(
          parent: controller, curve: Interval(0.3, 0.6, curve: Curves.easeIn)),
    );
    controlsAnimation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(
      CurvedAnimation(
          parent: controller, curve: Interval(0.3, 0.6, curve: Curves.easeIn)),
    );

    controller.value = widget.toggled ? 1.0 : 0.0;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didUpdateWidget(GreenhouseToggle oldWidget) {
    if (oldWidget.toggled != widget.toggled) {
      if (widget.toggled) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return _createWidgetWithColors(
              backgroundAnimation.value,
              borderAnimation.value,
              controlsAnimation.value,
              widget.toggled,
            );
          },
        ),
      ),
    );
  }

  Widget _createWidgetWithColors(Color backgroundColor, Color borderColor,
      Color controlColor, bool toggled) {
    print("createWidgetWithColors ${widget.title}");

    return AspectRatio(
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
                    color: controlColor,
                  ),
                  Spacer(),
                  Indicator(toggled)
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
                  color: controlColor,
                ),
              )
            ],
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
