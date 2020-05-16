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
      toggled = event.toggled;
      yield Values(
        value: event.toggled ? value : 0,
        toggled: toggled,
        animate: true,
      );
    } else if (event is LightningValueChanged) {
      value = event.value;
      yield Values(
        value: value,
        toggled: toggled,
        animate: false,
      );
    } else if (event is LeavingScreen) {
      yield PopBack(toggled ? value : 0, toggled);
    }
  }
}
