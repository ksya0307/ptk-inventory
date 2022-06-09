import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';
import 'package:ptk_inventory/ifo/view/ifo_row.dart';
import 'package:ptk_inventory/ifo/view/ifo_visible_list.dart';
import 'package:ptk_inventory/ifo/view/update_ifo/update_ifo_page.dart';

class IfosList extends StatelessWidget {
  const IfosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ifos = BlocProvider.of<IfoBloc>(context).state.globalIfos;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: greyCard,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.0),
                  topRight: Radius.circular(7.0),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 16, bottom: 16),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          '№',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: blackLabels,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Наименование',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: blackLabels,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: greyCard,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7.0),
                  bottomRight: Radius.circular(7.0),
                ),
              ),
              child: BlocBuilder<IfoBloc, IfoState>(
                builder: (context, state) {
                  if (state.visibleList.isNotEmpty) {
                    return const VisibleIfoList();
                  }
                  if (state.searchText.isNotEmpty &&
                      state.visibleList.isEmpty) {
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                        ),
                                        child: Text(
                                          "ИФО не найдено",
                                          style: TextStyle(
                                            color: blackLabels,
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          alignment: WrapAlignment.center,
                                          // direction: Axis.vertical,
                                          children: [
                                            const Text(
                                              "Используйте",
                                              style: TextStyle(
                                                color: blackLabels,
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: primaryBlue,
                                                ),
                                                child: const Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              "для добавления нового ИФО",
                                              style: TextStyle(
                                                color: blackLabels,
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ifos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<IfoBloc>().add(
                                IfoSelected(
                                  Ifo(
                                    id: ifos[index].id,
                                    name: ifos[index].name,
                                  ),
                                ),
                              );
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BlocProvider.value(
                                value: context.read<IfoBloc>(),
                                child: UpdateIfoPage(),
                              ),
                            ),
                          );
                        },
                        child: IfoRow(
                          id: ifos[index].id.toString(),
                          ifo: ifos[index].name,
                          last: index == ifos.length - 1,
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
