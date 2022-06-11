import 'dart:async';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:aspose_words_cloud/aspose_words_cloud.dart';
import 'package:bloc/bloc.dart';
import 'package:docx_template/docx_template.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/repair/model/phone.dart';

import 'package:ptk_inventory/repair/model/problem.dart';
import 'package:ptk_inventory/repair/model/repair_equipment.dart';
import 'package:ptk_inventory/repair/model/request/create_repair_equipment_request.dart';
import 'package:ptk_inventory/repair/model/request/create_repair_request.dart';
import 'package:ptk_inventory/repair/repository/repair_repository.dart';

part 'repair_event.dart';
part 'repair_state.dart';

class RepairBloc extends Bloc<RepairEvent, RepairState> {
  RepairBloc({required RepairRepository repairRepository})
      : _repairRepository = repairRepository,
        super(RepairState()) {
    on<RepairProblemChanged>(_onProblemChanged);
    on<RepairDateTimeChanged>(_onDateTimeChanged);
    on<RepairPhoneChanged>(_onPhoneChanged);
    on<RepairEquipmentChanged>(_onEquipmentChanged);

    on<RepairSaveToList>(_onSaveToList);
    on<RepairDeleteFromList>(_onDeleteFromList);

    on<RepairSearch>(_onSearch);

    on<RepairLoadList>(_onRepairLoadList);
    on<RepairUserLoadList>(_onUserRepairLoadList);

    on<RepairSubmitted>(_onSubmitted);
    // on<RepairSaved>(_onSaved);
    // on<RepairmDeleted>(_onDeleted);
    // on<RepairSelected>(onSelected);
  }

  final RepairRepository _repairRepository;

  void _onSaveToList(RepairSaveToList event, Emitter<RepairState> emit) {}

  void _onDeleteFromList(
      RepairDeleteFromList event, Emitter<RepairState> emit) {}

  void _onSearch(RepairSearch event, Emitter<RepairState> emit) {}

//    Future<void> _onSaved(RepairSaved event, Emitter<RepairState> emit) {
//   }

//  Future<void> _onDeleted(RepairmDeleted event, Emitter<RepairState> emit) {
//   }

//  Future<void> onSelected(RepairSelected event, Emitter<RepairState> emit) {

//   }

