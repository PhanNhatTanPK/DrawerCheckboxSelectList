class PaymentModel {
  final String numberCard;
  final String subTitle;
  final String image;
  bool state = false;
  PaymentModel(
      {required this.numberCard,
      required this.subTitle,
      required this.image,
      state = false});

  static List<PaymentModel> getInfo() {
    return <PaymentModel>[
      PaymentModel(
          numberCard: "0214 8304",
          subTitle: "Last time used: Mar 26 ,2022",
          image:
              "https://movingwaldo.com/wp-content/uploads/2020/03/Mastercard_logo.jpg"),
      PaymentModel(
          numberCard: "0212 0123",
          subTitle: "Never used",
          image:
              "https://purepng.com/public/uploads/large/purepng.com-visa-logologobrand-logoiconslogos-251519938794uqvcz.png"),
    ];
  }
}
