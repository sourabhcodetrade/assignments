import 'package:firebase_auth_project/app/core/services/package_services.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeGetItDependencies() async {
  getIt.registerSingleton<PackageServices>(PackageServices());
}
