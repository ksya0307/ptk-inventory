part of 'category_bloc.dart';

enum CategoryLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

enum CategoryDeleteStatus {
  pure,
  deleted,
  notDeleted,
  deletedFromGlobal,
  savedOnGlobal,
  saved,
  notSaved,
  added,
  notAdded,
  addedToGlobal,
}

class CategoryState extends Equatable {
  final FormzStatus formStatus;
  final Name name;
  final String searchText;
  final Category? selectedCategory;
  final CategoryLoadingStatus categoryLoadingStatus;
  final List<Category> globalCategories;
  final List<Category> visibleList;
  final CategoryDeleteStatus categoryDeleteStatus;

  const CategoryState({
    this.categoryDeleteStatus = CategoryDeleteStatus.pure,
    this.formStatus = FormzStatus.pure,
    this.name = const Name.pure(),
    this.categoryLoadingStatus = CategoryLoadingStatus.pure,
    this.selectedCategory,
    this.globalCategories = const [],
    this.visibleList = const [],
    this.searchText = "",
  });

  @override
  List<Object?> get props => [
        categoryDeleteStatus,
        formStatus,
        name,
        categoryLoadingStatus,
        selectedCategory,
        globalCategories,
        visibleList,
        searchText
      ];

  CategoryState copyWith({
    FormzStatus? formStatus,
    Name? name,
    String? searchText,
    Category? selectedCategory,
    CategoryLoadingStatus? categoryLoadingStatus,
    List<Category>? globalCategories,
    List<Category>? visibleList,
    CategoryDeleteStatus? categoryDeleteStatus,
  }) {
    return CategoryState(
      formStatus: formStatus ?? this.formStatus,
      name: name ?? this.name,
      searchText: searchText ?? this.searchText,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoryLoadingStatus:
          categoryLoadingStatus ?? this.categoryLoadingStatus,
      globalCategories: globalCategories ?? this.globalCategories,
      visibleList: visibleList ?? this.visibleList,
      categoryDeleteStatus: categoryDeleteStatus ?? this.categoryDeleteStatus,
    );
  }
}
