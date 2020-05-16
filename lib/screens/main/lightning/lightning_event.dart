import 'package:equatable/equatable.dart';

abstract class LightningEvent extends Equatable {
  const LightningEvent();

  @override
  List<Object> get props => [];
}

class LeavingScreen extends LightningEvent {}

class LightningToggled extends LightningEvent {
  final bool toggled;

  LightningToggled(this.toggled);

  @override
  List<Object> get props => [toggled];
}

class LightningValueChanged extends LightningEvent {
  final double value;

  LightningValueChanged(this.value);

  @override
  List<Object> get props => [value];
}
