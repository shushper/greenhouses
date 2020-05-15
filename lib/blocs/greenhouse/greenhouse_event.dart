import 'package:equatable/equatable.dart';

abstract class GreenhouseEvent extends Equatable {
  const GreenhouseEvent();

  @override
  List<Object> get props => [];
}

class FetchGreenhouses extends GreenhouseEvent {}