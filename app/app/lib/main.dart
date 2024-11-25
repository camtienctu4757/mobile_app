import 'dart:async';
import 'package:app/ui/appointment/bloc/appointment.dart';
import 'package:app/ui/booking/bloc/booking.dart';
import 'package:app/ui/storetab/bloc/storetab.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:initializer/initializer.dart';
import 'package:shared/shared.dart';
import 'app/my_app.dart';
import 'config/app_config.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runZonedGuarded(_runMyApp, _reportError);

Future<void> _runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer(AppConfig.getInstance()).init();
  final initialResource = await _loadInitialResource();
  HttpOverrides.global = MyHttpOverrides();
  // runApp(MyApp(initialResource: initialResource));
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookingBloc(
            GetIt.I.get<GetTimeSlotUseCase>(),
            GetIt.I.get<CreateAppointUseCase>()
          ),
        ),
        BlocProvider(
          create: (context) => AppointmentBloc(
            GetIt.I.get<GetAppointSuccessUseCase>(),
            GetIt.I.get<GetBookingCancleUseCase>(),
            GetIt.I.get<GetBookingPendingUseCase>(),
            GetIt.I.get<UserUpdateBookingCancleUseCase>()
          ),
        ),
        BlocProvider(
        create: (context) => StoreBloc(
              GetIt.I.get<GetShopsUseCase>(),
              GetIt.I.get<GetLocalUserUseCase>(),
              GetIt.I.get<GetImageShopUseCase>(),
              GetIt.I.get<DeleteShopUseCase>()
            ))
      ],
      child: MyApp(initialResource: initialResource),
    )
    // MyApp(initialResource: initialResource)
  );

}


void _reportError(Object error, StackTrace stackTrace) {
  Log.e(error, stackTrace: stackTrace, name: 'Uncaught exception');
}

Future<LoadInitialResourceOutput> _loadInitialResource() async {
  final result = runCatching(
    action: () =>
        GetIt.instance.get<LoadInitialResourceUseCase>().execute(const LoadInitialResourceInput()),
  );

  return result.when(
    success: (output) => output,
    failure: (e) => const LoadInitialResourceOutput(),
  );
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}