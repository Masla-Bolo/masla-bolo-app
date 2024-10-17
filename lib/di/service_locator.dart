import 'package:get_it/get_it.dart';
import 'package:masla_bolo_app/data/di/data_layer_injection.dart';
import 'package:masla_bolo_app/domain/di/domain_layer_injection.dart';
import 'package:masla_bolo_app/features/di/presentation_layer_injection.dart';
import 'package:masla_bolo_app/navigation/di/navigation_layer_injection.dart';
import 'package:masla_bolo_app/network/di/network_layer_injection.dart';
import 'package:masla_bolo_app/service/di/service_injection.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> configureServiceLocator() async {
    await ServiceInjection.configureServiceLayerInjction();
    await NavigationLayerInjection.configureNavigationLayerInjection();
    await DataLayerInjection.configureDataLayerInjction();
    await NetworkLayerInjection.configureNetworkLayerInjection();
    await DomainLayerInjection.configureDataLayerInjection();
    await PresentationLayerInjection.configurePresentationLayerInjection();
  }
}
