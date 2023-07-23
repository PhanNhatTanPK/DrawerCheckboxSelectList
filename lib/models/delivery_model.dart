class DeliveryModel {
  final String title;
  final String subtitle;
  final double price;

  DeliveryModel(
      {required this.title, required this.subtitle, required this.price});

  static List<DeliveryModel> getInfo() {
    return <DeliveryModel>[
      DeliveryModel(
          title: "Standard", subtitle: "4-10 bussiness days", price: 5.00),
      DeliveryModel(
          title: "Express", subtitle: "2-5 bussiness days", price: 16.00),
      DeliveryModel(
          title: "Super Fast", subtitle: "1 bussiness day", price: 25.00),
    ];
  }
}
