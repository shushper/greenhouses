import 'package:equatable/equatable.dart';
import 'package:greenhouses/models/lightning.dart';

abstract class GreenhouseEvent extends Equatable {
  const GreenhouseEvent();

  @override
  List<Object> get props => [];
}

class FetchGreenhouse extends GreenhouseEvent {}

class LightningWasChanged extends GreenhouseEvent {
  final Lightning lightning;

  LightningWasChanged(this.lightning);

  @override
  List<Object> get props => [lightning];
}