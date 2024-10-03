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
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void initializeListener() {
    listenerInitialized = true;
    Future.delayed(const Duration(seconds: 10), () {
      executeAll().then((_) => listenerInitialized = false);
    });
  }

  void addOrRemoveFromQueue(int key, Future Function() value) {
    if (apiQueue.containsKey(key)) {
      apiQueue.removeWhere((matchKey, _) => matchKey == key);
    } else {
      apiQueue.addAll({key: value});
      if (!listenerInitialized) {
        initializeListener();
      }
    }
    print("QUEUE: ${apiQueue.keys.length}");
  }
}
