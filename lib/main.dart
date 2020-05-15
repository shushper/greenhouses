import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:greenhouses/blocs/greenhouse/greenhouse_bloc.dart';
import 'package:greenhouses/blocs/greenhouse/greenhouse_event.dart';
import 'package:greenhouses/data/greenhouse_repository.dart';
import 'package:greenhouses/design/colors.dart';
import 'package:greenhouses/screens/home_screen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(Providers(MyApp()));
}

class Providers extends StatelessWidget {
  final Widget child;

  Providers(this.child);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GreenhouseRepository>(
          create: (context) => GreenhouseRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GreenhouseBloc>(
            create: (context) {
              return GreenhouseBloc(context.repository<GreenhouseRepository>())
                ..add(FetchGreenhouses());
            },
          )
        ],
        child: child,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Graphik',
          scaffoldBackgroundColor: Colors.white,
          accentColor: GreenhousesColors.green,
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen());
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('onEvent $event');
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('onError $error');
  }
}
