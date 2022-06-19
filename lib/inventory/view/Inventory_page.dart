import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/inventory/repository/inventory_repository.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/add_inventory_page.dart';
import 'package:ptk_inventory/inventory/view/inventory_form.dart';

class InventoryPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => InventoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InventoryBloc(inventoryRepository: InventoryRepository())
            ..add(const InventoryLoadList()),
      child: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              tooltip: "Принять к учету",
              child: const Icon(Icons.add_rounded),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<InventoryBloc>(),
                    child: AddInventoryPage(),
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              leading: IconButton(
                tooltip: "Назад",
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              elevation: 0,
              title: const Text(
                'Учет оборудования',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints view) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: view.maxHeight,
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                        children: const [
                          InventoryForm(
                            firstFlex: 2,
                            firstFlexRow: 2,
                            secondFlex: 5,
                            secondFlexRow: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