  Future<void> _onRepairLoadList(
    RepairLoadList event,
    Emitter<RepairState> emit,
  ) async {
    emit(
      state.copyWith(
        repairLoadingStatus: RepairLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _repairRepository.allRepairEquipment();
    if (waiting.isNotEmpty) {
      waiting.sort((a, b) => a.repair.datetime.compareTo(b.repair.datetime));
    }
    emit(
      state.copyWith(
        globalRepairEquipment: waiting,
        repairLoadingStatus: RepairLoadingStatus.loadingSuccess,
      ),
    );
  }

  Future<void> _onUserRepairLoadList(
    RepairUserLoadList event,
    Emitter<RepairState> emit,
  ) async {
    emit(
      state.copyWith(
        repairLoadingStatus: RepairLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _repairRepository.userRepair();
    if (waiting.isNotEmpty) {
      waiting.sort((a, b) => a.repair.datetime.compareTo(b.repair.datetime));
    }
    emit(
      state.copyWith(
        globalRepairEquipment: waiting,
        repairLoadingStatus: RepairLoadingStatus.loadingSuccess,
      ),
    );
  }

  Future<void> _onSubmitted(
    RepairSubmitted event,
    Emitter<RepairState> emit,
  ) async {
    const clientId = 'cafd6028-1fe6-48a1-9dfe-dca4943bafb4';
    const secret = 'b236dde543188e1c512de2d75a4905e9';
    final configuration = Configuration(clientId, secret);
    final wordsApi = WordsApi(configuration);

    emit(
      state.copyWith(
        formStatus: FormzStatus.submissionInProgress,
      ),
    );
    if (state.formStatus.isValidated) {
      final repair = await _repairRepository.createRepair(
        repairModelRequest:
            CreateRepairModelRequest(state.phone.value, state.dateTime!),
      );
      if (repair != null) {
        final waiting = await _repairRepository.createRepairEquipment(
          createRepairEquipmentModelRequest: CreateRepairEquipmentModelRequest(
            repair.id,
            state.selectedEquipment!.id,
            state.problem.value,
          ),
        );
        if (waiting == RepairStatus.notcreated) {
          emit(
            state.copyWith(
              formStatus: FormzStatus.submissionFailure,
              repairActionStatus: RepairActionStatus.notAdded,
            ),
          );
        } else {
          final dir = await getApplicationDocumentsDirectory();
          final data = await rootBundle.load('template.docx');
          final bytes = data.buffer.asUint8List();

          final docx = await DocxTemplate.fromBytes(bytes);
          final Content c = Content();
          c
            ..add(
              TextContent(
                "day",
                DateFormat('d').format(state.dateTime!).isEmpty
                    ? DateFormat('d').format(DateTime.now())
                    : DateFormat('d').format(state.dateTime!),
              ),
            )
            ..add(
              TextContent(
                "month",
                DateFormat('MM').format(state.dateTime!).isEmpty
                    ? DateFormat('MM').format(DateTime.now())
                    : DateFormat('MM').format(state.dateTime!),
              ),
            )
            ..add(
              TextContent(
                "year",
                DateFormat('y').format(state.dateTime!).isEmpty
                    ? DateFormat('y').format(DateTime.now())
                    : DateFormat('y').format(state.dateTime!),
              ),
            )
            ..add(
              TextContent(
                "surname",
                state.selectedEquipment!.classroom.user.surname,
              ),
            )
            ..add(
              TextContent(
                "name",
                state.selectedEquipment!.classroom.user.name,
              ),
            )
            ..add(
              TextContent(
                "patronymic",
                state.selectedEquipment!.classroom.user.patronymic!.isEmpty
                    ? ""
                    : state.selectedEquipment!.classroom.user.patronymic,
              ),
            )
            ..add(
              TextContent(
                "classroom",
                state.selectedEquipment!.classroom.number,
              ),
            )
            ..add(TextContent("phone", state.phone.value))
            ..add(
              TableContent(
                "table",
                [
                  RowContent()
                    ..add(
                      TextContent("id", state.selectedEquipment!.id),
                    )
                    ..add(
                      TextContent(
                        "quantity",
                        "1",
                      ),
                    )
                    ..add(
                      TextContent(
                        "classroomEquipment",
                        "Инвентарный номер:\n${state.selectedEquipment!.inventoryNumber} \n${state.selectedEquipment!.equipment.description}",
                      ),
                    )
                    ..add(
                      TextContent("problem", state.problem.value),
                    ),
                ],
              ),
            );

          final d = await docx.generate(c);
          var status = await Permission.storage.status;
          if (!status.isGranted) {
            await Permission.storage.request();
          }
          if (await Permission.storage.isGranted) {
            final of = File('${dir.path}/generated.docx');
            if (d != null) await of.writeAsBytes(d);

            final requestDocument =
                (await File('${dir.path}/generated.docx').readAsBytes())
                    .buffer
                    .asByteData();
            final convertRequest =
                ConvertDocumentRequest(requestDocument, 'pdf');
            final newFile = await wordsApi.convertDocument(convertRequest);

            final uploadReq = UploadFileRequest(
              newFile,
              'Акт приема-передачи оборудования в ремонт.pdf',
            );
            await wordsApi.uploadFile(uploadReq);

            final downloadRequest = DownloadFileRequest(
                'Акт приема-передачи оборудования в ремонт.pdf');
            await wordsApi.downloadFile(downloadRequest);

            print(status);

            final buffer = newFile.buffer;
            final Directory tempDir = Platform.isAndroid
                ? Directory('/storage/emulated/0/Download')
                : await getApplicationSupportDirectory();

            File('${tempDir.path}/Акт приема-передачи ${DateTime.now()}.pdf')
                .writeAsBytes(
              buffer.asUint8List(
                newFile.offsetInBytes,
                newFile.lengthInBytes,
              ),
            );
          }

          emit(
            state.copyWith(
              formStatus: FormzStatus.submissionSuccess,
              repairActionStatus: RepairActionStatus.added,
            ),
          );
        }
      }
    }
  }

  void _onEquipmentChanged(
    RepairEquipmentChanged event,
    Emitter<RepairState> emit,
  ) {
    emit(
      state.copyWith(
        selectedEquipment: event.selectedEquipment,
        formStatus: Formz.validate([state.problem, state.phone]),
      ),
    );
  }

  void _onPhoneChanged(
    RepairPhoneChanged event,
    Emitter<RepairState> emit,
  ) {
    final phone = Phone.dirty(event.phone);
    emit(
      state.copyWith(
        phone: phone,
        formStatus: Formz.validate([phone, state.problem]),
      ),
    );
  }

  void _onDateTimeChanged(
    RepairDateTimeChanged event,
    Emitter<RepairState> emit,
  ) {
    print(event.dateTime);
    emit(
      state.copyWith(
        dateTime: event.dateTime,
        formStatus: Formz.validate([state.problem, state.phone]),
      ),
    );
  }

  void _onProblemChanged(
    RepairProblemChanged event,
    Emitter<RepairState> emit,
  ) {
    final problem = Problem.dirty(event.problem);
    emit(
      state.copyWith(
        problem: problem,
        formStatus: Formz.validate(
          [
            problem,
            state.phone,
          ],
        ),
      ),
    );
  }
}
