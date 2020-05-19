import 'package:greenhouses/models/lightning.dart';
import 'package:greenhouses/models/temperature.dart';
import 'package:greenhouses/models/ventilation.dart';
import 'package:greenhouses/models/watering.dart';

class Greenhouse {
  final int id;
  final String name;
  final String image;
  final List<String> images;
  final String thumb;

  final Lightning lightning;
  final Temperature temperature;
  final Watering watering;
  final Ventilation ventilation;


  Greenhouse({
    this.id,
    this.name,
    this.image,
    this.images,
    this.thumb,
    this.lightning,
    this.temperature,
    this.watering,
    this.ventilation,
  });

  Greenhouse copyWith({Lightning lightning}) {
    return Greenhouse(
      id: id,
      name: name,
      image: image,
      images: images,
      thumb: thumb,
      lightning: lightning ?? this.lightning,
      temperature: temperature,
      watering: watering,
      ventilation: ventilation
    );
  }
}
