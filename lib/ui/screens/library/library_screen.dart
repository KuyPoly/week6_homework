import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6_homework/data/repositories/songs/song_repository.dart';
import 'package:week6_homework/ui/screens/library/view_%20model/library_view_model.dart';
import 'package:week6_homework/ui/screens/library/widgets/library_content.dart';
import 'package:week6_homework/ui/states/player_state.dart';
import 'package:week6_homework/ui/states/settings_state.dart';


class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => LibraryViewModel(
        songRepository: c.read<SongRepository>(),
        settingsState: c.read<AppSettingsState>(),
        playerState: c.read<PlayerState>(),
      ),
      child: const LibraryContent(),
    );
  }
}
