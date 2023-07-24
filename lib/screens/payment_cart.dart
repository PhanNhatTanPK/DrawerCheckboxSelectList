import 'package:drawer_listselect_checkbox/models/payment_model.dart';
import 'package:drawer_listselect_checkbox/screens/add_page.dart';
import 'package:flutter/material.dart';

import '../models/delivery_model.dart';

class PaymentCard extends StatefulWidget {
  PaymentCard({Key? key, this.instance}) : super(key: key);

  PaymentModel? instance;
  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  late List<DeliveryModel> _listDelivery;
  late List<PaymentModel> _listPayment;

  late DeliveryModel selectedDelivery;
  late PaymentModel selectedPayment;

  static bool _isPressed = true;

  @override
  void initState() {
    super.initState();
    _listDelivery = DeliveryModel.getInfo();
    _listPayment = PaymentModel.getInfo();
    selectedDelivery = _listDelivery.first;
    selectedPayment = _listPayment.first;
  }

  setSelectedDelivery(DeliveryModel delivery) {
    setState(() {
      selectedDelivery = delivery;
    });
  }

  setSelectedPayment(PaymentModel payment) {
    setState(() {
      selectedPayment = payment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_buildDelivery(), _buildPayment()],
      ),
    );
  }

  Widget _buildDelivery() {
    return Wrap(
      children: [
        _buildTitle("Delivery method"),
        Row(children: _buildListDelivery()),
      ],
    );
  }

  Widget _buildPayment() {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle("Payment method"),
            _buildButtonAdd(Icons.add, "Add new card"),
          ],
        ),
        Row(children: _buildListPayment()),
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
      margin: const EdgeInsets.only(top: 32),
      child: TextButton(
        style: TextButton.styleFrom(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddPage();
          }));
        },
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

  List<Widget> _buildListDelivery() {
    List<Widget> radioButtons = [];

    for (DeliveryModel radio in _listDelivery) {
      radioButtons.add(Expanded(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: radio.state ? Colors.blue : Colors.black, width: 2)),
          child: RadioListTile<DeliveryModel>(
            selectedTileColor: Color.fromARGB(255, 218, 234, 248),
            activeColor: Colors.blue,
            controlAffinity: ListTileControlAffinity.trailing,
            isThreeLine: true,
            value: radio,
            groupValue: selectedDelivery,
            title: Text(radio.title, style: styleTitle(radio.state)),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  radio.subtitle,
                  style: styleSubTitle(radio.state),
                ),
                Text(
                  "\$" + radio.price.toString(),
                  style: styleTitle(radio.state),
                ),
              ],
            ),
            onChanged: (currentDelivery) {
              setState(() {
                setSelectedDelivery(currentDelivery!);
                for (radio in _listDelivery) {
                  radio.state = false;
                }
                currentDelivery.state = true;
                radio = currentDelivery;
              });
            },
            selected: selectedDelivery == radio,
          ),
        ),
      ));
    }
    return radioButtons;
  }

  List<Widget> _buildListPayment() {
    if (widget.instance != null && !_listPayment.contains(widget.instance)) {
      _listPayment.add(widget.instance!);
    }

    List<Widget> radioButtons = [];
    for (PaymentModel radio in _listPayment) {
      radioButtons.add(Expanded(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: radio.state ? Colors.blue : Colors.black, width: 2)),
          child: RadioListTile(
            splashRadius: BorderSide.strokeAlignOutside,
            selectedTileColor: Color.fromARGB(255, 218, 234, 248),
            activeColor: Colors.blue,
            controlAffinity: ListTileControlAffinity.trailing,
            isThreeLine: true,
            value: radio,
            groupValue: selectedPayment,
            title: Wrap(children: [
              Text(
                "**** ",
                style: styleTitle(radio.state),
              ),
              Text(
                radio.numberCard.split(" ").last,
                style: styleTitle(radio.state),
              ),
            ]),
            subtitle: Text(
              radio.subTitle,
              style: styleSubTitle(radio.state),
            ),
            secondary: Image(
              image: NetworkImage(radio.image),
              width: 64,
              height: 32,
            ),
            onChanged: (currentPayment) {
              setState(() {
                setSelectedPayment(currentPayment!);
                for (radio in _listPayment) {
                  radio.state = false;
                }
                currentPayment.state = true;
                radio = currentPayment;
              });
            },
            selected: selectedPayment == radio,
          ),
        ),
      ));
    }
    return radioButtons;
  }

  TextStyle? styleTitle(bool isPressed) {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: isPressed ? Colors.blue : Colors.black);
  }

  TextStyle? styleSubTitle(bool isPressed) {
    return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isPressed
            ? const Color.fromARGB(255, 121, 183, 233)
            : const Color.fromARGB(255, 218, 191, 191));
  }
}
