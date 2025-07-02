class Bread {
  final String breadName;
  final String imageURL;

  Bread({
    required this.breadName,
    required this.imageURL,
  });

  // List of Bread data
  static List<Bread> breadList = [
    Bread(
      breadName: 'All',
      imageURL: 'assets/images/banhmi.png',
    ),
    Bread(
      breadName: 'Pizza',
      imageURL: 'assets/images/pizza.png',
    ),
    Bread(
      breadName: 'Hamburger',
      imageURL: 'assets/images/hamburger.png',
    ),
    Bread(
      breadName: 'Mexico',
      imageURL: 'assets/images/mexico.png',
    ),
    Bread(
      breadName: 'Sandwich',
      imageURL: 'assets/images/sandwich.png',
    ),
  ];
}
