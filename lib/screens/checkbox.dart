import 'package:drawer_listselect_checkbox/widgets/my_checkbox.dart';
import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  // final CheckboxModel _allCheck = CheckboxModel(title: "Additons");

  // final _checks = [
  //   CheckboxModel(title: "Pickles"),
  //   CheckboxModel(title: "Tomato"),
  //   CheckboxModel(title: "Lettuce"),
  //   CheckboxModel(title: "Cheese"),
  // ];

  final List<Text> _list = [
    const Text("Pickles"),
    const Text("Tomato"),
    const Text("Lettuce"),
    const Text("Cheese"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Checkbox Page"),
          centerTitle: true,
          leading: const BackButton(),
        ),
        body: Column(
          children: [
            Flexible(
                child: Container(
                    padding: const EdgeInsets.only(top: 32, left: 14),
                    alignment: Alignment.centerLeft,
                    height: 52,
                    child: const Text(
                      "Meal options",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ))),
            Expanded(
              child: CustomCheckbox(
                parent: const Text("Additions"),
                children: _list,
                childrenCheckboxColor: Colors.blue,
                parentCheckboxColor: Colors.blue,
              ),
            ),
          ],
        ));
  }
  //         body: ListView(
  //           children: [
  //             _buildGroupCheckbox(_allCheck),
  //             ..._checks.map(_buildSingleCheckbox).toList(),
  //           ],
  //         ),
  //       );

  //   ));
  // }

  // Widget _buildSingleCheckbox(CheckboxModel checkbox) {
  //   return CheckboxListTile(
  //       activeColor: Colors.blue,
  //       controlAffinity: ListTileControlAffinity.leading,
  //       value: checkbox.value,
  //       title: Text(checkbox.title),
  //       onChanged: ((value) {
  //         setState(() {
  //           checkbox.value = value!;
  //           _allCheck.value = _checks.every((check) => check.value);
  //         });
  //       }));
  // }

  // Widget _buildGroupCheckbox(CheckboxModel checkbox) {
  //   return CheckboxListTile(
  //     activeColor: Colors.blue,
  //     controlAffinity: ListTileControlAffinity.leading,
  //     value: checkbox.value,
  //     title: Text(checkbox.title),
  //     onChanged: toggleGroup,
  //   );
  // }

  // void toggleGroup(bool? value) {
  //   if (value == null) return;
  //   setState(() {
  //     _allCheck.value = value;
  //     _checks.forEach((check) => check.value = value);
  //   });
  // }
}
