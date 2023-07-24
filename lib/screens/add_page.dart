import 'dart:ui';

import 'package:drawer_listselect_checkbox/models/payment_model.dart';
import 'package:drawer_listselect_checkbox/screens/payment_cart.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _numberCard = TextEditingController();
  final _subTitle = TextEditingController();
  final _image = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _numberCard.dispose();
    _subTitle.dispose();
    _image.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new card page"), centerTitle: true),
      body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTextField("Number card", _numberCard),
              _buildTextField("Sub title", _subTitle),
              _buildTextField("Image", _image),
              _buildButton(context),
            ],
          )),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Flexible(
      child: OutlinedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PaymentCard(
                    instance: PaymentModel(
                        numberCard: _numberCard.text,
                        subTitle: _subTitle.text,
                        image: _image.text));
              }));
            } else {
              return null;
            }
          },
          child: const Text("Create")),
    );
  }

  Widget _buildTextField(String name, dynamic controller) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(left: 32, top: 16, bottom: 16),
        width: 300,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter content";
            }
          },
          controller: controller,
          decoration: InputDecoration(labelText: name),
        ),
      ),
    );
  }
}
