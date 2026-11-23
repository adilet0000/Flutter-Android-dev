// Seed data: written into the database ONCE, on the very first app launch
// (see AppDatabase.migration → onCreate). After that the app reads only
// from the database, this file is not used anymore.
//
// Every seed user has the demo password: password123

class SeedUser {
  final String userName;
  final String avatarUrl;
  const SeedUser({required this.userName, required this.avatarUrl});
}

class SeedComment {
  final String userName;
  final String text;
  final int likeCount; // how many seed users will like this comment (max 10)
  const SeedComment({required this.userName, required this.text, this.likeCount = 0});
}

class SeedPost {
  final String imageUrl;
  final String description;
  final int likeCount; // turned into real rows in post_likes (see seeding)
  final List<SeedComment> comments;
  const SeedPost({
    required this.imageUrl,
    required this.description,
    this.likeCount = 0,
    this.comments = const [],
  });
}

const demoPassword = 'password123';

// picsum.photos/seed/<word> always returns the same photo for the same word.

final List<SeedPost> seedPosts = [
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/issykkul/600/600',
    description: 'Иссык-Куль утром — вода как зеркало 🌊',
    likeCount: 124,
    comments: [
      SeedComment(userName: 'aigerim', text: 'Мечтаю туда летом!', likeCount: 8),
      SeedComment(userName: 'nurlan_dev', text: 'Это Чолпон-Ата?', likeCount: 2),
      SeedComment(userName: 'dana.k', text: 'Вода просто нереальная 😍', likeCount: 5),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/alaarcha/600/600',
    description: 'Поход в Ала-Арчу. 12 км и ни разу не пожалел 🏔️',
    likeCount: 89,
    comments: [
      SeedComment(userName: 'timur', text: 'До водопада дошёл?', likeCount: 3),
      SeedComment(userName: 'bekzat_99', text: 'Возьми в следующий раз с собой!', likeCount: 1),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/coffee/600/600',
    description: 'Лучший кофе в Бишкеке нашёлся случайно ☕',
    likeCount: 56,
    comments: [
      SeedComment(userName: 'madina', text: 'Скинь адрес пожалуйста', likeCount: 4),
      SeedComment(userName: 'aigerim', text: 'Это на Токтогула?', likeCount: 0),
      SeedComment(userName: 'erlan', text: 'Там ещё чизкейк топ', likeCount: 6),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/laptop/600/600',
    description: 'Первое Flutter-приложение запустилось без ошибок 🎉',
    likeCount: 210,
    comments: [
      SeedComment(userName: 'nurlan_dev', text: 'Поздравляю! Дальше — больше', likeCount: 15),
      SeedComment(userName: 'kanat.code', text: 'А state management какой?', likeCount: 4),
      SeedComment(userName: 'dana.k', text: 'Красавчик 👏', likeCount: 2),
      SeedComment(userName: 'timur', text: 'Покажешь код?', likeCount: 1),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/sunset/600/600',
    description: 'Закат с крыши общежития 🌇',
    likeCount: 73,
    comments: [
      SeedComment(userName: 'madina', text: 'Какие цвета!', likeCount: 3),
      SeedComment(userName: 'bekzat_99', text: 'На какой телефон снимал?', likeCount: 2),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/plov/600/600',
    description: 'Мамин плов — ничего лучше нет 🍚',
    likeCount: 145,
    comments: [
      SeedComment(userName: 'erlan', text: 'Слюнки потекли', likeCount: 9),
      SeedComment(userName: 'aigerim', text: 'Рецепт в студию!', likeCount: 7),
      SeedComment(userName: 'timur', text: 'Я уже еду 🚗', likeCount: 11),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/library/600/600',
    description: 'Сессия близко, живу в библиотеке 📚',
    likeCount: 38,
    comments: [
      SeedComment(userName: 'kanat.code', text: 'Держись, брат', likeCount: 2),
      SeedComment(userName: 'dana.k', text: 'Я на соседнем столе 😅', likeCount: 5),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/football/600/600',
    description: 'Выиграли межфакультетский турнир по футболу ⚽🏆',
    likeCount: 302,
    comments: [
      SeedComment(userName: 'bekzat_99', text: 'Это было мощно!', likeCount: 20),
      SeedComment(userName: 'erlan', text: 'Гол на последней минуте 🔥', likeCount: 14),
      SeedComment(userName: 'nurlan_dev', text: 'Поздравляю команду', likeCount: 3),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/snow/600/600',
    description: 'Первый снег в этом году ❄️',
    likeCount: 67,
    comments: [
      SeedComment(userName: 'madina', text: 'Уже?! Не готова к зиме', likeCount: 6),
      SeedComment(userName: 'timur', text: 'Пора на Каракол кататься', likeCount: 4),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/cat/600/600',
    description: 'Знакомьтесь, это Барсик. Он главный в доме 🐱',
    likeCount: 412,
    comments: [
      SeedComment(userName: 'aigerim', text: 'Какой милый!!!', likeCount: 18),
      SeedComment(userName: 'dana.k', text: 'Барсик лучший 😻', likeCount: 10),
      SeedComment(userName: 'kanat.code', text: 'Взгляд начальника', likeCount: 22),
      SeedComment(userName: 'erlan', text: 'Хочу такого же', likeCount: 1),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/concert/600/600',
    description: 'Концерт был просто огонь 🎸',
    likeCount: 98,
    comments: [
      SeedComment(userName: 'bekzat_99', text: 'Я тоже там был!', likeCount: 3),
      SeedComment(userName: 'madina', text: 'Завидую белой завистью', likeCount: 2),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/bike/600/600',
    description: '40 км на велике вокруг города 🚴',
    likeCount: 51,
    comments: [
      SeedComment(userName: 'timur', text: 'Какой маршрут?', likeCount: 1),
      SeedComment(userName: 'nurlan_dev', text: 'Ноги после такого живы?', likeCount: 5),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/books/600/600',
    description: 'Прочитал 10 книг за осень. Советую «Чистый код» 📖',
    likeCount: 84,
    comments: [
      SeedComment(userName: 'kanat.code', text: 'Мастхэв для программиста', likeCount: 9),
      SeedComment(userName: 'aigerim', text: 'Дай почитать потом', likeCount: 2),
      SeedComment(userName: 'erlan', text: 'Ещё «Грокаем алгоритмы» хорошая', likeCount: 6),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/osh/600/600',
    description: 'Ош — город с историей в 3000 лет 🏛️',
    likeCount: 133,
    comments: [
      SeedComment(userName: 'madina', text: 'Сулайман-Тоо на фоне?', likeCount: 4),
      SeedComment(userName: 'bekzat_99', text: 'Родной город ❤️', likeCount: 12),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/hackathon/600/600',
    description: '48 часов хакатона, 3 пиццы и одно рабочее MVP 💻',
    likeCount: 176,
    comments: [
      SeedComment(userName: 'nurlan_dev', text: 'Какое место заняли?', likeCount: 3),
      SeedComment(userName: 'kanat.code', text: 'Второе! 🥈', likeCount: 17),
      SeedComment(userName: 'dana.k', text: 'Вы крутые', likeCount: 4),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/horse/600/600',
    description: 'Выходные на джайлоо, кони и свежий воздух 🐎',
    likeCount: 92,
    comments: [
      SeedComment(userName: 'erlan', text: 'Вот это отдых', likeCount: 5),
      SeedComment(userName: 'timur', text: 'Кумыс пил?', likeCount: 8),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/rain/600/600',
    description: 'Дождливый день — идеально для кодинга 🌧️',
    likeCount: 29,
    comments: [
      SeedComment(userName: 'aigerim', text: 'И для сна тоже 😴', likeCount: 7),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/graduation/600/600',
    description: 'Брат окончил университет! Горжусь 🎓',
    likeCount: 268,
    comments: [
      SeedComment(userName: 'madina', text: 'Поздравляю вашу семью!', likeCount: 6),
      SeedComment(userName: 'bekzat_99', text: 'Красавчик, передай поздравления', likeCount: 4),
      SeedComment(userName: 'nurlan_dev', text: 'Скоро и мы так 🙏', likeCount: 9),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/market/600/600',
    description: 'Ошский базар, фрукты прямо с грядки 🍑',
    likeCount: 61,
    comments: [
      SeedComment(userName: 'dana.k', text: 'Персики выглядят сочно', likeCount: 3),
      SeedComment(userName: 'erlan', text: 'Почём брал?', likeCount: 1),
    ],
  ),
  SeedPost(
    imageUrl: 'https://picsum.photos/seed/stars/600/600',
    description: 'Ночное небо в горах — миллион звёзд ✨',
    likeCount: 189,
    comments: [
      SeedComment(userName: 'kanat.code', text: 'Это Млечный путь?', likeCount: 5),
      SeedComment(userName: 'aigerim', text: 'Обои на телефон готовы', likeCount: 13),
      SeedComment(userName: 'timur', text: 'Сон-Куль?', likeCount: 2),
    ],
  ),
];

// i.pravatar.cc/150?img=<n> returns a stable avatar photo for each number.
final List<SeedUser> seedUsers = [
  SeedUser(userName: 'aigerim', avatarUrl: 'https://i.pravatar.cc/150?img=1'),
  SeedUser(userName: 'nurlan_dev', avatarUrl: 'https://i.pravatar.cc/150?img=12'),
  SeedUser(userName: 'dana.k', avatarUrl: 'https://i.pravatar.cc/150?img=5'),
  SeedUser(userName: 'timur', avatarUrl: 'https://i.pravatar.cc/150?img=14'),
  SeedUser(userName: 'madina', avatarUrl: 'https://i.pravatar.cc/150?img=9'),
  SeedUser(userName: 'bekzat_99', avatarUrl: 'https://i.pravatar.cc/150?img=15'),
  SeedUser(userName: 'erlan', avatarUrl: 'https://i.pravatar.cc/150?img=33'),
  SeedUser(userName: 'kanat.code', avatarUrl: 'https://i.pravatar.cc/150?img=51'),
  SeedUser(userName: 'aliya', avatarUrl: 'https://i.pravatar.cc/150?img=20'),
  SeedUser(userName: 'syimyk', avatarUrl: 'https://i.pravatar.cc/150?img=59'),
];
