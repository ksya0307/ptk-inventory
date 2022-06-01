import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';
import 'package:ptk_inventory/ifo/repository/ifo_repository.dart';
import 'package:ptk_inventory/ifo/view/add_ifo/add_ifo_page.dart';
import 'package:ptk_inventory/ifo/view/ifo_form.dart';

class IfoPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => IfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          IfoBloc(ifoRepository: IfoRepository())..add(const IfoLoadList()),
      child: Scaffold(
        floatingActionButton:
            BlocBuilder<IfoBloc, IfoState>(builder: (context, state) {
          return FloatingActionButton(
            tooltip: "Добавить ИФО",
            child: const Icon(Icons.add_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => BlocProvider<IfoBloc>.value(
                  value: context.read<IfoBloc>(),
                  child: AddIfoPage(),
                ),
              ),
            ),
          );
        }),
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
          centerTitle: true,
          title: const Text(
            "ИФО",
            style: TextStyle(
              color: Colors.white,
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
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      children: const [
                        IfoForm(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
