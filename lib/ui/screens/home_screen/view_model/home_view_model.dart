import 'package:flutter/material.dart';
import 'package:week6_homework/data/repositories/songs/song_repository.dart';
import 'package:week6_homework/data/repositories/songs/user_history_repository.dart';
import 'package:week6_homework/ui/states/player_state.dart';
import '../../../../model/songs/song.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final UserHistoryRepository userHistoryRepository;
  final PlayerState playerState;

  List<Song> _recentSongs = [];
  List<Song> _suggestedSongs = [];

  List<Song> get recentSongs => _recentSongs;
  List<Song> get suggestedSongs => _suggestedSongs;
  Song? get currentSong => playerState.currentSong;

  HomeViewModel({
    required this.songRepository,
    required this.userHistoryRepository,
    required this.playerState,
  }) {
    _init();
    playerState.addListener(_onPlayerChanged);
  }

  void _init() {
    final allSongs = songRepository.fetchSongs();

    final recentIDs = userHistoryRepository.getRecentSongIds();
    _recentSongs = recentIDs
        .map((id) => songRepository.fetchSongById(id))
        .whereType<Song>()
        .toList();
    
    final recentIdSet = recentIDs.toSet();
    _suggestedSongs = allSongs.where((s) => !recentIdSet.contains(s.id)).toList();

    notifyListeners();
  }

  void _onPlayerChanged() => notifyListeners();

  void play(Song song) => playerState.start(song);
  void stop() => playerState.stop();

  @override
  void dispose() {
    playerState.removeListener(_onPlayerChanged);
    super.dispose();
  }
}
