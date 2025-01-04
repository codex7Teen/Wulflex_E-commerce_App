part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

//! SEND MESSAGE EVENT
class SendMessageEvent extends ChatEvent {
  final String message;

  const SendMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

//! GET MESSAGES EVENT
class GetMessagesEvent extends ChatEvent {}
