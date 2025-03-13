├── core/
│   ├── bloc/
│   │   └── banks_bloc/
│   │       ├── banks_bloc.dart
│   │       ├── banks_event.dart
│   │       └── banks_state.dart
│   ├── data/
│   │   ├── models/
│   │   │   └── bank_model.dart
│   │   └── repositories/
│   │       └── banks_repository.dart
│   ├── domain/
│   │   ├── repositories/
│   │   │   └── banks_repository.dart
│   │   └── usecases/
│   │       └── bank_use_case.dart
│   ├── enum/
│   │   └── enum_sort_type.dart
│   ├── ui/
│   │   ├── screens/
│   │   │   ├── calculate_screen.dart
│   │   │   └── home_screen.dart
│   │   └── widgets/
│   ├── utils/
│   │   └── logger.dart
│   └── constants.dart
├── main.dart
└── test_app.dart

1. Запуск: Пользователь открывает приложение через main.dart, и первым делом видит home_screen.dart — список банков.
2. Загрузка данных: BanksBloc получает команду  на получение списка, обращается к bank_use_case.dart, тот дергает banks_repository.dart, а он берёт данные из JSON-файла и превращает их в объекты bank_model.dart.
3. Сортировка: Если пользователь хочет отсортировать (например, по ставке), BanksBloc обрабатывает событие из banks_event.dart, обновляет список и показывает результат через banks_state.dart.
4. Калькулятор: Пользователь нажимает кнопку, и снизу вылезает calculate_screen.dart как ModalBottomSheet. Вводишь сумму, срок, ставку — он считает и показывает платёж.
