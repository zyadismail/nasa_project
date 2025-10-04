import 'package:flutter/material.dart';
import 'package:nasa_project/widgets/stairs_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  bool _isInitialized1 = false;
  bool _isInitialized2 = false;

  @override
  void initState() {
    super.initState();
    _initializeVideos();
  }

  Future<void> _initializeVideos() async {
    // Initialize first video from assets
    _controller1 = VideoPlayerController.asset('assets/videos/video_part1.mp4');

    try {
      await _controller1.initialize();
      setState(() {
        _isInitialized1 = true;
      });
    } catch (e) {
      print('Error initializing video 1: $e');
    }

    _controller1.addListener(() {
      setState(() {});
    });

    // Initialize second video from assets
    _controller2 = VideoPlayerController.asset('assets/videos/video_part2.mp4');

    try {
      await _controller2.initialize();
      setState(() {
        _isInitialized2 = true;
      });
    } catch (e) {
      print('Error initializing video 2: $e');
    }

    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Video Player',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: (_isInitialized1 || _isInitialized2)
          ? Stack(
              children: [
                Positioned.fill(child: CustomPaint(painter: StarPainter())),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Video
                      if (_isInitialized1)
                        _buildVideoPlayer(
                          controller: _controller1,
                          title: 'part one',
                          description1:
                              '"Captain Shamsi"s Space Adventures" Podcast',
                          description2:
                              "An interactive educational podcast for kids that simplifies space weather concepts\nthrough exciting stories. Using real NASA data, it explains solar flares' impacts on\n astronauts, pilots, farmers, and power grids in an engaging, child-friendly format. 🌍🛰",
                        ),
                    ],
                  ),
                ),
              ],
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  Widget _buildVideoPlayer({
    required VideoPlayerController controller,
    required String title,
    required String description1,
    required String description2,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        SizedBox(height: 20),
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        const SizedBox(height: 20),
        // Video progress bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.blue,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.black26,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.stop, size: 40, color: Colors.white),
              onPressed: () {
                setState(() {
                  controller.seekTo(Duration.zero);
                  controller.pause();
                });
              },
            ),
            IconButton(
              icon: Icon(
                controller.value.volume > 0
                    ? Icons.volume_up
                    : Icons.volume_off,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  controller.setVolume(controller.value.volume > 0 ? 0 : 1);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Display current time / total time
        Align(
          alignment: Alignment.center,
          child: Text(
            '${_formatDuration(controller.value.position)} / ${_formatDuration(controller.value.duration)}',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Video Description :",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Text(description1, style: TextStyle(color: Colors.white, fontSize: 18)),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description2,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
