import 'package:equatable/equatable.dart';

abstract class LightningState extends Equatable {
  const LightningState();

  @override
  List<Object> get props => [];
}

class Values extends LightningState {
  final double value;
  final bool toggled;
  final bool animate;

  Values({this.value, this.toggled, this.animate});

  @override
  List<Object> get props => [value, toggled, animate];

  @override
  bool get stringify => true;
}

class PopBack extends LightningState {
  final double value;
  final bool toggled;

  PopBack(this.value, this.toggled);

  @override
  List<Object> get props => [value, toggled];
}
