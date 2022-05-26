import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/view/add_repair/add_repair_form.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/category.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/classroom.dart';
import 'package:ptk_inventory/repair/view/add_repair/filter/search_inventory_number.dart';

class AddRepairPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddRepairPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          tooltip: "Назад",
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: primaryBlue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: primaryBlue,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                builder: (_) {
                  return DraggableScrollableSheet(
                    expand: false,
                    builder: (context, controller) => ListView.builder(
                      controller: controller,
                      itemCount: 1,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        child: const Icon(
                                          Icons.arrow_back_rounded,
                                          color: primaryBlue,
                                        ),
                                      ),
                                      Expanded(
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          children: const [
                                            Spacer(),
                                            Text(
                                              "Фильтр",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: primaryBlue,
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const ChooseClassroom(),
                            const SizedBox(
                              height: 8,
                            ),
                            const ChooseCategory(),
                            const SearchInventoryNumber()
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: const [AddCategory()],
                            // ),
                            // const ApplyFilter()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
        title: const Text(
          "Акт приема-передачи",
          style: TextStyle(
            color: primaryBlue,
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
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
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AddRepairForm(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
