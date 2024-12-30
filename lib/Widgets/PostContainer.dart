import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/Controllers/AuthController.dart';
import 'package:social_media/Models/PostModel.dart';
import 'package:social_media/Utils/Api.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostContainer extends StatefulWidget {
  final PostModel post;
  const PostContainer({super.key, required this.post});

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  late final PostModel post = widget.post;
  late final AuthController authController = Get.put(AuthController());

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: _buildCommentsBottomSheet(context),
          ));
        });
  }

  Widget _buildCommentsBottomSheet(BuildContext context) {
    return GestureDetector(
        // Close the bottom sheet when tapping outside of it
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss the keyboard
        },
        child: Container(
          margin: EdgeInsets.all(8),
          height:
              MediaQuery.of(context).size.height * 0.5, // 50% of screen height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Sheet Drag Handle
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                post.comments == null
                    ? Center(
                        child: Text('No Comments.'),
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: post.comments!.length,
                          separatorBuilder: (_, __) => Divider(),
                          itemBuilder: (context, index) {
                            var comment = post.comments![index];
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: comment.user.profile == null
                                    ? Icon(Icons.person)
                                    : Image.network(
                                        "${Api.baseURL}/${comment.user.profile?.image}"),
                              ),
                              title: Text(comment.user.username),
                              subtitle: Text(comment.content),
                            );
                          },
                        ),
                      ),

                const SizedBox(height: 8),
                // Input field to add a new comment
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Write a comment...",
                          hintStyle: TextStyle(color: Colors.black38),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.send,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        // Handle send action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return // Post Section
        Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: post.user.profile == null
                      ? Icon(Icons.person, size: 24)
                      : Image.network(
                          '${Api.baseURL}/${post.user.profile!.image}',
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Return the fully loaded image
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null, // Show progress if total bytes are available
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error,
                                      color: Colors.red, size: 40),
                                  SizedBox(height: 8),
                                  Text(
                                    'Failed to load image',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
            ),
            title: Text(post.user.fullName),
            subtitle: Text(post.title),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.more_horiz), // Trailing icon
                Text(
                  timeago.format(post.createdAt), // Text below the icon
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            post.content,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showCommentsBottomSheet(context);
                  },
                  style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.transparent),
                      shadowColor: WidgetStatePropertyAll(Colors.transparent)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment,
                        color: Theme.of(context).dividerColor,
                        size: 14.0,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Comments",
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.all(0)),
                      backgroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                      shadowColor: WidgetStateProperty.all(Colors.transparent)),
                  child: Row(
                    children: [
                      Text(
                        "${post.likesCount} Likes",
                        style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontSize: 14),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.thumb_up_outlined,
                        color: Theme.of(context).dividerColor,
                        size: 14.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
