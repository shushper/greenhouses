import 'package:bloc/bloc.dart';
import 'package:greenhouses/screens/main/lightning/lightning_event.dart';
import 'package:greenhouses/screens/main/lightning/lightning_state.dart';

class LightningBloc extends Bloc<LightningEvent, LightningState> {
  final double initValue;
  final bool initToggled;

  double value;
  bool toggled;

  LightningBloc(this.initValue, this.initToggled)
      : value = initValue,
        toggled = initToggled;

  @override
  LightningState get initialState =>
      Values(value: value, toggled: toggled, animate: true);

  @override
  Stream<LightningState> mapEventToState(LightningEvent event) async* {
    if (event is LightningToggled) {
      yield* mapLightningToggledToState(event);
    } else if (event is LightningValueChanged) {
      yield* mapLightningValueChangedToState(event);
    } else if (event is LeavingScreen) {
      yield PopBack(toggled ? value : 0, toggled);
    }
  }

  Stream<LightningState> mapLightningToggledToState(LightningToggled event) async* {
    toggled = event.toggled;
    double resultValue;

    if (toggled) {
      resultValue = value == 0 ? 5 : value;
    } else {
      resultValue = 0;
    }

    yield Values(
      value: resultValue,
      toggled: toggled,
      animate: true,
    );
  }

  Stream<LightningState> mapLightningValueChangedToState(LightningValueChanged event) async* {
    value = event.value;
    yield Values(
      value: value,
      toggled: toggled,
      animate: false,
    );
  }
}
