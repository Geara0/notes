### Как запустить проект:

1. скачать с гита
2. выполнить команды
   2.1 `flutter pub get`
   2.2 `dart run build_runner build -d` 
3. `flutter run`

### Какие архитектурные подходы использовались

1. **BLoC (Business Logic Component)** — для управления состоянием и бизнес-логикой.
2. **Layered Architecture** — разделение на слои данных (DAO, DBService), бизнес-логики (BLoC), и представления (UI).
3. **Data Access Object (DAO)** — абстракция для доступа к данным базы данных.
4. **Data Transfer Object (DTO)** — передача данных между слоями, изоляция слоёв.
5. **Singleton** — в DBService для обеспечения единственного экземпляра базы данных.
6. **Dependency Separation** — BLoC зависит от сервисов, сервисы от DAO, UI от BLoC через состояния.
7. **Immutable Models** через Freezed — для безопасной передачи данных.
8. **Feature-based Organization** — группировка кода по функциональным возможностям (home, note).
9. **Reactive Programming** — использование Stream в notesStream() для наблюдения за изменениями данных в реальном времени.
10. **Service Layer** — DBService как отдельный слой для работы с данными.

(и какие не использовались):
1. **Dependency Injection** (вместо singleton) - оверкилл для такого простого приложения

### Доп фичи:

1. Проверка на несохраненные изменения при создании/редактировании заметки
