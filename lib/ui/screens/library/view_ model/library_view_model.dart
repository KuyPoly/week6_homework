import 'package:flutter/material.dart';
import 'package:week6_homework/data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';
import '../../../states/settings_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final AppSettingsState settingsState;
  final PlayerState playerState;

  List<Song> _songs = [];
  List<Song> get songs => _songs;
  Song? get currentSong => playerState.currentSong;
  LibraryViewModel({
    required this.songRepository,
    required this.settingsState,
    required this.playerState,
  }) {
    init();
    playerState.addListener(_onPlayerChanged);
  }

  void _onPlayerChanged() => notifyListeners();

  void init() {
    _songs = songRepository.fetchSongs();
    notifyListeners();
  }

  void play(Song s) => playerState.start(s);
  void stop() => playerState.stop();

  @override
  void dispose() {
    playerState.removeListener(_onPlayerChanged);
    super.dispose();
  }
}
