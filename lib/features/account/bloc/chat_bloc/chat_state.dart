part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatError extends ChatState {
  final String errorMessage;

  const ChatError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class MessagesLoaded extends ChatState {
  final Stream<QuerySnapshot> messages;

  const MessagesLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessageSent extends ChatState {}
