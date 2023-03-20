import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:weight_tracker/application/auth/authbloc/auth_bloc.dart';
import 'package:weight_tracker/application/auth/loginform/login_form_bloc.dart';
import 'package:weight_tracker/application/auth/registerform/register_form_bloc.dart';
import 'package:weight_tracker/application/user/appUserForm/app_user_form_bloc.dart';
import 'package:weight_tracker/application/user/controller/controller_bloc.dart';
import 'package:weight_tracker/application/user/observer/observer_bloc.dart';
import 'package:weight_tracker/application/weight/controller/controller_bloc.dart'
    as weight;
import 'package:weight_tracker/application/weight/observer/observer_bloc.dart'
    as weight;
import 'package:weight_tracker/application/weight/weightForm/weight_form_bloc.dart';
import 'package:weight_tracker/application/weightGoal/controller/weight_goal_controller_bloc.dart';
import 'package:weight_tracker/application/weightGoal/observer/weight_goal_observer_bloc.dart';
import 'package:weight_tracker/application/weightGoal/weightGoalForm/weight_goal_form_bloc.dart';
import 'package:weight_tracker/domain/repositories/user/app_user_repository.dart';
import 'package:weight_tracker/domain/repositories/user/auth_repository.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_goal_repository.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_repository.dart';
import 'package:weight_tracker/infrastructure/repositories/user/app_user_repository_impl.dart';
import 'package:weight_tracker/infrastructure/repositories/user/auth_repository_impl.dart';
import 'package:weight_tracker/infrastructure/repositories/weight/weight_goal_repository_impl.dart';
import 'package:weight_tracker/infrastructure/repositories/weight/weight_repository_impl.dart';

final sl = GetIt.I;

Future<void> init() async {
  //? ########## Register ##########
  //! state management
  sl.registerFactory(() => RegisterFormBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  //! repos
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

  //! extern
  final fireBaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => fireBaseAuth);

  //? ########## Login ##########
  //! state management
  sl.registerFactory(() => LoginFormBloc(authRepository: sl()));

  //? ########## Weight ##########
  //! state management
  sl.registerFactory(() => weight.ObserverBloc(weightRepository: sl()));
  sl.registerFactory(() => weight.ControllerBloc(weightRepository: sl()));
  sl.registerFactory(() => WeightFormBloc(weightRepository: sl()));

  //! repos
  sl.registerLazySingleton<WeightRepository>(
      () => WeightRepositoryImpl(firestore: sl()));

  //! extern
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => fireStore);

  //? ########## AppUser ##########
  //! state management
  sl.registerFactory(() => ObserverBloc(appUserRepository: sl()));
  sl.registerFactory(() => ControllerBloc(appUserRepository: sl()));
  sl.registerFactory(() => AppUserFormBloc(appUserRepository: sl()));

  //! repos
  sl.registerLazySingleton<AppUserRepository>(
      () => AppUserRepositoryImpl(firestore: sl()));

  //? ########## WeightGoal ##########
  //! state management
  sl.registerFactory(() => WeightGoalObserverBloc(weightGoalRepository: sl()));
  sl.registerFactory(
      () => WeightGoalControllerBloc(weightGoalRepository: sl()));
  sl.registerFactory(() => WeightGoalFormBloc(weightGoalRepository: sl()));

  //! repos
  sl.registerLazySingleton<WeightGoalRepository>(
      () => WeightGoalRepositoryImpl(firestore: sl()));
}
