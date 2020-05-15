import 'package:greenhouses/models/greenhouse_control.dart';

class Watering extends GreenhouseControl {
  static final unitOfMeasurement = ' m³/s';

  final bool enabled;
  final int value;

  Watering({
    this.enabled,
    this.value,
  });

  String getReadableValue() {
    return '$value$unitOfMeasurement';
  }
}