import 'package:community_view/bloc/community_bloc.dart';
import 'package:community_view/bloc/community_event.dart';
import 'package:community_view/bloc/community_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityBloc()..add(FetchPostsEvent()),
      child: Scaffold(
        appBar: AppBar(
  title: Text(
    'Community Feed',
    style: TextStyle(
      fontWeight: FontWeight.w600, 
      fontSize: 18, 
      color: Colors.white,
      letterSpacing: 0.5, 
    ),
  ),
  backgroundColor: Colors.deepPurple,
  elevation: 3,
  centerTitle: true, 
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(15),
    ),
  ),
 
),
        backgroundColor: Colors.white,
        body: BlocBuilder<CommunityBloc, CommunityState>(
          builder: (context, state) {
            if (state is CommunityLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                ),
              );
            } else if (state is CommunityLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (post.postMessage != null)
                            Text(
                              post.postMessage!,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          if (post.image != null && post.image!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: post.image!
                                    .map((imageData) => Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(imageData.img!, fit: BoxFit.cover),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          if (post.video != null && post.video!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    state.videoControllers[post.id!] != null
                                        ? AspectRatio(
                                            aspectRatio: state.videoControllers[post.id!]!.value.aspectRatio,
                                            child: VideoPlayer(state.videoControllers[post.id!]!),
                                          )
                                        : Center(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                                            ),
                                          ),
                                    if (state.currentlyPlayingVideoId != post.id)
                                      IconButton(
                                        icon: Icon(Icons.play_circle_fill, size: 60, color: Colors.white70),
                                        onPressed: () {
                                          context.read<CommunityBloc>().add(PlayVideoEvent(post.id!));
                                        },
                                      ),
                                    if(state.currentlyPlayingVideoId == post.id && state.videoControllers[post.id!]!.value.isPlaying )
                                      IconButton(
                                        icon: Icon(Icons.pause_circle_filled, size: 60, color: Colors.white70),
                                        onPressed: () {
                                          context.read<CommunityBloc>().add(PauseVideoEvent(post.id!));
                                        },
                                      )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is CommunityError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return Center(child: Text('Welcome to the Community!'));
            }
          },
        ),
      ),
    );
  }
}