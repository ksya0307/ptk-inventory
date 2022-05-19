part of 'category_bloc.dart';

enum CategoryListStatus {
  pure,
  loadingInProgress,
  loadingFailed,
  loadingSuccess,
}

class CategoryState extends Equatable {
  final FormzStatus formStatus;
  final Name name;
  final Category? selectedCategory;
  final CategoryListStatus categoryListStatus;
  final List<Category> globalCategories;
  final List<Category> visibleList;

  const CategoryState({
    this.formStatus = FormzStatus.pure,
    this.name = const Name.pure(),
    this.categoryListStatus = CategoryListStatus.pure,
    this.selectedCategory,
    this.globalCategories = const [],
    this.visibleList = const [],
  });

  @override
  List<Object?> get props => [
        formStatus,
        name,
        categoryListStatus,
        selectedCategory,
        globalCategories,
        visibleList
      ];

  CategoryState copyWith({
    FormzStatus? formStatus,
    Name? name,
    Category? selectedCategory,
    CategoryListStatus? categoryListStatus,
    List<Category>? globalCategories,
    List<Category>? visibleList,
  }) {
    return CategoryState(
      formStatus: formStatus ?? this.formStatus,
      name: name ?? this.name,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoryListStatus: categoryListStatus ?? this.categoryListStatus,
      globalCategories: globalCategories ?? this.globalCategories,
      visibleList: visibleList ?? this.visibleList,
    );
  }
}
