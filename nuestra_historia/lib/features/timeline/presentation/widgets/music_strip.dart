import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicStrip extends StatefulWidget {
  final String coverAsset;
  final String vinylAsset;
  final String audioAsset;
  final String title;
  final bool isActive;

  const MusicStrip({
    super.key,
    required this.coverAsset,
    required this.vinylAsset,
    required this.audioAsset,
    required this.title,
    required this.isActive,
  });

  @override
  State<MusicStrip> createState() => _MusicStripState();
}

class _MusicStripState extends State<MusicStrip>
    with SingleTickerProviderStateMixin {
  late final AudioPlayer _player;
  late final AnimationController _vinylController;
  bool _isPlaying = false;
  bool _userPaused = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _vinylController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncPlayback();
    });
  }

  @override
  void didUpdateWidget(covariant MusicStrip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      _syncPlayback();
    }
  }

  @override
  void dispose() {
    _vinylController.dispose();
    _player.dispose();
    super.dispose();
  }

  String _assetSource() {
    return widget.audioAsset.startsWith('assets/')
        ? widget.audioAsset.substring(7)
        : widget.audioAsset;
  }

  Future<void> _toggle() async {
    if (_isPlaying) {
      await _player.pause();
      _vinylController.stop();
      _userPaused = true;
    } else {
      await _player.play(AssetSource(_assetSource()));
      _vinylController.repeat();
      _userPaused = false;
    }
    if (mounted) {
      setState(() {
        _isPlaying = !_isPlaying;
      });
    }
  }

  Future<void> _syncPlayback() async {
    if (!mounted) return;
    if (widget.isActive && !_userPaused) {
      if (!_isPlaying) {
        await _player.play(AssetSource(_assetSource()));
        _vinylController.repeat();
        if (mounted) {
          setState(() {
            _isPlaying = true;
          });
        }
      }
    } else {
      if (_isPlaying) {
        await _player.pause();
        _vinylController.stop();
        if (mounted) {
          setState(() {
            _isPlaying = false;
          });
        }
      }
      if (!widget.isActive) {
        _userPaused = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 26),
                child: RotationTransition(
                  turns: _vinylController,
                  child: Image.asset(
                    widget.vinylAsset,
                    width: 58,
                    height: 58,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  widget.coverAsset,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _isPlaying ? 'Reproduciendo' : 'Pausado',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: _toggle,
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
