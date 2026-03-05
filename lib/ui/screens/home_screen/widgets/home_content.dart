import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6_homework/ui/states/settings_state.dart';
import '../view_model/home_view_model.dart';
import '../../../../model/songs/song.dart';
import '../../../theme/theme.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final settings = context.watch<AppSettingsState>();
    return Container(
      color: settings.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Home", style: AppTextStyles.heading),
          SizedBox(height: 24),

          // recent
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Your recent songs", style: AppTextStyles.label),
          ),
          ...vm.recentSongs.map((song) => SongTile(
                song: song,
                isPlaying: vm.currentSong == song,
                onTap: () {
                  vm.playerState.currentSong == null
                      ? vm.playerState.start(song)
                      : vm.playerState.stop();
                },
              )),

          SizedBox(height: 24),
          // suggest song
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("You might also like", style: AppTextStyles.label),
          ),
          ...vm.suggestedSongs.map((song) => SongTile(
                song: song,
                isPlaying: vm.currentSong == song,
                onTap: () {
                  vm.playerState.currentSong == null
                      ? vm.playerState.start(song)
                      : vm.playerState.stop();
                },
              )),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: Text(
        isPlaying ? "Playing" : "",
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}
