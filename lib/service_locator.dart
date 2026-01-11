import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishna/data/message_sender_api.dart';
import 'package:krishna/data/url_handler.dart';
import 'package:krishna/data/services/blog_service.dart';
import 'package:krishna/data/services/youtube_service.dart';
import 'package:krishna/data/services/message_service.dart';
import 'package:krishna/data/services/contact_settings_service.dart';

final locator = GetIt.instance;

Future<void> initApp() async {
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  await Hive.initFlutter();

  // Register URL handler
  locator.registerSingleton(UrlHandler());

  // Register Firebase Services
  locator.registerLazySingleton(() => BlogService());
  locator.registerLazySingleton(() => YouTubeService());
  locator.registerLazySingleton(() => MessageService());
  locator.registerLazySingleton(() => ContactSettingsService());

  // Register Message Sender API (depends on MessageService)
  locator.registerSingleton(MessageSenderApi(locator<MessageService>()));
}
