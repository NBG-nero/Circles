class UserChat {
  dynamic id;
  dynamic nickname;
  dynamic photoUrl;
  dynamic aboutMe;
  dynamic phoneNumber;
  UserChat({
    this.id,
    this.nickname,
    this.photoUrl,
    this.aboutMe,
    this.phoneNumber,
  });

  @override
  String toString() {
    return 'UserChat(id: $id, nickname: $nickname, photoUrl: $photoUrl, phoneNumber: $phoneNumber)';
  }

  // fromDocument(val) {
  //   UserChat userChat = val;
  //   userChat.toString();
  // }
}
