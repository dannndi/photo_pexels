import 'package:get_it/get_it.dart';
import 'package:photo_pexels/data/remote/pexel_services.dart';
import 'package:photo_pexels/data/repository/pexel_repository.dart';
import 'package:photo_pexels/data/repository_impl/pexel_respository_impl.dart';

final inject = GetIt.instance;

void setupInjection() {
  inject.registerSingleton<PexelServices>(PexelServices.create());
  inject.registerSingleton<PexelRepository>(
    PexelRepositoryImpl(inject.get<PexelServices>()),
  );
}
