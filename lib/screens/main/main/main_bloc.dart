

import 'package:bloc/bloc.dart';
import 'package:greenhouses/data/greenhouse_repository.dart';

import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  final GreenhouseRepository repo;

  MainBloc(this.repo);

  @override
  MainState get initialState => GreenhousesLoading();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is FetchGreenhouses) {
      yield* _mapFetchGreenhousesToState(event);
    }
  }

  Stream<MainState> _mapFetchGreenhousesToState(MainEvent event) async* {
    yield GreenhousesLoading();
    final greenhouses = await repo.getGreenhouses();
    yield GreenhousesLoaded(greenhouses: greenhouses);
  }

}