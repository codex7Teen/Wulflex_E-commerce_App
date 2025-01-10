import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/features/account/bloc/chat_bloc/chat_bloc.dart';
import 'package:wulflex/features/account/bloc/user_profile_bloc/user_profile_bloc.dart';
import 'package:wulflex/features/account/presentation/widgets/customer_support_screen_widgets.dart';
import 'package:wulflex/features/account/presentation/widgets/message_bubble_widget.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:animate_do/animate_do.dart';

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

    // add a listener to focusnode
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so the keyboard has time to show up
        // then the amount of remaining space will be calculated
        // then scroll down
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
              //! Show shimmer
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
                        //! Messages List
                        Expanded(
                            child: StreamBuilder(
                          stream: state.messages,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              //! Show shimmer
                              return CustomerSupportScreenWidgets
                                  .buildCustomerSupportScreenShimmer(context);
                            }
                            if (snapshot.hasData &&
                                snapshot.data!.docs.isEmpty) {
                              //! EMPTY MESSAGES
                              return CustomerSupportScreenWidgets
                                  .buildNoMessagesWidget(context);
                            }
                            // Scroll down when new data arrives
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Future.delayed(const Duration(milliseconds: 400),
                                  () {
                                CustomerSupportScreenWidgets.scrollDown(
                                    _scrollController);
                              });
                            });
                            return ListView(
                              controller: _scrollController,
                              children: snapshot.data!.docs.map(
                                (doc) {
                                  final data =
                                      doc.data() as Map<String, dynamic>;
                                  //! MESSAGE BUBBLES
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
                        CustomerSupportScreenWidgets
                            .buildMessageInputFieldDivider(context),
                        //! MESSAGE INPUT FIELD
                        FadeInUp(
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
}
