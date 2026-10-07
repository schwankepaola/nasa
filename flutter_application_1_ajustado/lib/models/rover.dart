class Rover {
  final int id;
  final String name;
  final String landingDate;
  final String launchDate;
  final String status;
  final int maxSol;
  final String maxDate;
  final int totalPhotos;

  Rover({
    required this.id,
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
    required this.maxSol,
    required this.maxDate,
    required this.totalPhotos,
  });

  factory Rover.fromJson(Map<String, dynamic> json) {
    return Rover(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      landingDate: json['landing_date'] ?? '',
      launchDate: json['launch_date'] ?? '',
      status: json['status'] ?? '',
      maxSol: json['max_sol'] ?? 0,
      maxDate: json['max_date'] ?? '',
      totalPhotos: json['total_photos'] ?? 0,
    );
  }
}