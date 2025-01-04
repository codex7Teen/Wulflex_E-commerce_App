//! Messages bubble widget
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/core/config/text_styles.dart';

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
                    ? AppColors.greenThemeColor.withValues(alpha: 0.9)
                    : AppColors.lightGreyThemeColor.withValues(alpha: 0.9),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isMe ? 20 : 5),
                  bottomRight: Radius.circular(isMe ? 5 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
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
                                : const Icon(
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
