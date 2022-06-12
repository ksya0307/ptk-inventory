import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:ptk_inventory/common/component/common_button.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';

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
        if (state.repairLoadingStatus == RepairLoadingStatus.loadingSuccess &&
            state.repairActionStatus == RepairActionStatus.shown) {
          final bytes = BlocProvider.of<RepairBloc>(context).state.document;
          print(bytes.isNotEmpty);
          _pdfController = PdfController(document: PdfDocument.openData(bytes));
          // print("${state.visibleList}");

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
                  formValidated: true,
                  buttonText: 'Сохранить или поделиться',
                  onPress: () {
                    print("Куку");
                  },
                )
              ],
            ),
          );
        }

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
      },
    );
  }
}
