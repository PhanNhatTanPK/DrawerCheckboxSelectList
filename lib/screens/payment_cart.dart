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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle("Delivery method"),
        Row(children: _buildListRadioButton()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle("Payment method"),
            _buildButtonAdd(Icons.add, "Add new card"),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Container(
        margin: const EdgeInsets.only(left: 12, top: 32),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ));
  }

  Widget _buildButtonAdd(IconData icon, String name) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: TextButton(
        style: TextButton.styleFrom(),
        onPressed: () {},
        child: Wrap(children: [
          Icon(
            icon,
            size: 28,
            color: Colors.blue,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          )
        ]),
      ),
    );
  }

  List<Widget> _buildListRadioButton() {
    List<Widget> radioButtons = [];
    for (DeliveryModel radio in _listDelivery) {
      radioButtons.add(Expanded(
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.blue, width: 2)),
          child: RadioListTile(
            activeColor: Colors.blue,
            controlAffinity: ListTileControlAffinity.trailing,
            isThreeLine: true,
            value: radio,
            groupValue: radio,
            title: Text(radio.title),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(radio.subtitle),
                Text("\$" + radio.price.toString()),
              ],
            ),
            onChanged: (currentDelivery) {},
            selected: false,
          ),
        ),
      ));
    }
    return radioButtons;
  }
}
