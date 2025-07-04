class Breads {
  final int breadId;
  final int price;
  final String size;
  final double rating;
  final int servingTemperatureCelsius;
  final String recommendedHeatingTemperature;
  final String category;
  final String breadName;
  final String imageURL;
  final String description;
  final int quantity;

  Breads({
    required this.breadId,
    required this.price,
    required this.category,
    required this.breadName,
    required this.size,
    required this.rating,
    required this.servingTemperatureCelsius,
    required this.recommendedHeatingTemperature,
    required this.imageURL,
    required this.description,
    required this.quantity,
  });

  static List<Breads> breadList = [
    // [Items 0-9 kept unchanged from previous update]
    Breads(
      breadId: 0,
      price: 25,
      category: 'Pizza',
      breadName: 'Margherita Delight',
      size: 'Medium',
      rating: 4.6,
      servingTemperatureCelsius: 12,
      recommendedHeatingTemperature: '18 - 20',
      imageURL: 'assets/images/pizza/anh1.png',
      description: 'Margherita Delight là một chiếc pizza cổ điển mang hương vị Ý truyền thống, với lớp vỏ giòn mỏng, phô mai Mozzarella tan chảy và nước sốt cà chua tươi ngọt. Sự đơn giản tinh tế của món ăn này làm hài lòng mọi thực khách, từ trẻ nhỏ đến người lớn.',
      quantity: 1,
    ),
    Breads(
      breadId: 1,
      price: 28,
      category: 'Pizza',
      breadName: 'Pepperoni Power',
      size: 'Large',
      rating: 4.8,
      servingTemperatureCelsius: 15,
      recommendedHeatingTemperature: '19 - 21',
      imageURL: 'assets/images/pizza/anh2.png',
      description: 'Pepperoni Power là chiếc pizza đậm đà với lớp nhân pepperoni thơm nồng, kết hợp cùng lớp phô mai béo ngậy phủ trên nền sốt cà chua đặc biệt. Một món ăn lý tưởng cho những ai yêu thích vị cay nhẹ và hương vị mạnh mẽ.',
      quantity: 1,
    ),
    Breads(
      breadId: 2,
      price: 26,
      category: 'Pizza',
      breadName: 'Hawaiian Bliss',
      size: 'Medium',
      rating: 4.3,
      servingTemperatureCelsius: 13,
      recommendedHeatingTemperature: '17 - 19',
      imageURL: 'assets/images/pizza/anh3.png',
      description: 'Hawaiian Bliss là sự kết hợp độc đáo giữa vị ngọt của dứa và vị mặn của giăm bông, hòa quyện trong lớp phô mai béo và đế bánh pizza giòn tan. Món ăn mang đến trải nghiệm nhiệt đới mới lạ và thú vị.',
      quantity: 1,
    ),
    Breads(
      breadId: 3,
      price: 30,
      category: 'Pizza',
      breadName: 'BBQ Chicken Master',
      size: 'Large',
      rating: 4.7,
      servingTemperatureCelsius: 12,
      recommendedHeatingTemperature: '18 - 20',
      imageURL: 'assets/images/pizza/anh4.png',
      description: 'BBQ Chicken Master là chiếc pizza với lớp thịt gà nướng tẩm sốt BBQ đậm đà, hành tây thái lát và phô mai Mozzarella tan chảy. Hương vị khói nhẹ của BBQ kết hợp cùng độ béo của phô mai tạo nên một món ăn hấp dẫn.',
      quantity: 1,
    ),
    Breads(
      breadId: 4,
      price: 24,
      category: 'Pizza',
      breadName: 'Veggie Garden',
      size: 'Small',
      rating: 4.4,
      servingTemperatureCelsius: 18,
      recommendedHeatingTemperature: '17 - 19',
      imageURL: 'assets/images/pizza/anh5.png',
      description: 'Veggie Garden là chiếc pizza lành mạnh với đầy ắp rau củ tươi như ớt chuông, nấm, cà chua và hành, phủ trên nền phô mai và sốt cà chua hấp dẫn. Món ăn thích hợp cho người ăn chay hoặc đang tìm kiếm lựa chọn nhẹ nhàng hơn.',
      quantity: 1,
    ),
    Breads(
      breadId: 5,
      price: 15,
      category: 'Sandwich',
      breadName: 'Classic Club',
      size: 'Medium',
      rating: 4.5,
      servingTemperatureCelsius: 20,
      recommendedHeatingTemperature: '32',
      imageURL: 'assets/images/sandwich/anh6.png',
      description: 'Classic Club Sandwich là món ăn ba tầng với thịt gà nướng, thịt xông khói, rau xà lách giòn và cà chua tươi, phủ lớp mayonnaise béo ngậy. Đây là sự lựa chọn hoàn hảo cho bữa sáng hoặc bữa ăn nhẹ đầy đủ năng lượng.',
      quantity: 1,
    ),
    Breads(
      breadId: 6,
      price: 12,
      category: 'Sandwich',
      breadName: 'BLT Original',
      size: 'Small',
      rating: 4.2,
      servingTemperatureCelsius: 18,
      recommendedHeatingTemperature: '21',
      imageURL: 'assets/images/sandwich/anh7.png',
      description: 'BLT Original là chiếc sandwich đơn giản nhưng luôn được yêu thích, với lớp thịt xông khói giòn rụm, rau xà lách tươi và cà chua mọng nước kẹp giữa hai lát bánh mì nướng vàng. Món ăn phù hợp cho mọi lứa tuổi.',
      quantity: 1,
    ),
    Breads(
      breadId: 7,
      price: 18,
      category: 'Sandwich',
      breadName: 'Philly Steak',
      size: 'Large',
      rating: 4.7,
      servingTemperatureCelsius: 10,
      recommendedHeatingTemperature: '15 - 17',
      imageURL: 'assets/images/sandwich/anh8.png',
      description: 'Philly Steak Sandwich là món bánh mì dài với lớp thịt bò xắt lát mỏng, hành tây xào thơm và phô mai tan chảy. Món ăn đặc trưng của Philadelphia này mang đến cảm giác ngon miệng và no nê.',
      quantity: 1,
    ),
    Breads(
      breadId: 8,
      price: 16,
      category: 'Sandwich',
      breadName: 'Reuben Classic',
      size: 'Medium',
      rating: 4.6,
      servingTemperatureCelsius: 30,
      recommendedHeatingTemperature: '14 - 16',
      imageURL: 'assets/images/sandwich/anh9.png',
      description: 'Reuben Classic là món sandwich nướng giòn gồm thịt bò muối, dưa cải bắp muối, phô mai Thụy Sĩ và sốt Nga đậm đà. Đây là món ăn lý tưởng cho những ai thích sự kết hợp hương vị mạnh mẽ và đậm đà.',
      quantity: 1,
    ),
    Breads(
      breadId: 9,
      price: 14,
      category: 'Sandwich',
      breadName: 'Tuna Melt Supreme',
      size: 'Small',
      rating: 4.1,
      servingTemperatureCelsius: 25,
      recommendedHeatingTemperature: '12 - 14',
      imageURL: 'assets/images/sandwich/anh10.png',
      description: 'Tuna Melt Supreme là món sandwich nóng với cá ngừ trộn mayonnaise, kết hợp cùng phô mai tan chảy và bánh mì nướng giòn. Hương vị đậm đà và độ béo vừa phải giúp món ăn trở nên hấp dẫn với nhiều người.',
      quantity: 1,
    ),
    Breads(
      breadId: 10,
      price: 10,
      category: 'Mexico',
      breadName: 'Spicy Taco',
      size: 'Small',
      rating: 4.5,
      servingTemperatureCelsius: 30,
      recommendedHeatingTemperature: 'Không cần',
      imageURL: 'assets/images/mexico/anh11.png',
      description: 'Spicy Taco là món ăn đặc trưng của ẩm thực Mexico với lớp vỏ bánh ngô giòn tan, bên trong là nhân thịt bò cay nồng được nêm nếm đậm đà, đi kèm rau sống và sốt salsa chua cay hấp dẫn. Món ăn mang lại trải nghiệm bùng nổ vị giác cho người yêu thích món ăn mạnh.',
      quantity: 1,
    ),
    Breads(
      breadId: 10,
      price: 10,
      category: 'Mexico',
      breadName: 'Spicy Taco',
      size: 'Small',
      rating: 4.5,
      servingTemperatureCelsius: 30,
      recommendedHeatingTemperature: '15',
      imageURL: 'assets/images/mexico/anh11.png',
      description: 'Spicy Taco là món ăn đặc trưng của ẩm thực Mexico với lớp vỏ bánh ngô giòn tan, bên trong là nhân thịt bò cay nồng được nêm nếm đậm đà, đi kèm rau sống và sốt salsa chua cay hấp dẫn. Món ăn mang lại trải nghiệm bùng nổ vị giác cho người yêu thích món ăn mạnh.',
      quantity: 1,
    ),
    Breads(
      breadId: 11,
      price: 18,
      category: 'Mexico',
      breadName: 'Giant Burrito',
      size: 'Large',
      rating: 4.7,
      servingTemperatureCelsius: 20,
      recommendedHeatingTemperature: '15 - 17',
      imageURL: 'assets/images/mexico/anh12.png',
      description: 'Giant Burrito là chiếc bánh tortilla cuốn đầy đặn thịt bò, đậu, gạo, rau củ và phô mai, tạo thành một bữa ăn hoàn chỉnh với hương vị Mexico truyền thống. Mỗi miếng burrito là một sự hòa quyện tuyệt vời giữa độ mềm của bánh và hương vị đậm đà bên trong.',
      quantity: 1,
    ),
    Breads(
      breadId: 12,
      price: 14,
      category: 'Mexico',
      breadName: 'Cheesy Quesadilla',
      size: 'Medium',
      rating: 4.3,
      servingTemperatureCelsius: 25,
      recommendedHeatingTemperature: '13 - 15',
      imageURL: 'assets/images/mexico/anh13.png',
      description: 'Cheesy Quesadilla là món bánh tortilla nướng giòn với lớp nhân phô mai tan chảy kéo sợi hấp dẫn, có thể kết hợp thêm các nguyên liệu như gà, bò hoặc rau củ tùy chọn. Món ăn đơn giản nhưng thơm ngon, phù hợp với cả trẻ em và người lớn.',
      quantity: 1,
    ),
    Breads(
      breadId: 13,
      price: 22,
      category: 'Mexico',
      breadName: 'Chicken Enchilada',
      size: 'Large',
      rating: 4.6,
      servingTemperatureCelsius: 10,
      recommendedHeatingTemperature: '18 - 20',
      imageURL: 'assets/images/mexico/anh14.png',
      description: 'Chicken Enchilada là món ăn Mexico truyền thống gồm bánh tortilla cuộn thịt gà, phủ lớp sốt đỏ cay đặc trưng và phô mai béo ngậy, sau đó được đem nướng tạo nên hương vị thơm lừng và đặc sắc. Món ăn thích hợp cho bữa trưa hoặc tối đầy đủ dinh dưỡng.',
      quantity: 1,
    ),
    Breads(
      breadId: 14,
      price: 9,
      category: 'Mexico',
      breadName: 'Loaded Nachos',
      size: 'Small',
      rating: 4.4,
      servingTemperatureCelsius: 25,
      recommendedHeatingTemperature: '20',
      imageURL: 'assets/images/mexico/anh15.png',
      description: 'Loaded Nachos là món ăn nhẹ hấp dẫn với lớp khoai tây tortilla chiên giòn, phủ phô mai tan chảy, sốt salsa cay nồng, jalapeño và kem chua béo ngậy. Món ăn rất phù hợp để dùng kèm trong các buổi tụ họp bạn bè hoặc bữa ăn nhanh.',
      quantity: 1,
    ),
    Breads(
      breadId: 15,
      price: 19,
      category: 'Hamburger',
      breadName: 'Classic Beef Burger',
      size: 'Medium',
      rating: 4.8,
      servingTemperatureCelsius: 40,
      recommendedHeatingTemperature: '16 - 18',
      imageURL: 'assets/images/hamburger/anh16.png',
      description: 'Classic Beef Burger là chiếc bánh mì kẹp thịt bò cổ điển với lớp nhân thịt bò dày dặn, rau xà lách, cà chua, hành tây và sốt đặc trưng. Mỗi chiếc burger là sự kết hợp hài hòa giữa độ mềm, độ giòn và hương vị mặn ngọt hấp dẫn.',
      quantity: 1,
    ),
    Breads(
      breadId: 16,
      price: 21,
      category: 'Hamburger',
      breadName: 'Cheesy Bacon Burger',
      size: 'Large',
      rating: 4.9,
      servingTemperatureCelsius: 5,
      recommendedHeatingTemperature: '17 - 19',
      imageURL: 'assets/images/hamburger/anh17.png',
      description: 'Cheesy Bacon Burger là phiên bản burger cao cấp với lớp nhân thịt bò nướng chín tới, phô mai tan chảy và thịt xông khói giòn thơm. Đây là lựa chọn hoàn hảo cho những ai yêu thích vị béo ngậy và đậm đà.',
      quantity: 1,
    ),
    Breads(
      breadId: 17,
      price: 17,
      category: 'Hamburger',
      breadName: 'Spicy Chicken Burger',
      size: 'Medium',
      rating: 4.5,
      servingTemperatureCelsius: 4,
      recommendedHeatingTemperature: '15 - 17',
      imageURL: 'assets/images/hamburger/anh18.png',
      description: 'Spicy Chicken Burger là sự lựa chọn tuyệt vời cho những ai thích vị cay nồng, với lớp thịt gà chiên giòn tẩm ướp gia vị đặc biệt, đi kèm rau tươi và sốt cay độc đáo. Món ăn này vừa ngon miệng vừa lôi cuốn.',
      quantity: 1,
    ),
    Breads(
      breadId: 18,
      price: 20,
      category: 'Hamburger',
      breadName: 'Mushroom Swiss Burger',
      size: 'Large',
      rating: 4.7,
      servingTemperatureCelsius: 22,
      recommendedHeatingTemperature: '16 - 18',
      imageURL: 'assets/images/hamburger/anh19.png',
      description: 'Mushroom Swiss Burger là sự hòa quyện hoàn hảo giữa thịt bò nướng, nấm xào thơm và phô mai Thụy Sĩ béo ngậy. Món ăn mang hương vị thanh tao nhưng vẫn đậm đà, rất thích hợp cho thực khách yêu thích món ăn sang trọng.',
      quantity: 1,
    ),
    Breads(
      breadId: 19,
      price: 16,
      category: 'Hamburger',
      breadName: 'Vegetarian Delight',
      size: 'Small',
      rating: 4.2,
      servingTemperatureCelsius: 16,
      recommendedHeatingTemperature: '14 - 16',
      imageURL: 'assets/images/hamburger/anh20.png',
      description: 'Vegetarian Delight là chiếc burger chay với nhân rau củ nướng đậm đà, sốt đặc biệt và bánh mì giòn thơm. Món ăn dành riêng cho người ăn chay nhưng vẫn đảm bảo đầy đủ chất và hương vị tuyệt vời.',
      quantity: 1,
    ),
  ];

  Breads copyWith({int? quantity}) {
    return Breads(
        breadId: breadId,
        price: price,
        category: category,
        breadName: breadName,
        size: size,
        rating: rating,
        servingTemperatureCelsius: servingTemperatureCelsius,
        recommendedHeatingTemperature: recommendedHeatingTemperature,
        imageURL: imageURL,
        description: description,
        quantity: quantity ?? this.quantity);
  }
}
