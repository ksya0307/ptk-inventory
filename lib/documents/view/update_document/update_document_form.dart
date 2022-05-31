import 'package:flutter/material.dart';
import 'package:ptk_inventory/common/component/property_label.dart';

import 'package:ptk_inventory/documents/view/update_document/document_delete_button.dart';
import 'package:ptk_inventory/documents/view/update_document/document_name_input.dart';
import 'package:ptk_inventory/documents/view/update_document/document_save_button.dart';

class UpdateDocumentForm extends StatelessWidget {
  const UpdateDocumentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            PropertyLabel(property: 'Название', bottomPadding: 8),
            DocumentNameInput(),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: SaveDocumentButton(),
            ),
          ],
        ),
        Column(
          children: const [DeleteDocumentButton()],
        )
      ],
    );
  }
}
