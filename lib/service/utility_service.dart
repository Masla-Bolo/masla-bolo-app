class UtilityService {
  bool listenerInitialized = false;
  Map<int, Future<dynamic> Function()> apiQueue = {};

  Future<void> executeAll() async {
    while (apiQueue.isNotEmpty) {
      final key = apiQueue.keys.first;
      final apiCall = apiQueue[key]!;
      try {
        await apiCall();
        apiQueue.remove(key);
      } catch (e) {
        apiQueue.remove(key);
        await Future.delayed(const Duration(seconds: 1));
        executeAll();
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void initializeListener() {
    listenerInitialized = true;
    Future.delayed(const Duration(minutes: 1), () {
      executeAll().then((_) => listenerInitialized = false);
    });
  }

  void addToQueue(int key, Future Function() value) {
    apiQueue.addAll({key: value});
    if (!listenerInitialized) {
      initializeListener();
    }
  }

  void removeFromQueue(int removeKey) {
    apiQueue.removeWhere((key, value) => key == removeKey);
  }
}
