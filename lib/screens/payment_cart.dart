import 'package:flutter/material.dart';

import '../models/delivery_model.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({super.key});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  late List<DeliveryModel> _listDelivery;

  @override
  void initState() {
    super.initState();
    _listDelivery = DeliveryModel.getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildDelivery(),
    );
  }

  Widget _buildDelivery() {
    return Column(children: _buildListRadioButton());
  }

  List<Widget> _buildListRadioButton() {
    List<Widget> radioButtons = [];
    for (DeliveryModel radio in _listDelivery) {
      radioButtons.add(RadioListTile(
        activeColor: Colors.blue,
        controlAffinity: ListTileControlAffinity.trailing,
        isThreeLine: true,
        value: radio,
        groupValue: radio,
        title: Text(radio.title),
        subtitle: Text.rich(TextSpan(children: [
          TextSpan(text: radio.subtitle),
          TextSpan(text: "\$" + radio.price.toString()),
        ])),
        onChanged: (currentDelivery) {},
        selected: false,
      ));
    }
    return radioButtons;
  }
}
