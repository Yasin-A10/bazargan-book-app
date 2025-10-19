// class AudioBookModel {
//   final String uuid;
//   final String name;
//   final String createdAt;
//   final String? picture;
//   final String fileType;
//   final MediaLink mediaLink;
//   final ExtraData extraData;
//   final String bookPic;
//   final String narrator;
//   final Publisher publisher;
//   final List<Author> authors;
//   final int parentBookId;
//   final int id;

//   AudioBookModel({
//     required this.uuid,
//     required this.name,
//     required this.createdAt,
//     this.picture,
//     required this.fileType,
//     required this.mediaLink,
//     required this.extraData,
//     required this.bookPic,
//     required this.narrator,
//     required this.publisher,
//     required this.authors,
//     required this.parentBookId,
//     required this.id,
//   });

//   factory AudioBookModel.fromJson(Map<String, dynamic> json) {
//     return AudioBookModel(
//       uuid: json['uuid'],
//       name: json['name'],
//       createdAt: json['created_at'],
//       picture: json['picture'],
//       fileType: json['file_type'],
//       mediaLink: MediaLink.fromJson(json['media_link']),
//       extraData: ExtraData.fromJson(json['extra_data']),
//       bookPic: json['book_pic'],
//       narrator: json['narrator'],
//       publisher: Publisher.fromJson(json['publisher']),
//       // authors: (json['author'] as List).map((a) => Author.fromJson(a)).toList(),
//       authors: (json['author'] as List).map((a) => Author.fromJson(a)).toList(),

//       // parentBookId: json['parent_book_id'],
//       // id: json['id'],
//       parentBookId: json['parent_book_id'] is int
//           ? json['parent_book_id']
//           : int.tryParse(json['parent_book_id'].toString()) ?? 0,
//       id: json['id'] is int
//           ? json['id']
//           : int.tryParse(json['id'].toString()) ?? 0,
//     );
//   }
// }

// class MediaLink {
//   final String name;
//   final String file;
//   final String token;

//   MediaLink({required this.name, required this.file, required this.token});

//   factory MediaLink.fromJson(Map<String, dynamic> json) {
//     return MediaLink(
//       name: json['name'],
//       file: json['file'],
//       token: json['token'],
//     );
//   }
// }

// class ExtraData {
//   final int duration;
//   final int fileSize;

//   ExtraData({required this.duration, required this.fileSize});

//   factory ExtraData.fromJson(Map<String, dynamic> json) {
//     return ExtraData(duration: json['duration'], fileSize: json['file_size']);
//   }
// }

// class Publisher {
//   final int id;
//   final String name;

//   Publisher({required this.id, required this.name});

//   factory Publisher.fromJson(Map<String, dynamic> json) {
//     return Publisher(id: json['id'], name: json['name']);
//   }
// }

// class Author {
//   final int id;
//   final String name;
//   final String? description;
//   final String? picture;

//   Author({
//     required this.id,
//     required this.name,
//     this.description,
//     this.picture,
//   });

//   factory Author.fromJson(Map<String, dynamic> json) {
//     return Author(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       picture: json['picture'],
//     );
//   }
// }

class AudioBookModel {
  String? uuid;
  String? name;
  String? createdAt;
  String? picture;
  String? fileType;
  MediaLink? mediaLink;
  ExtraData? extraData;
  String? bookPic;
  String? narrator;
  Publisher? publisher;
  List<Author>? author;
  int? parentBookId;
  int? id;

  AudioBookModel({
    this.uuid,
    this.name,
    this.createdAt,
    this.picture,
    this.fileType,
    this.mediaLink,
    this.extraData,
    this.bookPic,
    this.narrator,
    this.publisher,
    this.author,
    this.parentBookId,
    this.id,
  });

  AudioBookModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    createdAt = json['created_at'];
    picture = json['picture'];
    fileType = json['file_type'];
    mediaLink = json['media_link'] != null
        ? MediaLink.fromJson(json['media_link'])
        : null;
    extraData = json['extra_data'] != null
        ? ExtraData.fromJson(json['extra_data'])
        : null;
    bookPic = json['book_pic'];
    narrator = json['narrator'];
    publisher = json['publisher'] != null
        ? Publisher.fromJson(json['publisher'])
        : null;
    if (json['author'] != null) {
      author = <Author>[];
      json['author'].forEach((v) {
        author!.add(Author.fromJson(v));
      });
    }
    parentBookId = json['parent_book_id'] is int
        ? json['parent_book_id']
        : int.tryParse(json['parent_book_id']?.toString() ?? '');
    id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['picture'] = picture;
    data['file_type'] = fileType;
    if (mediaLink != null) {
      data['media_link'] = mediaLink!.toJson();
    }
    if (extraData != null) {
      data['extra_data'] = extraData!.toJson();
    }
    data['book_pic'] = bookPic;
    data['narrator'] = narrator;
    if (publisher != null) {
      data['publisher'] = publisher!.toJson();
    }
    if (author != null) {
      data['author'] = author!.map((v) => v.toJson()).toList();
    }
    data['parent_book_id'] = parentBookId;
    data['id'] = id;
    return data;
  }
}

class MediaLink {
  String? name;
  String? file;
  String? token;

  MediaLink({this.name, this.file, this.token});

  MediaLink.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    file = json['file'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['file'] = file;
    data['token'] = token;
    return data;
  }
}

class ExtraData {
  int? duration;
  int? fileSize;

  ExtraData({this.duration, this.fileSize});

  ExtraData.fromJson(Map<String, dynamic> json) {
    duration = json['duration'] is int
        ? json['duration']
        : int.tryParse(json['duration']?.toString() ?? '');
    fileSize = json['file_size'] is int
        ? json['file_size']
        : int.tryParse(json['file_size']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    data['file_size'] = fileSize;
    return data;
  }
}

class Publisher {
  int? id;
  String? name;

  Publisher({this.id, this.name});

  Publisher.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '');
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Author {
  int? id;
  String? name;
  String? description;
  String? picture;

  Author({this.id, this.name, this.description, this.picture});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '');
    name = json['name'];
    description = json['description'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['picture'] = picture;
    return data;
  }
}
