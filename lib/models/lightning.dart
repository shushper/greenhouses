import 'package:greenhouses/models/greenhouse_control.dart';

class Lightning extends GreenhouseControl {

  static final unitOfMeasurement = '%';

  final bool enabled;
  final int value;

  Lightning({
    this.enabled,
    this.value,
  });

  String getReadableValue() {
    return '$value$unitOfMeasurement';
  }
}
