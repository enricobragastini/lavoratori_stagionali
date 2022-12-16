part of 'home_cubit.dart';

enum HomeTab { page1, page2 }

class HomeState extends Equatable {
  const HomeState({this.selectedTab = HomeTab.page1});

  final HomeTab selectedTab;

  @override
  List<Object> get props => [selectedTab];
}
