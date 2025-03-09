import 'package:community_view/model/post_response.dart';
import 'package:video_player/video_player.dart';

abstract class CommunityState {}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<Post> posts;
  final Map<String, VideoPlayerController> videoControllers;
  final String? currentlyPlayingVideoId;

  CommunityLoaded(this.posts, this.videoControllers, this.currentlyPlayingVideoId);
}

class CommunityError extends CommunityState {
  final String message;

  CommunityError(this.message);
}