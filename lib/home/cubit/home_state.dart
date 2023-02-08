part of 'home_cubit.dart';

enum HomeTab { page1, page2 }

class HomeState extends Equatable {
  const HomeState({this.selectedTab = HomeTab.page1, this.workerToEdit});

  final HomeTab selectedTab;
  final Worker? workerToEdit;

  @override
  List<Object> get props => [selectedTab];
}
