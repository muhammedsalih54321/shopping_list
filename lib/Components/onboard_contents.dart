class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Welcome to ShopEase!',
      image: 'assets/Images/onboard1.png',
      discription:
          "Effortlessly create, manage, and share your shopping lists. Stay organized and never forget an item again!"),
  UnbordingContent(
      title: 'Quick & Easy List Creation',
      image: 'assets/Images/onboard2.jpg',
      discription:
          "Add, edit, and delete items with a tap. Keep your grocery shopping simple and hassle-free."),
  UnbordingContent(
      title: 'Share with Family & Friends',
      image: 'assets/Images/onboard3.jpg',
      discription:
          "Send your shopping lists instantly so everyone stays updated on what to buy!"),
 
];