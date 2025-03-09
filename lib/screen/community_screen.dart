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
          title: Row(
            children: [
             
              Text(
                'Happening Bazaar',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.white),
              onPressed: () {
                // Handle notification tap
              },
            ),
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/icon/app_icon.png'), // Replace with your profile picture path
            ),
            SizedBox(width: 8),
          ],
          backgroundColor: Colors.deepPurple,
          elevation: 3,
          centerTitle: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My Location', style: TextStyle(color: Colors.white, fontSize: 12)),
                        Text('Building No-141 Building...', style: TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
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
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), 
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    child: Icon(Icons.star, color: Colors.white),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(post.title ?? 'Untitled', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(post.createdAt ?? 'Unknown Date', style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                              if (post.image != null && post.image!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(post.image!.first.img!, fit: BoxFit.cover, width: double.infinity), // Display only the first image
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
                                        if (state.currentlyPlayingVideoId == post.id && state.videoControllers[post.id!]!.value.isPlaying)
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
                        Divider(height: 1), 
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.thumb_up_alt_outlined),
                                    onPressed: () {
                                      // Handle like button tap
                                    },
                                  ),
                                  Text(post.likeCount?.toString() ?? '0'),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.comment_bank_outlined),
                                    onPressed: () {
                                      // Handle comment button tap
                                    },
                                  ),
                                  Text(post.commentCount?.toString() ?? '0'),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.share),
                                onPressed: () {
                                  // Handle share button tap
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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