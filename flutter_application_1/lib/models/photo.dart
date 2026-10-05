import 'camera.dart';
import 'rover.dart';

class Photo {
  final int id;
  final int sol;
  final String imgSrc;
  final String earthDate;
  final Camera camera;
  final Rover rover;

  Photo({
    required this.id,
    required this.sol,
    required this.imgSrc,
    required this.earthDate,
    required this.camera,
    required this.rover,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] ?? 0,
      sol: json['sol'] ?? 0,
      imgSrc: json['img_src'] ?? '',
      earthDate: json['earth_date'] ?? '',
      camera: Camera.fromJson(
        json['camera'] ?? {},
      ),
      rover: Rover.fromJson(
        json['rover'] ?? {},
      ),
    );
  }
}