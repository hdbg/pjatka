import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pjatka/features/settings/model.dart';
import 'package:riverpod/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'provider.g.dart';

final asyncPrefs = SharedPreferencesAsync();

@JsonSerializable()
class Wrapper {
  final Map<String, dynamic> value;
  final DateTime? deletionDate;

  factory Wrapper.fromJson(Map<String, dynamic> json) =>
      _$WrapperFromJson(json);

  Wrapper({required this.value, required this.deletionDate});

  Map<String, dynamic> toJson() => _$WrapperToJson(this);
}

final class PrefStorage extends Storage<String, Map<String, dynamic>> {
  @override
  FutureOr<void> delete(String key) async {
    await asyncPrefs.remove(key);
  }

  @override
  void deleteOutOfDate() async {
    // No-op: handled in read
  }

  @override
  FutureOr<PersistedData<Map<String, dynamic>>?> read(String key) async {
    final jsonString = await asyncPrefs.getString(key);
    if (jsonString == null) {
      return null;
    }

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final wrapper = Wrapper.fromJson(jsonMap);

    if (wrapper.deletionDate != null &&
        DateTime.now().isAfter(wrapper.deletionDate!)) {
      await asyncPrefs.remove(key);
      return null;
    }

    return PersistedData(wrapper.value);
  }

  @override
  FutureOr<void> write(
    String key,
    Map<String, dynamic> value,
    StorageOptions options,
  ) async {
    final expirationDate = options.cacheTime.duration == null
        ? DateTime.now().add(options.cacheTime.duration!)
        : null;

    final wrapper = Wrapper(value: value, deletionDate: expirationDate);

    final jsonString = jsonEncode(wrapper.toJson());

    await asyncPrefs.setString(key, jsonString);
  }
}

@riverpod
PrefStorage settingsStorage(Ref ref) {
  return PrefStorage();
}

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  @override
  SettingsState build() {
    final storage = ref.watch(settingsStorageProvider);
    persist(
      storage,
      key: 'settings',
      encode: (state) => state.toJson(),
      decode: SettingsState.fromJson,
    );

    return SettingsState();
  }

  void addGroup(String group) {
    if (state.groups.contains(group)) {
      return;
    }
    state = state.copyWith(groups: {...state.groups, group});
  }

  void removeGroup(String group) {
    if (!state.groups.contains(group)) {
      return;
    }
    final newGroups = {...state.groups}..remove(group);
    state = state.copyWith(groups: newGroups);
  }

  void replaceGroups(Set<String> groups) {
    state = state.copyWith(groups: groups);
  }

  void setMinDateDaysOffset(int offset) {
    state = state.copyWith(minDateDaysOffset: offset);
  }

  void setMaxDateDaysOffset(int offset) {
    state = state.copyWith(maxDateDaysOffset: offset);
  }
}
