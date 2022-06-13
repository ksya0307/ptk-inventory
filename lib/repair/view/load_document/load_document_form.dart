import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/common/component/filter_scrollable_sheet.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';
import 'package:ptk_inventory/repair/model/repair.dart';
import 'package:share_plus/share_plus.dart';

class LoadDocumentForm extends StatefulWidget {
  const LoadDocumentForm({Key? key}) : super(key: key);

  @override
  State<LoadDocumentForm> createState() => _LoadDocumentFormState();
}

class _LoadDocumentFormState extends State<LoadDocumentForm> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairBloc, RepairState>(
      builder: (context, state) {
        if (state.repairLoadingStatus ==
            RepairLoadingStatus.loadingInProgress) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Загрузка акта приема передачи...",
                      style: TextStyle(
                        color: greyDark,
                        fontFamily: 'Rubik',
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }

        if (state.repairLoadingStatus == RepairLoadingStatus.loadingSuccess ||
            state.repairActionStatus == RepairActionStatus.shown) {
          final bytes = BlocProvider.of<RepairBloc>(context).state.document;

          _pdfController = PdfController(document: PdfDocument.openData(bytes));

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 6,
                  shadowColor: greyShadow,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: PdfView(
                      builders: PdfViewBuilders<DefaultBuilderOptions>(
                        options: const DefaultBuilderOptions(),
                        documentLoaderBuilder: (_) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text(
                                      "Загрузка акта приема-передачи...",
                                      style: TextStyle(
                                        color: greyDark,
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        pageLoaderBuilder: (_) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CircularProgressIndicator(),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text(
                                        "Загрузка акта приема-передачи...",
                                        style: TextStyle(
                                          color: greyDark,
                                          fontFamily: 'Rubik',
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        errorBuilder: (_, error) =>
                            const Center(child: Text(" 1 Что-то пошло не так")),
                      ),
                      controller: _pdfController,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CommonButton(
                  fontSize: 16,
                  formValidated: true,
                  buttonText: 'Сохранить или поделиться',
                  onPress: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<RepairBloc>(),
                          child: EquipmentFilterSheet(
                            initialChildSize: 0.3,
                            minChildSize: 0.3,
                            maxChildSize: 0.3,
                            title: '',
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocListener<RepairBloc, RepairState>(
                                  listener: (context, state) {
                                    if (state.repairActionStatus ==
                                            RepairActionStatus.downloaded &&
                                        state.repairActionStatus ==
                                            RepairLoadingStatus
                                                .loadingSuccess) {
                                      Navigator.of(context).pop();

                                      Fluttertoast.showToast(
                                        msg:
                                            'Downloads/Акт приема-передачи ${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())}.pdf',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.blueGrey,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  },
                                  child: BlocBuilder<RepairBloc, RepairState>(
                                    builder: (context, state) {
                                      return InkWell(
                                        onTap: () {
                                          context
                                              .read<RepairBloc>()
                                              .add(const RepairSaveDocument());
                                        },
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.download_rounded,
                                                  color: blueCustom,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                  "Сохранить",
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    color: blackLabels,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Divider(
                                    color: greyDivider,
                                    thickness: .75,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final tempDir =
                                        await getApplicationDocumentsDirectory();

                                    await Share.shareFiles(
                                      [
                                        "${tempDir.path}/Акт приема-передачи ${DateFormat('dd-MM-yyyy HH:mm:ss').format(state.repair!.datetime)}.pdf"
                                      ],
                                      text:
                                          "${state.selectedEquipment!.inventoryNumber} Акт приема-передачи ${DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now())}",
                                    );
                                  },
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.share_rounded,
                                            color: blueCustom,
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            "Поделиться",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: blackLabels,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const Text("Что-то пошло не так, повторите попытку");
      },
    );
  }
}
