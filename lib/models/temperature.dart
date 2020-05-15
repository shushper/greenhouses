import 'package:greenhouses/models/greenhouse_control.dart';

class Temperature extends GreenhouseControl {
  static final unitOfMeasurement = '°C';

  final bool enabled;
  final int value;

  Temperature({
    this.enabled,
    this.value,
  });

  String getReadableValue() {
    return '$value$unitOfMeasurement';
  }
}