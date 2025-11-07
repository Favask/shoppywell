
abstract class HomeEvent {
  const HomeEvent();

}

class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}

class RefreshHomeData extends HomeEvent {
  const RefreshHomeData();
}

class LoadMoreProducts extends HomeEvent {
  const LoadMoreProducts();
}

class SelectCategory extends HomeEvent {
  final String categoryId;

  const SelectCategory(this.categoryId);


} 