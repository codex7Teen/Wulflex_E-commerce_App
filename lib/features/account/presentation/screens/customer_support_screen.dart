import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/account/bloc/chat_bloc/chat_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/features/account/presentation/widgets/customer_support_screen_widgets.dart';
import 'package:wulflex/features/account/presentation/widgets/message_bubble_widget.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenCustomerSupport extends StatefulWidget {
  const ScreenCustomerSupport({super.key});

  @override
  State<ScreenCustomerSupport> createState() => _ScreenCustomerSupportState();
}

class _ScreenCustomerSupportState extends State<ScreenCustomerSupport> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 400),
            () => CustomerSupportScreenWidgets.scrollDown(_scrollController));
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
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
              return CustomerSupportScreenWidgets
                  .buildCustomerSupportScreenShimmer(context);
            } else if (state is UserProfileError) {
              return const Center(child: Text('Fetch user details error'));
            } else if (state is UserProfileLoaded) {
              final user = state.user;
              return BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatError) {
                    return const Center(child: Text('Chat fetch error'));
                  } else if (state is MessagesLoaded) {
                    return Column(
                      children: [
                        Expanded(
                          child: StreamBuilder(
                            stream: state.messages,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                //! SHIMMER
                                return CustomerSupportScreenWidgets
                                    .buildCustomerSupportScreenShimmer(context);
                              }
                              if (snapshot.hasData &&
                                  snapshot.data!.docs.isEmpty) {
                                //! NO MESSAGES DISPLAY
                                return CustomerSupportScreenWidgets
                                    .buildNoMessagesWidget(context);
                              }

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Future.delayed(
                                    const Duration(milliseconds: 400), () {
                                  CustomerSupportScreenWidgets.scrollDown(
                                      _scrollController);
                                });
                              });

                              //! FROUPING MESSAGES BY DATE
                              final groupedMessages = <String, List<dynamic>>{};
                              for (var doc in snapshot.data!.docs) {
                                final data = doc.data() as Map<String, dynamic>;
                                final date = _formatMessageDate(
                                    data['timestamp'] as Timestamp);
                                if (!groupedMessages.containsKey(date)) {
                                  groupedMessages[date] = [];
                                }
                                groupedMessages[date]!.add(data);
                              }

                              return ListView.builder(
                                controller: _scrollController,
                                itemCount: groupedMessages.length,
                                itemBuilder: (context, index) {
                                  final entry =
                                      groupedMessages.entries.elementAt(index);
                                  return Column(
                                    children: [
                                      //! DATE SECTION HEADER
                                      CustomerSupportScreenWidgets
                                          .buildDateSectionHeader(
                                              context, entry),
                                      //! MESSAGES
                                      ...entry.value.map((data) => SlideInRight(
                                            child: MessageBubble(
                                                message: data['message'],
                                                isMe: data['senderID'] ==
                                                    user.uid,
                                                userImage: user.userImage ?? '',
                                                timeStamp: data['timestamp']),
                                          )),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        //! INPUT FIELD DIVIDER
                        FadeIn(
                          delay: const Duration(milliseconds: 500),
                          child: CustomerSupportScreenWidgets
                              .buildMessageInputFieldDivider(context),
                        ),
                        FadeInUp(
                          //! INPUT FIELD
                          child: CustomerSupportScreenWidgets
                              .buildMessageInputField(
                                  context, myFocusNode, _messageController),
                        )
                      ],
                    );
                  }
                  return const Center(
                      child: Text('Something went wrong, USER CHAT ERROR'));
                },
              );
            }
            return const Center(
                child: Text('Something went wrong, USER PROFILE ERROR'));
          },
        ),
      ),
    );
  }

  String _formatMessageDate(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
