part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryNameChanged extends CategoryEvent {
  final String name;

  const CategoryNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class CategoryLoadList extends CategoryEvent {
  const CategoryLoadList();
}

class CategorySubmitted extends CategoryEvent {
  const CategorySubmitted();
}

class CategorySaved extends CategoryEvent {
  const CategorySaved();
}

class CategorySearch extends CategoryEvent {
  const CategorySearch({
    required this.matchingWord,
  });
  final String matchingWord;
}

class CategoryDeleted extends CategoryEvent {
  const CategoryDeleted();
}
