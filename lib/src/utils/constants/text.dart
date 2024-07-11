class AppStrings {
  static List<VehicleType> vehicleTypes = [
    VehicleType(name: 'Toyota Prius', category: 'Compact Car', basePrice: 20.0),
    VehicleType(name: 'Honda Accord', category: 'Midsize Car', basePrice: 25.0),
    VehicleType(
        name: 'Cadillac Escalade', category: 'Fullsize Car', basePrice: 30.0),
    VehicleType(
        name: 'Standard Motorcycle', category: 'Motorcycle', basePrice: 10.0),
    VehicleType(name: 'Mini Bus', category: 'Mini Bus', basePrice: 40.0),
    VehicleType(
        name: 'Fullsize Bus', category: 'Fullsize Bus', basePrice: 50.0),
    // Add more vehicles as needed
  ];
}

class VehicleType {
  final String name;
  final String category;
  final double basePrice;

  VehicleType(
      {required this.name, required this.category, required this.basePrice});
}
