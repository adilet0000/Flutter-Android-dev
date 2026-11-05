# Week 12 — WorkManager → `workmanager` plugin

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 23 | 01.12 | WorkManager | `workmanager` one-off tasks, notifications |
| 24 | 03.12 | Advanced WorkManager | Periodic/unique tasks, constraints, input data, cancellation, chaining strategy |

## Class 23 — Background work basics
1. Why background work is different in Flutter: tasks run in a **separate isolate**, so there is no access to your widgets or `ProviderScope`. Re-create what you need (the DB, Dio) inside the task.
2. Setup:
   ```bash
   flutter pub add workmanager flutter_local_notifications
   ```
   ```dart
   @pragma('vm:entry-point')
   void callbackDispatcher() {
     Workmanager().executeTask((task, inputData) async {
       switch (task) {
         case 'syncFeed':
           final db = AppDatabase();
           await OfflineFirstPostsRepository(PicsumApi(buildDio()), db).refresh();
           await db.close();
         case 'waterReminder':
           await showNotification('Time to water ${inputData?['plant']}');
       }
       return true; // false = retry
     });
   }

   Future<void> main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Workmanager().initialize(callbackDispatcher);
     runApp(const ProviderScope(child: MainApp()));
   }
   ```
3. `registerOneOffTask(uniqueName, taskName, initialDelay:, inputData:)`.
4. Notifications: channel setup, Android 13+ `POST_NOTIFICATIONS` runtime permission.
5. Debug: `adb shell dumpsys jobscheduler | grep <package>`, and logs from the background isolate.

## Class 24 — Advanced
| Android WorkManager | Flutter `workmanager` |
|---|---|
| `PeriodicWorkRequest` (min 15 min) | `registerPeriodicTask(name, task, frequency: Duration(hours: 1))` |
| `Constraints` (network, charging, battery) | `constraints: Constraints(networkType: ..., requiresCharging: true, requiresBatteryNotLow: true)` |
| `enqueueUniqueWork(..., ExistingWorkPolicy.REPLACE)` | `existingWorkPolicy: ExistingWorkPolicy.replace` |
| `BackoffPolicy` | `backoffPolicy`, `backoffPolicyDelay` |
| `Data` input/output | `inputData: {...}` (primitives only) |
| `cancelUniqueWork` / `cancelAllWork` | `cancelByUniqueName` / `cancelAll` |
| `beginWith().then()` chaining | No direct chaining: do the steps sequentially inside one task, or register the next task at the end of the current one |
| Observing work status (`LiveData<WorkInfo>`) | Not built in: write the status to drift/Hive from the task and watch it in the UI |

Also mention iOS limits (BGTaskScheduler; periodic tasks run at the OS's discretion), and that the course targets Android.

**Lab:** Water Me! (see [labs.md](../labs.md#l7--water-me-week-12)).

## Repo milestone
- Periodic `syncFeed` task (every 1 h, network connected) refreshes the drift cache.
- New Post: "Share" saves the post to drift with `status = pending`, then registers a unique one-off `uploadPost` task. The task marks it `uploaded` (simulate the upload with a delay) and shows a "Post shared" notification. The feed shows a "Posting…" banner while the status is pending.
