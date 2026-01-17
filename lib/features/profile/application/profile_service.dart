import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../inventory/domain/entities/ingredient.dart';
import '../domain/entities/journal_entry.dart';

class UserProfile {
  final String name;
  final String email;
  final String? photoUrl;
  final List<String> medals;
  final List<JournalEntry> journal;

  UserProfile({
    required this.name,
    required this.email,
    this.photoUrl,
    this.medals = const [],
    this.journal = const [],
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? photoUrl,
    List<String>? medals,
    List<JournalEntry>? journal,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      medals: medals ?? this.medals,
      journal: journal ?? this.journal,
    );
  }
}

class ProfileNotifier extends StateNotifier<UserProfile?> {
  ProfileNotifier() : super(null);

  void loginSimulated() {
    state = UserProfile(
      name: 'Chef Usuario',
      email: 'usuario@ejemplo.com',
      medals: ['Chef Novato', 'Explorador Latino'],
      journal: [],
    );
  }

  void logout() {
    state = null;
  }

  void addJournalEntry(JournalEntry entry) {
    if (state != null) {
      state = state!.copyWith(journal: [entry, ...state!.journal]);
    }
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile?>((ref) {
  return ProfileNotifier();
});
