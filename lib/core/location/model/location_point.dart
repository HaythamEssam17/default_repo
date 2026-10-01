class LocationPoint {
  final double latitude;
  final double longitude;
  final String? address;

  const LocationPoint({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}
