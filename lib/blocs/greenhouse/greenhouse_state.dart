import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:greenhouses/models/greenhouse.dart';

abstract class GreenhouseState extends Equatable {
  @override
  List<Object> get props => [];
}

class GreenhousesLoading extends GreenhouseState {}

class GreenhousesLoaded extends GreenhouseState {
  final List<Greenhouse> greenhouses;

  GreenhousesLoaded({@required this.greenhouses});

  @override
  List<Object> get props => [greenhouses];
}