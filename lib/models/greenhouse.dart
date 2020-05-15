import 'package:greenhouses/models/lightning.dart';
import 'package:greenhouses/models/temperature.dart';
import 'package:greenhouses/models/ventilation.dart';
import 'package:greenhouses/models/watering.dart';

class Greenhouse {
  final int id;
  final String name;
  final String image;
  final String thumb;

  final Lightning lightning;
  final Temperature temperature;
  final Watering watering;
  final Ventilation ventilation;


  Greenhouse({
    this.id,
    this.name,
    this.image,
    this.thumb,
    this.lightning,
    this.temperature,
    this.watering,
    this.ventilation,
  });
}
