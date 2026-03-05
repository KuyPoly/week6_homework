import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6_homework/ui/screens/library/view_%20model/library_view_model.dart';
import 'package:week6_homework/ui/states/settings_state.dart';
import '../../../theme/theme.dart';
import '../../../../model/songs/song.dart';


class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm= context.watch<LibraryViewModel>();
    final settings = context.watch<AppSettingsState>();
    return Container(
      color: settings.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: vm.songs.length,
              itemBuilder: (context, index) => SongTile(
                song: vm.songs[index],
                isPlaying: vm.playerState.currentSong == vm.songs[index],
                 onTap: () {
                  vm.playerState.currentSong == null
                      ? vm.playerState.start(vm.songs[index])
                      : vm.playerState.stop();
                },
              ),
            ),
          ),
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
