import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/domain/repositories/user/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignOutPressedEvent>((event, emit) async {
      await authRepository.signOut();
      emit(AuthStateUnauthenticated());
    });

    on<AuthCheckRequestedEvent>((event, emit) {
      final userOption = authRepository.getSignedInUser();
      userOption.fold(
        () => emit(AuthStateUnauthenticated()),
        (a) => emit(AuthStateAuthenticated()),
      );
    });
  }
}
