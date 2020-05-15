import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhouses/data/greenhouse_repository.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/design/icons.dart';
import 'package:greenhouses/models/greenhouse.dart';
import 'package:greenhouses/screens/main/greenhouse/greenhouse_screen.dart';
import 'package:greenhouses/screens/main/main/main_bloc.dart';
import 'package:greenhouses/screens/main/main/main_event.dart';
import 'package:greenhouses/screens/main/main/main_state.dart';


class MainScreen extends StatelessWidget {

  static final route = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (context) {
        return MainBloc(context.repository<GreenhouseRepository>())..add(FetchGreenhouses());
      },
      child: MainScreenContent(),
    );
  }
}

class MainScreenContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {

            if (state is GreenhousesLoading) {
              return Container(color: Colors.white,);
            }

            if (state is GreenhousesLoaded) {
              return ListView.builder(
                itemCount: 2 + state.greenhouses.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return WeatherSection();
                  } else if (index == 1) {
                    return GreenhouseTitle();
                  } else {
                    final i = index - 1;
                    return GreenhouseItem(state.greenhouses[i - 1]);
                  }
                },
              );
            }

            throw Exception('Unknown state = $state');
          },
        ),
      ),
    );
  }
}

class WeatherSection extends StatelessWidget {
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
    return Column(
      children: <Widget>[
        Padding(
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
        ),
        Padding(
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
                  Text('11°C',
                      style: _kTitleStyle, textAlign: TextAlign.center),
                  SizedBox(height: 8),
                  Text('Temperature',
                      style: _kValueStyle, textAlign: TextAlign.center),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('0,5 cm',
                      style: _kTitleStyle, textAlign: TextAlign.center),
                  SizedBox(height: 8),
                  Text('Precipitation',
                      style: _kValueStyle, textAlign: TextAlign.center),
                ],
              )
            ],
          ),
        ),
      ],
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

class GreenhouseItem extends StatefulWidget {
  final Greenhouse greenhouse;

  GreenhouseItem(this.greenhouse);

  @override
  _GreenhouseItemState createState() => _GreenhouseItemState();
}

class _GreenhouseItemState extends State<GreenhouseItem> with TickerProviderStateMixin {

  AnimationController _controller;
  var itemScale = 1.0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
      duration: Duration(milliseconds: 150),
    );

    _controller.addListener(() {
      setState(() {
        itemScale = _controller.value;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      child: GestureDetector(
        onTapDown: (details) {
          _controller.reverse(from: 1.0);
        },
        onTapCancel: () {
          _controller.forward();
        },
        onTapUp: (details) {
          _controller.forward();
        },
        onTap: () {
          Navigator.of(context).pushNamed(GreenhouseScreen.route,
              arguments: widget.greenhouse.id);
        },
        child: Transform.scale(
          scale: itemScale,
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
                            widget.greenhouse.thumb,
                            fit: BoxFit.cover,
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
                                widget.greenhouse.name,
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
                          GreenhouseParamIndicator(
                            GreenhousesIcons.lightning,
                            widget.greenhouse.lightning,
                            widget.greenhouse.lightningToggled,
                          ),
                          GreenhouseParamIndicator(
                            GreenhousesIcons.temperature,
                            widget.greenhouse.temperature,
                            widget.greenhouse.temperatureToggled,
                          ),
                          GreenhouseParamIndicator(
                            GreenhousesIcons.watering,
                            widget.greenhouse.watering,
                            widget.greenhouse.wateringToggled,
                          ),
                          GreenhouseParamIndicator(
                            GreenhousesIcons.ventilation,
                            widget.greenhouse.ventilation,
                            widget.greenhouse.ventilationToggled,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GreenhouseParamIndicator extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool toggled;

  GreenhouseParamIndicator(this.iconData, this.title, this.toggled);

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
