import 'package:bloc/bloc.dart';
import 'package:greenhouses/data/greenhouse_repository.dart';
import 'package:greenhouses/screens/main/greenhouse/greenhouse_event.dart';
import 'package:greenhouses/screens/main/greenhouse/greenhouse_state.dart';

class GreenhouseBloc extends Bloc<GreenhouseEvent, GreenhouseState> {

  final int greenhouseId;
  final GreenhouseRepository repo;

  GreenhouseBloc({this.greenhouseId, this.repo});

  @override
  GreenhouseState get initialState => GreenhouseLoading();

  @override
  Stream<GreenhouseState> mapEventToState(GreenhouseEvent event) async* {
    if (event is FetchGreenhouse) {
      yield* mapFetchGreenhouseToState(event);
    } else if (event is LightningWasChanged) {
      yield* mapLightningWasChangedToState(event);
    }
  }

  Stream<GreenhouseState> mapFetchGreenhouseToState(FetchGreenhouse event) async* {
    yield GreenhouseLoading();
    final greenhouse = await repo.getGreenhouse(greenhouseId);
    yield GreenhouseLoaded(greenhouse: greenhouse);
  }

  Stream<GreenhouseState> mapLightningWasChangedToState(LightningWasChanged event) async* {
    final greenhouse = await repo.setLightning(greenhouseId, event.lightning);
    yield GreenhouseLoaded(greenhouse: greenhouse);
  }

}