import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week6_homework/ui/screens/home_screen/view_model/home_view_model.dart';
import 'package:week6_homework/ui/screens/home_screen/widgets/home_content.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../../data/repositories/songs/user_history_repository.dart';
import '../../states/player_state.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => HomeViewModel(
        songRepository: c.read<SongRepository>(),
        userHistoryRepository: c.read<UserHistoryRepository>(),
        playerState: c.read<PlayerState>(),
      ),
      child: const HomeContent(),
    );
  }
}