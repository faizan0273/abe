class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final bool seen, online;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.seen,
    required this.online,
  });
}

List<ChatModel> dummyData = [
  new ChatModel(
    name: "Bade Muhammad",
    message: "Hi i'd like to know how much it'll cost to me",
    time: "15:30",
    avatarUrl: "https://randomuser.me/portraits/men/88.jpg",
    seen: false,
    online: true,
  ),
  new ChatModel(
    name: "Jahuar",
    message: "Hi i'd like to know how much it'll cost to me",
    time: "15:30",
    avatarUrl: "https://randomuser.me/portraits/women/51.jpg",
    seen: true,
    online: false,
  ),
  new ChatModel(
    name: "Ali Abdi",
    message: "Offer",
    time: "15:30",
    avatarUrl: "https://randomuser.me/portraits/men/42.jpg",
    seen: true,
    online: true,
  ),
  new ChatModel(
    name: "Bader Muhammad",
    message: "Hi i'd like to know how much it'll cost to me",
    time: "15:30",
    avatarUrl: "https://randomuser.me/portraits/women/43.jpg",
    seen: false,
    online: false,
  ),
  new ChatModel(
    name: "Aimi",
    message: "Hi i'd like to know how much it'll cost to me",
    time: "15:30",
    avatarUrl: "https://randomuser.me/portraits/women/15.jpg",
    seen: true,
    online: false,
  ),
  new ChatModel(
    name: "Bade Muhammad",
    message: "Hi i'd like to know how much it'll cost to me",
    time: "15:30",
    avatarUrl: "https://randomuser.me/portraits/women/3.jpg",
    seen: true,
    online: false,
  ),
  new ChatModel(
    name: "Aimi",
    message: "Hi i'd like to know how much it'll cost to me",
    time: "15:30",
    avatarUrl: "https://randomuser.me/portraits/women/2.jpg",
    seen: true,
    online: true,
  ),
  new ChatModel(
    name: "Morgan",
    message: "Hi i'd like to know how much it'll cost to me",
    time: "15:30",
    avatarUrl: "https://randomuser.me/portraits/men/1.jpg",
    seen: true,
    online: false,
  ),
];
