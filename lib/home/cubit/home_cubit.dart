import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workers_repository/workers_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(HomeTab tab) =>
      emit(HomeState(selectedTab: tab, workerToEdit: null));

  void editWorker(Worker worker) =>
      emit(HomeState(selectedTab: HomeTab.page2, workerToEdit: worker));
}
