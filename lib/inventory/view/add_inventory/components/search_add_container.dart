import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/components/add_container.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/components/search_container.dart';

class SearchAddContainer extends StatelessWidget {
  const SearchAddContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: Container(
        decoration: const BoxDecoration(
          color: greyCard,
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        child: SizedBox(
          height: 100,
          width: 260,
          // child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(child:  SearchContainer()),
              SizedBox(
                height: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                  ),
                ),
              ),
              const Expanded(child:  AddContainer())
            ],
          ),
        ),
      ),
    );
  }
}
