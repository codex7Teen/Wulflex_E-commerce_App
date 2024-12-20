import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/data/services/chat_services.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatServices _chatServices;
  ChatBloc(this._chatServices) : super(ChatInitial()) {
    //! SEND MESSAGE BLOC
    on<SendMessageEvent>((event, emit) async {
      try {
        await _chatServices.sendMessage(event.message);
        log('BLOC: MESSAGE SENT SUCCESS');
      } catch (error) {
        emit(ChatError(errorMessage: error.toString()));
        log('BLOC: MESSAGE SENDING FAILED $error');
      }
    });

    //! GET MESSAGE BLOC
    on<GetMessagesEvent>((event, emit) async {
      try {
        final messagesStream = _chatServices.getMessages();
        emit(MessagesLoaded(messages: messagesStream));
      } catch (error) {
        emit(ChatError(errorMessage: error.toString()));
        log('BLOC: GET MESSAGES FAILED $error');
      }
    });
  }
}
