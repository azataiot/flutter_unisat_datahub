abstract class Storage {
  // All GetStorage keys of the application should be here.

  /// saved theme for the application
  static const theme = "theme";

  /// Do we need to load the language selection and the onboarding?
  static const firstRun = "firstRun";

  /// App language
  static const language = "language";

  // enable Caching
  static const enableCaching = "enableCaching";

  // cache duration
  static const cacheDuration = "cacheDuration";

  // server check status (for online mode, we check once)
  static const serverCheckStatusOK = "serverOk";

  static const themMode = "themeMode";

  //
  static const currentSource = "currentSource";
  static const dataResult = "dataResult";
  static const dataSourceResult = "dataSourceResult";

  static const records = "records";
  static const collections = "collections";
}
