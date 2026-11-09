import 'package:android_dev/screens/home_screen/models/comment_model.dart';
import 'package:android_dev/screens/home_screen/models/post_model.dart';
import 'package:android_dev/screens/home_screen/models/story_model.dart';

// Mock data for the feed. picsum.photos/seed/<word> always returns
// the same photo for the same word, so every post has its own image.

final List<PostModel> postsData = [
  PostModel(
    imageUrl: 'https://picsum.photos/seed/issykkul/600/600',
    description: 'Иссык-Куль утром — вода как зеркало 🌊',
    likeCount: 124,
    comments: [
      CommentModel(userName: 'aigerim', text: 'Мечтаю туда летом!', likeCount: 8),
      CommentModel(userName: 'nurlan_dev', text: 'Это Чолпон-Ата?', likeCount: 2),
      CommentModel(userName: 'dana.k', text: 'Вода просто нереальная 😍', likeCount: 5),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/alaarcha/600/600',
    description: 'Поход в Ала-Арчу. 12 км и ни разу не пожалел 🏔️',
    likeCount: 89,
    comments: [
      CommentModel(userName: 'timur', text: 'До водопада дошёл?', likeCount: 3),
      CommentModel(userName: 'bekzat_99', text: 'Возьми в следующий раз с собой!', likeCount: 1),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/coffee/600/600',
    description: 'Лучший кофе в Бишкеке нашёлся случайно ☕',
    likeCount: 56,
    comments: [
      CommentModel(userName: 'madina', text: 'Скинь адрес пожалуйста', likeCount: 4),
      CommentModel(userName: 'aigerim', text: 'Это на Токтогула?', likeCount: 0),
      CommentModel(userName: 'erlan', text: 'Там ещё чизкейк топ', likeCount: 6),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/laptop/600/600',
    description: 'Первое Flutter-приложение запустилось без ошибок 🎉',
    likeCount: 210,
    comments: [
      CommentModel(userName: 'nurlan_dev', text: 'Поздравляю! Дальше — больше', likeCount: 15),
      CommentModel(userName: 'kanat.code', text: 'А state management какой?', likeCount: 4),
      CommentModel(userName: 'dana.k', text: 'Красавчик 👏', likeCount: 2),
      CommentModel(userName: 'timur', text: 'Покажешь код?', likeCount: 1),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/sunset/600/600',
    description: 'Закат с крыши общежития 🌇',
    likeCount: 73,
    comments: [
      CommentModel(userName: 'madina', text: 'Какие цвета!', likeCount: 3),
      CommentModel(userName: 'bekzat_99', text: 'На какой телефон снимал?', likeCount: 2),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/plov/600/600',
    description: 'Мамин плов — ничего лучше нет 🍚',
    likeCount: 145,
    comments: [
      CommentModel(userName: 'erlan', text: 'Слюнки потекли', likeCount: 9),
      CommentModel(userName: 'aigerim', text: 'Рецепт в студию!', likeCount: 7),
      CommentModel(userName: 'timur', text: 'Я уже еду 🚗', likeCount: 11),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/library/600/600',
    description: 'Сессия близко, живу в библиотеке 📚',
    likeCount: 38,
    comments: [
      CommentModel(userName: 'kanat.code', text: 'Держись, брат', likeCount: 2),
      CommentModel(userName: 'dana.k', text: 'Я на соседнем столе 😅', likeCount: 5),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/football/600/600',
    description: 'Выиграли межфакультетский турнир по футболу ⚽🏆',
    likeCount: 302,
    comments: [
      CommentModel(userName: 'bekzat_99', text: 'Это было мощно!', likeCount: 20),
      CommentModel(userName: 'erlan', text: 'Гол на последней минуте 🔥', likeCount: 14),
      CommentModel(userName: 'nurlan_dev', text: 'Поздравляю команду', likeCount: 3),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/snow/600/600',
    description: 'Первый снег в этом году ❄️',
    likeCount: 67,
    comments: [
      CommentModel(userName: 'madina', text: 'Уже?! Не готова к зиме', likeCount: 6),
      CommentModel(userName: 'timur', text: 'Пора на Каракол кататься', likeCount: 4),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/cat/600/600',
    description: 'Знакомьтесь, это Барсик. Он главный в доме 🐱',
    likeCount: 412,
    comments: [
      CommentModel(userName: 'aigerim', text: 'Какой милый!!!', likeCount: 18),
      CommentModel(userName: 'dana.k', text: 'Барсик лучший 😻', likeCount: 10),
      CommentModel(userName: 'kanat.code', text: 'Взгляд начальника', likeCount: 22),
      CommentModel(userName: 'erlan', text: 'Хочу такого же', likeCount: 1),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/concert/600/600',
    description: 'Концерт был просто огонь 🎸',
    likeCount: 98,
    comments: [
      CommentModel(userName: 'bekzat_99', text: 'Я тоже там был!', likeCount: 3),
      CommentModel(userName: 'madina', text: 'Завидую белой завистью', likeCount: 2),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/bike/600/600',
    description: '40 км на велике вокруг города 🚴',
    likeCount: 51,
    comments: [
      CommentModel(userName: 'timur', text: 'Какой маршрут?', likeCount: 1),
      CommentModel(userName: 'nurlan_dev', text: 'Ноги после такого живы?', likeCount: 5),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/books/600/600',
    description: 'Прочитал 10 книг за осень. Советую «Чистый код» 📖',
    likeCount: 84,
    comments: [
      CommentModel(userName: 'kanat.code', text: 'Мастхэв для программиста', likeCount: 9),
      CommentModel(userName: 'aigerim', text: 'Дай почитать потом', likeCount: 2),
      CommentModel(userName: 'erlan', text: 'Ещё «Грокаем алгоритмы» хорошая', likeCount: 6),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/osh/600/600',
    description: 'Ош — город с историей в 3000 лет 🏛️',
    likeCount: 133,
    comments: [
      CommentModel(userName: 'madina', text: 'Сулайман-Тоо на фоне?', likeCount: 4),
      CommentModel(userName: 'bekzat_99', text: 'Родной город ❤️', likeCount: 12),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/hackathon/600/600',
    description: '48 часов хакатона, 3 пиццы и одно рабочее MVP 💻',
    likeCount: 176,
    comments: [
      CommentModel(userName: 'nurlan_dev', text: 'Какое место заняли?', likeCount: 3),
      CommentModel(userName: 'kanat.code', text: 'Второе! 🥈', likeCount: 17),
      CommentModel(userName: 'dana.k', text: 'Вы крутые', likeCount: 4),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/horse/600/600',
    description: 'Выходные на джайлоо, кони и свежий воздух 🐎',
    likeCount: 92,
    comments: [
      CommentModel(userName: 'erlan', text: 'Вот это отдых', likeCount: 5),
      CommentModel(userName: 'timur', text: 'Кумыс пил?', likeCount: 8),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/rain/600/600',
    description: 'Дождливый день — идеально для кодинга 🌧️',
    likeCount: 29,
    comments: [
      CommentModel(userName: 'aigerim', text: 'И для сна тоже 😴', likeCount: 7),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/graduation/600/600',
    description: 'Брат окончил университет! Горжусь 🎓',
    likeCount: 268,
    comments: [
      CommentModel(userName: 'madina', text: 'Поздравляю вашу семью!', likeCount: 6),
      CommentModel(userName: 'bekzat_99', text: 'Красавчик, передай поздравления', likeCount: 4),
      CommentModel(userName: 'nurlan_dev', text: 'Скоро и мы так 🙏', likeCount: 9),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/market/600/600',
    description: 'Ошский базар, фрукты прямо с грядки 🍑',
    likeCount: 61,
    comments: [
      CommentModel(userName: 'dana.k', text: 'Персики выглядят сочно', likeCount: 3),
      CommentModel(userName: 'erlan', text: 'Почём брал?', likeCount: 1),
    ],
  ),
  PostModel(
    imageUrl: 'https://picsum.photos/seed/stars/600/600',
    description: 'Ночное небо в горах — миллион звёзд ✨',
    likeCount: 189,
    comments: [
      CommentModel(userName: 'kanat.code', text: 'Это Млечный путь?', likeCount: 5),
      CommentModel(userName: 'aigerim', text: 'Обои на телефон готовы', likeCount: 13),
      CommentModel(userName: 'timur', text: 'Сон-Куль?', likeCount: 2),
    ],
  ),
];

// i.pravatar.cc/150?img=<n> returns a stable avatar photo for each number.
final List<StoryModel> storiesData = [
  StoryModel(userName: 'aigerim', avatarUrl: 'https://i.pravatar.cc/150?img=1'),
  StoryModel(userName: 'nurlan_dev', avatarUrl: 'https://i.pravatar.cc/150?img=12'),
  StoryModel(userName: 'dana.k', avatarUrl: 'https://i.pravatar.cc/150?img=5'),
  StoryModel(userName: 'timur', avatarUrl: 'https://i.pravatar.cc/150?img=14'),
  StoryModel(userName: 'madina', avatarUrl: 'https://i.pravatar.cc/150?img=9'),
  StoryModel(userName: 'bekzat_99', avatarUrl: 'https://i.pravatar.cc/150?img=15'),
  StoryModel(userName: 'erlan', avatarUrl: 'https://i.pravatar.cc/150?img=33'),
  StoryModel(userName: 'kanat.code', avatarUrl: 'https://i.pravatar.cc/150?img=51'),
  StoryModel(userName: 'aliya', avatarUrl: 'https://i.pravatar.cc/150?img=20'),
  StoryModel(userName: 'syimyk', avatarUrl: 'https://i.pravatar.cc/150?img=59'),
];
