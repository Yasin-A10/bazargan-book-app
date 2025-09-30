class HomePageModel {
  final SliderModel slider;
  final List<Book> bestSellerBooks;
  final List<Book> popularBooks;
  final List<CategoryModel> categories;

  HomePageModel({
    required this.slider,
    required this.bestSellerBooks,
    required this.popularBooks,
    required this.categories,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    return HomePageModel(
      slider: SliderModel.fromJson(json['slider']),
      bestSellerBooks: (json['best_seller_books'] as List)
          .map((e) => Book.fromJson(e))
          .toList(),
      popularBooks: (json['popular_books'] as List)
          .map((e) => Book.fromJson(e))
          .toList(),
      categories: (json['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
    );
  }
}

class SliderModel {
  final int id;
  final String name;
  final String position;
  final List<Slide> slides;

  SliderModel({
    required this.id,
    required this.name,
    required this.position,
    required this.slides,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      slides: (json['slides'] as List).map((e) => Slide.fromJson(e)).toList(),
    );
  }
}

class Slide {
  final int id;
  final Media image;
  final Media backgroundImage;
  final String? link;

  Slide({
    required this.id,
    required this.image,
    required this.backgroundImage,
    this.link,
  });

  factory Slide.fromJson(Map<String, dynamic> json) {
    return Slide(
      id: json['id'],
      image: Media.fromJson(json['image']),
      backgroundImage: Media.fromJson(json['background_image']),
      link: json['link'],
    );
  }
}

class Media {
  final int id;
  final String url;

  Media({required this.id, required this.url});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(id: json['id'], url: json['url']);
  }
}

class Book {
  final int id;
  final String picture;
  final String type;
  final int price;
  final int discountPercent;
  final int priceWithDiscount;
  final bool isInInfinity;
  final String? appThumbnail;
  final String thumbnail;

  Book({
    required this.id,
    required this.picture,
    required this.type,
    required this.price,
    required this.discountPercent,
    required this.priceWithDiscount,
    required this.isInInfinity,
    this.appThumbnail,
    required this.thumbnail,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      picture: json['picture'],
      type: json['type'],
      price: json['price'],
      discountPercent: json['discount_percent'],
      priceWithDiscount: json['price_with_discount'],
      isInInfinity: json['is_in_infinity'],
      appThumbnail: json['app_thumbnail'],
      thumbnail: json['thumbnail'],
    );
  }
}

class CategoryModel {
  final int id;
  final String title;
  final String icon;
  final bool isInLanding;
  final String status;

  CategoryModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.isInLanding,
    required this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      isInLanding: json['is_in_landing'],
      status: json['status'],
    );
  }
}
