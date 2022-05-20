import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/category/model/name.dart';
import 'package:ptk_inventory/category/repository/category_repository.dart';
import 'package:ptk_inventory/common/model/requests/general_request.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(const CategoryState()) {
    on<CategoryNameChanged>(_onNameChanged);
    on<CategoryLoadList>(_onCategoryLoadList);
    on<CategorySubmitted>(_onSubmitted);
    on<CategorySaved>(_onSaved);
    on<CategorySearch>(_onSearch);
    on<CategoryDeleted>(_onDeleted);
  }

  final CategoryRepository _categoryRepository;

  void _onSearch(
    CategorySearch event,
    Emitter<CategoryState> emit,
  ) {
    // filter from gloabl list where name contains event.matchingWord
    // and return that list to the state
    final filteredList = state.globalCategories
        .where((category) => category.name.contains(event.matchingWord))
        .toList();
    emit(
      state.copyWith(
        visibleList: filteredList,
      ),
    );
  }

  Future<void> _onDeleted(
    CategoryDeleted event,
    Emitter<CategoryState> emit,
  ) async {
    emit(
      state.copyWith(
        categoryLoadingStatus: CategoryLoadingStatus.loadingInProgress,
      ),
    );
    final waiting =
        await _categoryRepository.deleteCategory(state.selectedCategory!.id);
    if (waiting == CategoryStatus.deleted) {
      emit(
        state.copyWith(
          categoryLoadingStatus: CategoryLoadingStatus.loadingSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          categoryLoadingStatus: CategoryLoadingStatus.loadingFailed,
        ),
      );
    }
  }

  Future<void> _onCategoryLoadList(
    CategoryLoadList event,
    Emitter<CategoryState> emit,
  ) async {
    emit(
      state.copyWith(
        categoryLoadingStatus: CategoryLoadingStatus.loadingInProgress,
      ),
    );
    final waiting = await _categoryRepository.categories();
    if (waiting.isNotEmpty) {
      // filter the list by the accending id of the category
      waiting.sort((a, b) => a.id.compareTo(b.id));
    }

    emit(
      state.copyWith(
        globalCategories: waiting,
        categoryLoadingStatus: CategoryLoadingStatus.loadingSuccess,
      ),
    );
  }

  void _onNameChanged(
    CategoryNameChanged event,
    Emitter<CategoryState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        formStatus: Formz.validate(
          [name],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    CategorySubmitted event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _categoryRepository.createCategory(
        GeneralModelRequest(name: state.name.value),
      );
      if (waiting == CategoryStatus.notcreated) {
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      } else {
        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      }
    }
  }

  Future<void> _onSaved(
    CategorySaved event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    if (state.formStatus.isValidated) {
      final waiting = await _categoryRepository.changeCategory(
        state.selectedCategory!.id,
        GeneralModelRequest(name: state.selectedCategory!.name),
      );
      if (waiting == CategoryStatus.unchanged) {
        emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      } else {
        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      }
    }
  }
}
