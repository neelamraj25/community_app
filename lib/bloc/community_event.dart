abstract class CommunityEvent {}

class FetchPostsEvent extends CommunityEvent {}

class PlayVideoEvent extends CommunityEvent {
  final String postId;

  PlayVideoEvent(this.postId);
}

class PauseVideoEvent extends CommunityEvent {
  final String postId;

  PauseVideoEvent(this.postId);
}
