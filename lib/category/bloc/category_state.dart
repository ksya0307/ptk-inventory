part of 'category_bloc.dart';

enum CategoryLoadingStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

class CategoryState extends Equatable {
  final FormzStatus formStatus;
  final Name name;
  final String searchText;
  final Category? selectedCategory;
  final CategoryLoadingStatus categoryLoadingStatus;
  final List<Category> globalCategories;
  final List<Category> visibleList;

  const CategoryState({
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
    Category? selectedCategory,
    CategoryLoadingStatus? categoryLoadingStatus,
    List<Category>? globalCategories,
    List<Category>? visibleList,
    String? searchText,
  }) {
    return CategoryState(
        formStatus: formStatus ?? this.formStatus,
        name: name ?? this.name,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        categoryLoadingStatus:
            categoryLoadingStatus ?? this.categoryLoadingStatus,
        globalCategories: globalCategories ?? this.globalCategories,
        visibleList: visibleList ?? this.visibleList,
        searchText: searchText ?? this.searchText);
  }
}
