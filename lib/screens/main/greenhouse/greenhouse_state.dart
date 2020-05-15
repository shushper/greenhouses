import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:greenhouses/models/greenhouse.dart';

abstract class GreenhouseState extends Equatable {
  @override
  List<Object> get props => [];
}

class GreenhouseLoading extends GreenhouseState {}

class GreenhouseLoaded extends GreenhouseState {
  final Greenhouse greenhouse;

  GreenhouseLoaded({@required this.greenhouse});

  @override
  List<Object> get props => [greenhouse];
}