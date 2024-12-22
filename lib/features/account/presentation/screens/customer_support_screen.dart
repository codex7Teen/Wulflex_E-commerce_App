import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/account/bloc/chat_bloc/chat_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';
import 'package:animate_do/animate_do.dart';

class ScreenCustomerSupport extends StatefulWidget {
  ScreenCustomerSupport({super.key});

  @override
  State<ScreenCustomerSupport> createState() => _ScreenCustomerSupportState();
}

class _ScreenCustomerSupportState extends State<ScreenCustomerSupport> {
  final TextEditingController _messageController = TextEditingController();

  // scroll controller
  final ScrollController _scrollController = ScrollController();

  // focus node
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add a listener to focusnode
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so the keyboard has time to show up
        // then the amount of remaining space will be calculated
        // then scroll down
        Future.delayed(Duration(milliseconds: 400), () => scrollDown());
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

// Function to scroll down to maximum extent
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(GetMessagesEvent());
    context.read<UserProfileBloc>().add(FetchUserProfileEvent());
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor(context),
      appBar: customAppbarWithBackbutton(context, "Customer Support", 0.03),
      body: SafeArea(
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserProfileError) {
              return Center(child: Text('Fetch user details error'));
            } else if (state is UserProfileLoaded) {
              final user = state.user;
              return BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatError) {
                    return Center(child: Text('Chat fetch error'));
                  } else if (state is MessagesLoaded) {
                    return Column(
                      children: [
                        // Messages List
                        Expanded(
                            child: StreamBuilder(
                          stream: state.messages,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData &&
                                snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      isLightTheme(context)
                                          ? Lottie.asset(
                                              'assets/lottie/customer_support_white_lottie.json',
                                              width: 190,
                                              repeat: true)
                                          : Lottie.asset(
                                              'assets/lottie/customer_support_black_lottie.json',
                                              width: 190,
                                              repeat: true),
                                      Text(
                                        'We\'re here to help!\nPlease feel free to send us a message with any questions or concerns.',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.emptyScreenText(
                                            context),
                                      ),
                                      SizedBox(height: 90)
                                    ],
                                  ),
                                ),
                              );
                            }
                            // Scroll down when new data arrives
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Future.delayed(Duration(milliseconds: 400), () {
                                scrollDown();
                              });
                            });
                            return ListView(
                              controller: _scrollController,
                              children: snapshot.data!.docs.map(
                                (doc) {
                                  final data =
                                      doc.data() as Map<String, dynamic>;
                                  return SlideInRight(
                                    child: MessageBubble(
                                        message: data['message'],
                                        isMe: data['senderID'] == user.uid,
                                        userImage: user.userImage ?? '',
                                        timeStamp: data['timestamp']),
                                  );
                                },
                              ).toList(),
                            );
                          },
                        )),
                        Divider(
                            thickness: 1,
                            color: isLightTheme(context)
                                ? AppColors.lightGreyThemeColor
                                : AppColors.greyThemeColor),
                        //! Message input
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isLightTheme(context)
                                  ? Colors.grey[100]
                                  : Colors.grey[900],
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    focusNode: myFocusNode,
                                    style: AppTextStyles.chatTextfieldstyle(
                                        context),
                                    controller: _messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type a message...',
                                      hintStyle: AppTextStyles.chatHintText,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                    ),
                                    onSubmitted: (message) {
                                      context.read<ChatBloc>().add(
                                          SendMessageEvent(message: message));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      if (_messageController.text.isNotEmpty) {
                                        context.read<ChatBloc>().add(
                                            SendMessageEvent(
                                                message:
                                                    _messageController.text));
                                        _messageController.clear();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                      child: Text('Something went wrong, USER CHAT ERROR'));
                },
              );
            }
            return Center(
                child: Text('Something went wrong, USER PROFILE ERROR'));
          },
        ),
      ),
    );
  }
}

//! Messages bubble widget
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userImage;
  final Timestamp timeStamp;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.userImage,
    required this.timeStamp,
  });

  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    hour = hour == 0 ? 12 : hour;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    String month = months[dateTime.month - 1];
    return "$month ${dateTime.day}, $hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: isMe ? 60 : 16,
          right: isMe ? 16 : 60,
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? AppColors.greenThemeColor.withOpacity(0.9)
                    : AppColors.lightGreyThemeColor.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isMe ? 20 : 5),
                  bottomRight: Radius.circular(isMe ? 5 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 12,
                      bottom: 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isMe) ...[
                          Container(
                            padding: const EdgeInsets.only(right: 8),
                            child: Image.asset(
                              'assets/wulflex_logo_nobg.png',
                              width: 18,
                              height: 18,
                              color: isMe
                                  ? AppColors.whiteThemeColor
                                  : AppColors.blackThemeColor,
                            ),
                          ),
                        ],
                        Flexible(
                          child: Text(
                            message,
                            style: AppTextStyles.chatBubbleText(isMe),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isMe)
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.whiteThemeColor,
                                width: 1.5,
                              ),
                            ),
                            child: userImage.isNotEmpty
                                ? CircleAvatar(
                                    radius: 10,
                                    backgroundImage: NetworkImage(userImage),
                                  )
                                : Icon(
                                    Icons.account_circle_rounded,
                                    size: 20,
                                    color: AppColors.whiteThemeColor,
                                  ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
              child: Text(
                _formatDateTime(timeStamp),
                style: AppTextStyles.chatBubbleDateTimeText.copyWith(
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
