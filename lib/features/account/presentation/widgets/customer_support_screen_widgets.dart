import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';
import 'package:wulflex/features/account/bloc/chat_bloc/chat_bloc.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class CustomerSupportScreenWidgets {
  // Function to scroll down to maximum extent
  static void scrollDown(ScrollController scrollController) {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  static Widget buildNoMessagesWidget(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              style: AppTextStyles.emptyScreenText(context),
            ),
            SizedBox(height: 90)
          ],
        ),
      ),
    );
  }

  static Widget buildMessageInputFieldDivider(BuildContext context) {
    return Divider(
        thickness: 1,
        color: isLightTheme(context)
            ? AppColors.lightGreyThemeColor
            : AppColors.greyThemeColor);
  }

  static Widget buildMessageInputField(BuildContext context,
      FocusNode myFocusNode, TextEditingController messageController) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: isLightTheme(context) ? Colors.grey[100] : Colors.grey[900],
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
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
                style: AppTextStyles.chatTextfieldstyle(context),
                controller: messageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a message...',
                  hintStyle: AppTextStyles.chatHintText,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
                onSubmitted: (message) {
                  context
                      .read<ChatBloc>()
                      .add(SendMessageEvent(message: message));
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
                  if (messageController.text.isNotEmpty) {
                    context
                        .read<ChatBloc>()
                        .add(SendMessageEvent(message: messageController.text));
                    messageController.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
