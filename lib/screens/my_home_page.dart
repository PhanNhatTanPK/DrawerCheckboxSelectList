import 'package:drawer_listselect_checkbox/screens/checkbox.dart';
import 'package:drawer_listselect_checkbox/screens/component.dart';
import 'package:drawer_listselect_checkbox/screens/payment_cart.dart';
import 'package:drawer_listselect_checkbox/screens/personal_info.dart';
import 'package:flutter/material.dart';
import '../models/drawer_model.dart';
import 'account.dart';
import 'security.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomwPageState();
}

class _MyHomwPageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const BuildDrawer(),
      drawerScrimColor: Colors.transparent,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Drawer - Checkbox - List Select"),
      centerTitle: true,
    );
  }
}

class BuildDrawer extends StatefulWidget {
  const BuildDrawer({super.key});

  @override
  State<BuildDrawer> createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  final List<DrawerModel> _listDrawerModel = [
    DrawerModel(Icons.account_circle_outlined, "Account", []),
    DrawerModel(Icons.account_circle_outlined, "Account", []),
    DrawerModel(Icons.person_2_outlined, "Personal info", []),
    DrawerModel(Icons.settings, "Settings", [
      "Components",
      "Security",
      "Verification Check",
      "Apperance",
      "Preferences",
      "System updates"
    ]),
    DrawerModel(Icons.payment_sharp, "Payment&Cards", []),
    DrawerModel(Icons.check_box_sharp, "Checkbox", []),
  ];

  int _selectedIndex = -1;

  bool _isExpended = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: _buildRow(),
    );
  }

  Widget _buildRow() {
    return Row(
      children: [
        _isExpended ? _buildLargeMenu() : _buildSmallMenu(),
        _buildHiddenMenu(),
      ],
    );
  }

  Widget _buildLargeMenu() {
    return Container(
      width: 300,
      color: const Color.fromARGB(255, 211, 218, 221),
      child: ListView.builder(
          itemCount: _listDrawerModel.length,
          itemBuilder: (context, index) {
            DrawerModel list = _listDrawerModel[index];
            bool selected = _selectedIndex == index;

            if (index == 0) return Container();
            return ExpansionTile(
                backgroundColor: Colors.white,
                onExpansionChanged: (z) {
                  setState(() {
                    _selectedIndex = z ? index : -1;
                  });
                },
                leading: Icon(
                  list.icon,
                  color: Colors.black,
                ),
                title: list.subMenu.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          onClickTitle(list.title);
                        },
                        child: Text(list.title))
                    : Text(list.title),
                trailing: list.subMenu.isEmpty
                    ? const SizedBox()
                    : Icon(
                        selected
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.blue,
                      ),
                children: list.subMenu.map((subMenu) {
                  return _subMenuButtonForLargeMenu(subMenu, false);
                }).toList());
          }),
    );
  }

  Widget _buildSmallMenu() {
    return Container(
      width: 100,
      color: const Color.fromARGB(153, 231, 228, 228),
      child: ListView.builder(
          itemCount: _listDrawerModel.length,
          itemBuilder: (context, index) {
            if (index == 0) return controlButton();
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 45,
                child: Icon(
                  _listDrawerModel[index].icon,
                  color: Colors.black,
                ),
              ),
            );
          }),
    );
  }

  Widget _buildHiddenMenu() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: _isExpended ? 0 : 175,
      color: Colors.transparent,
      child: ListView.builder(
          itemCount: _listDrawerModel.length,
          itemBuilder: (context, index) {
            DrawerModel list = _listDrawerModel[index];
            if (index == 0) {
              return Container(
                height: 100,
              );
            }

            bool selected = _selectedIndex == index;
            bool isValid = selected && list.subMenu.isNotEmpty;
            return _buildSubMenu([list.title]..addAll(list.subMenu), isValid);
          }),
    );
  }

  Widget _buildSubMenu(List<String> subMenus, bool isValid) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: isValid ? subMenus.length.toDouble() * 30 : 45,
      decoration: BoxDecoration(
          color: isValid
              ? const Color.fromARGB(255, 209, 224, 217)
              : Colors.transparent,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(6), bottomRight: Radius.circular(6))),
      child: ListView.builder(
          itemCount: isValid ? subMenus.length : 0,
          itemBuilder: (context, index) {
            String subMenu = subMenus[index];
            return _subMenuButton(subMenu, index == 0);
          }),
    );
  }

  Widget _subMenuButton(String subMenu, bool isTitle) {
    return InkWell(
      onTap: () {
        onClickSubMenu(subMenu);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(subMenu,
                style: TextStyle(
                    fontSize: isTitle ? 17 : 14,
                    fontWeight: isTitle ? FontWeight.w700 : FontWeight.normal,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _subMenuButtonForLargeMenu(String subMenu, bool isTitle) {
    return InkWell(
      onTap: () {
        onClickSubMenu(subMenu);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                  color: const Color.fromARGB(255, 211, 218, 221)),
              padding: const EdgeInsets.only(left: 55, top: 8, bottom: 8),
              child: Text(subMenu,
                  style: TextStyle(
                    fontSize: isTitle ? 17 : 14,
                    fontWeight: isTitle ? FontWeight.w700 : FontWeight.normal,
                    color: Colors.black,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _hiddenMenu() {
  //   return Container(
  //     height: 45,
  //     color: Color.fromARGB(255, 213, 214, 216),
  //   );
  // }

  Widget controlButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: InkWell(
        onTap: expandOrSkink,
        child: Container(
          height: 45,
          child: const FlutterLogo(),
        ),
      ),
    );
  }

  void expandOrSkink() {
    setState(() {
      _isExpended = !_isExpended;
    });
  }

  void onClickTitle(String title) {
    switch (title) {
      case "Account":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const Account())));
      case "Personal info":
        Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => const PersonalInfo())));
        break;
      case "Payment&Cards":
        Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => const PaymentCard())));
      case "Checkbox":
        Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => const MyCheckBox())));
      default:
        null;
    }
  }

  void onClickSubMenu(String subMenu) {
    switch (subMenu) {
      case "Components":
        Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => const Components())));
      case "Security":
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const Security())));
        break;
      default:
        null;
    }
  }
}
