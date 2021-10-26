--В чате может брать участие более двух пользователей
1. запросы на создание всех таблиц в вашей базе данных
==========================================================
--
-- Структура таблицы `chats`
--

CREATE TABLE `chats` (
  `id` int(20) NOT NULL,
  `title` varchar(70) NOT NULL DEFAULT '''chat''',
  `user_id` int(20) NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `chat_user`
--

CREATE TABLE `chat_user` (
  `chat_id` int(20) NOT NULL,
  `user_id` int(20) NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `message` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `chat_id` int(11) NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

----------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы таблицы `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `chat_user`
--
ALTER TABLE `chat_user`
  ADD PRIMARY KEY (`chat_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для таблицы `chats`
--
ALTER TABLE `chats`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

===========================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
===========================================================================
2. запрос при отправке сообщения от пользователя 1 к пользователю  2
===========================================================================
--если это первое сообщение в диалоге б то сначало создается чат, который возвращает chat_id

		INSERT INTO chats (title, user_id, date) VALUES (?, ?, ?);

		Название чата по умолчанию:
		INSERT INTO chats (user_id, date) VALUES (?, ?); 	

        далее запрос на вставку в промежуточной таблице пользователей этого чата (чат может быть более двух участников) где указывается ид чата и id пользователя
		INSERT INTO chat_user (chat_id, user_id, date) VALUES (?, ?, ?);

-- если чат уже существует, тогда делаем запрос на сохранение данных в таблице

		INSERT INTO messages
				(chat_id, user_id, message)
				VALUES
				(?, ?, ?, ?);
===========================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
===========================================================================
3. запрос на получение истории переписки между пользователем  1 и пользователем 2
===========================================================================

		SELECT * FROM messages as m WHERE m.chat_id=<CHAT_ID>;

===========================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
===========================================================================
4. запрос на получение списка всех диалогов, в которых участвует пользователь 1, с
сортировкой по последнему полученному сообщению (аналог как список чатов в
любом мессенджере) и с отображением участников диалога
===========================================================================

	SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
	SELECT ms.*, ch.title FROM (
		SELECT ml.chat_id, ml.user_id, ml.message, max(ml.date_create) as date_create FROM
			(SELECT m.* FROM
				(SELECT chat_id FROM chat_user WHERE user_id=<USER_ID>) as cu
				INNER JOIN (SELECT * FROM messages ORDER BY date_create DESC) as m ON (cu.chat_id=m.chat_id)
				ORDER BY m.date_create)
		 	as ml GROUP BY ml.chat_id ORDER BY ml.date_create DESC) AS ms
		INNER JOIN chats AS ch ON (ms.chat_id = ch.id);

возвращает необходимую информацию для отображения последних сообщений(список чатов) кроме информации о пользователях
chat_id  user_id  message  date_create  title


	SELECT cu.*, u.name FROM chat_user cu
	INNER JOIN users AS u ON (cu.user_id = u.id)
	WHERE cu.chat_id = <CHAD_ID>
Возвращает всех пользователей по данным чата указанного чата в виде
chat_id  user_id  date_create  name

===========================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
5. запрос на удаление одного сообщения в истории переписки
===========================================================================

DELETE FROM messages WHERE id = <MESSAGE_ID>

===========================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
===========================================================================
6. запрос на удаление всей истории переписки с пользователем
===========================================================================
   

DELETE FROM chat_user WHERE chat_id=<CHAT_ID> AND user_id=<user_ID>

===========================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Другие запросы
===========================================================================
SELECT m.message, m.date_create FROM `messages` m WHERE m.chat_id=<CHAT_ID> ORDER BY id DESC LIMIT 1
выбирает последнее сообщение чата если указать id чата
===========================================================================
SELECT cu.chat_id, m.message, m.date_create from messages m
	INNER JOIN chat_user cu on (m.chat_id = cu.chat_id)
выбирает все сообщения чата
===========================================================================
SELECT cu.chat_id FROM chat_user cu Where user_id = <USER_ID>
возвращает все чаты в которых участвовал user_id = <USER_ID>
===========================================================================
SELECT cu.chat_id, m.message, m.date_create FROM messages m
INNER JOIN ( SELECT cu.chat_id FROM chat_user cu Where user_id = <USER_ID> ) cu ON ( m.chat_id = cu.chat_id)
возвращает все сообщения по юзер_ід
===========================================================================
SELECT chat_id, message, max(date_created) as date_create FROM messages GROUP BY chat_id ORDER BY date_create DESC LIMIT 50
получаем последних  50 сообщений
===========================================================================
SELECT m.* FROM
(SELECT chat_id FROM chat_user WHERE user_id=<USER_ID>) cu
INNER JOIN (SELECT * FROM messages ORDER BY date_create DESC) as m ON (cu.chat_id=m.chat_id)
ORDER BY m.date_create
возвращаем все сообщения в которых брал участие юзер
===========================================================================
SELECT cu.*, u.name FROM chat_user AS cu
INNER JOIN users AS u ON (cu.user_id = u.id)
INNER JOIN chat_user AS cl ON (cu.chat_id = cl.chat_id) WHERE cl.user_id=2
ПОвертає всіх юзерів які брали участь заданим юзеа ід
Возвращаем всех пользователей которые брали участие с заданным юзер id
===========================================================================
DELETE FROM users WHERE user_id=<USER_ID>
Запрос на удаление пользователя
===========================================================================
DELETE FROM chat_user WHERE chat_id=<CHAT_ID> AND user_id=<USER_ID>
запрос на удаление пользователя из чата
===========================================================================
UPDATE messages m SET message=<MESSAGE> WHERE m.id=<MESSAGE_ID>;
Оновлює редактований меседж
Обновляет редактированный меседж
===========================================================================
UPDATE users u SET name=<NAME> WHERE u.id=<USER_ID>;
Обновляет данные пользователя
===========================================================================
UPDATE chats ch SET title=<TITLE> WHERE ch.id=<CHAT_ID>;
Обновляет название чата
===========================================================================
