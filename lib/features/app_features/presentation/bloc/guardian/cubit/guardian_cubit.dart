import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'guardian_state.dart';

class GuardianCubit extends Cubit<GuardianState> {
  GuardianCubit() : super(GuardianInitial());
}
