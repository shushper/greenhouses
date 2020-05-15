

import 'package:bloc/bloc.dart';
import 'package:greenhouses/blocs/greenhouse/greenhouse_event.dart';
import 'package:greenhouses/blocs/greenhouse/greenhouse_state.dart';
import 'package:greenhouses/data/greenhouse_repository.dart';

class GreenhouseBloc extends Bloc<GreenhouseEvent, GreenhouseState> {

  final GreenhouseRepository repo;

  GreenhouseBloc(this.repo);

  @override
  GreenhouseState get initialState => GreenhousesLoading();

  @override
  Stream<GreenhouseState> mapEventToState(GreenhouseEvent event) async* {
    if (event is FetchGreenhouses) {
      yield* _mapFetchGreenhousesToState(event);
    }
  }

  Stream<GreenhouseState> _mapFetchGreenhousesToState(GreenhouseEvent event) async* {
    yield GreenhousesLoading();
    final greenhouses = await repo.getGreenhouses();
    yield GreenhousesLoaded(greenhouses: greenhouses);
  }

}