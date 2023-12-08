part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}
class ChatTapText extends ChatState {}
class ChatOnChanged extends ChatState {}
class ChatEmojiIcon extends ChatState {}
class ChatOnSend extends ChatState {}
class ChatFocus extends ChatState {}
class ChatSendFile extends ChatState {}
class ChatRepMessage extends ChatState {}
class ChatSoundMessage extends ChatState {

}
