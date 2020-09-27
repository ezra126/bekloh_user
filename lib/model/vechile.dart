import 'package:bekloh_user/model/vechile_type.dart';
import 'package:equatable/equatable.dart';


class Vechile extends Equatable {
  final String id;
  final String name;
  final String plateNo;
  final VechileType vechileType;
  final String model;
  final String vechileImage;
  final bool isAvailable;


  Vechile(this.id, this.name, this.isAvailable, this.plateNo, this.vechileType, this.model, this.vechileImage,);

  Vechile.named({
    this.id,
    this.name,
    this.isAvailable,
    this.plateNo,
    this.vechileType,
    this.model,
    this.vechileImage,
  });

  Vechile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name= json['name'],
        isAvailable = json['isAvailable'],
        plateNo = json['plateNo'],
        vechileType = json['vechileType'],
        model = json['model'],
        vechileImage = json['vechileImage'];

  Map<String, dynamic> toJson() =>
      {
        'id' : this.id,
        'name': this.name,
        'isAvailable': this.isAvailable,
        'plateNo': this.name,
        'vechileType': this.name,
        'model': this.name,
        'vechileImage': this.vechileImage,

      };

  @override
  List<Object> get props => [id,name, isAvailable, plateNo, vechileType,model,vechileImage];
}