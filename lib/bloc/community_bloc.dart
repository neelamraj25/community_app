import 'dart:convert';

import 'package:community_view/bloc/community_event.dart';
import 'package:community_view/bloc/community_state.dart';
import 'package:community_view/model/post_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc() : super(CommunityInitial()) {
    on<FetchPostsEvent>(_onFetchPosts);
    on<PlayVideoEvent>(_onPlayVideo);
    on<PauseVideoEvent>(_onPauseVideo);
  }

  Future<void> _onFetchPosts(FetchPostsEvent event, Emitter<CommunityState> emit) async {
    emit(CommunityLoading());
    try {
      final response = await http.get(
        Uri.parse('https://happeningbazaar.com:7432/fetchPost?type=post'),
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final postResponse = PostResponse.fromJson(decodedData);
        final posts = postResponse.data ?? [];
        final videoControllers = await _initializeVideoControllers(posts);

        emit(CommunityLoaded(posts, videoControllers, null));
      } else {
        emit(CommunityError('Failed to load posts: ${response.statusCode}'));
      }
    } catch (e) {
      emit(CommunityError('Error fetching posts: $e'));
    }
  }

  Future<Map<String, VideoPlayerController>> _initializeVideoControllers(List<Post> posts) async {
    final videoControllers = <String, VideoPlayerController>{};
    for (var post in posts) {
      if (post.video != null && post.video!.isNotEmpty) {
        final controller = VideoPlayerController.network(post.video!);
        await controller.initialize();
        videoControllers[post.id!] = controller;
      }
    }
    return videoControllers;
  }

  void _onPlayVideo(PlayVideoEvent event, Emitter<CommunityState> emit) {
    if (state is CommunityLoaded) {
      final currentState = state as CommunityLoaded;
      final updatedControllers = Map<String, VideoPlayerController>.from(currentState.videoControllers);

      if (currentState.currentlyPlayingVideoId != null &&
          currentState.currentlyPlayingVideoId != event.postId) {
        updatedControllers[currentState.currentlyPlayingVideoId!]?.pause();
      }
      updatedControllers[event.postId]?.play();

      emit(CommunityLoaded(currentState.posts, updatedControllers, event.postId));
    }
  }

  void _onPauseVideo(PauseVideoEvent event, Emitter<CommunityState> emit) {
    if (state is CommunityLoaded) {
      final currentState = state as CommunityLoaded;
      final updatedControllers = Map<String, VideoPlayerController>.from(currentState.videoControllers);

      updatedControllers[event.postId]?.pause();

      emit(CommunityLoaded(
          currentState.posts,
          updatedControllers,
          currentState.currentlyPlayingVideoId == event.postId ? null : currentState.currentlyPlayingVideoId));
    }
  }

  @override
  Future<void> close() {
    if(state is CommunityLoaded){
      final currentState = state as CommunityLoaded;
      for (var controller in currentState.videoControllers.values) {
        controller.dispose();
      }
    }
    return super.close();
  }
}
