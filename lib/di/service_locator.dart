import 'package:get_it/get_it.dart';
import '../data/di/data_layer_injection.dart';
import '../domain/di/domain_layer_injection.dart';
import '../presentation/di/presentation_layer_injection.dart';
import '../navigation/di/navigation_layer_injection.dart';
import '../network/di/network_layer_injection.dart';
import '../service/di/service_injection.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> configureServiceLocator() async {
    await NavigationLayerInjection.configureNavigationLayerInjection();
    await NetworkLayerInjection.configureNetworkLayerInjection();
    await ServiceInjection.configureServiceLayerInjction();
    await DataLayerInjection.configureDataLayerInjction();
    await DomainLayerInjection.configureDataLayerInjection();
    await PresentationLayerInjection.configurePresentationLayerInjection();
  }
}
