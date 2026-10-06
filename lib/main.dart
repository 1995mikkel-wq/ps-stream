import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() {
  runApp(const MaterialApp(
    home: PlayStationStreamScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class PlayStationStreamScreen extends StatefulWidget {
  const PlayStationStreamScreen({super.key});

  @override
  State createState() => _PlayStationStreamScreenState();
}

class _PlayStationStreamScreenState extends State {
  late VlcPlayerController _vlcViewController;

  // PlayStationens lokale IP-adresse på dit Wi-Fi
  final String playstationStreamUrl = 'rtsp://192.168.1.150:8554/live';

  @override
  void initState() {
    super.initState();
    _vlcViewController = VlcPlayerController.network(
      playstationStreamUrl,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          '--network-caching=50',
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _vlcViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VlcPlayer(
            controller: _vlcViewController,
            aspectRatio: 16 / 9,
            placeholder: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'Forbinder til PlayStation...',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}