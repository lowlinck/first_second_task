-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 26 2021 г., 14:48
-- Версия сервера: 5.7.33-log
-- Версия PHP: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `mesends`
--

-- --------------------------------------------------------

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

--
-- Дамп данных таблицы `messages`
--

INSERT INTO `messages` (`id`, `message`, `user_id`, `chat_id`, `date_create`) VALUES
(11, 'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean', 9, 7, '2021-10-26 09:13:33'),
(12, 'Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi', 6, 19, '2021-10-26 09:13:33'),
(13, 'tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum', 5, 1, '2021-10-26 09:13:33'),
(14, 'Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec', 1, 11, '2021-10-26 09:13:33'),
(15, 'eu tempor erat neque non quam. Pellentesque habitant morbi tristique', 1, 15, '2021-10-26 09:13:33'),
(16, 'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean', 9, 7, '2021-10-26 09:13:59'),
(17, 'Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi', 6, 19, '2021-10-26 09:13:59'),
(18, 'tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum', 5, 1, '2021-10-26 09:13:59'),
(19, 'Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec', 1, 11, '2021-10-26 09:13:59'),
(20, 'eu tempor erat neque non quam. Pellentesque habitant morbi tristique', 1, 15, '2021-10-26 09:13:59'),
(21, 'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean', 9, 7, '2021-10-26 09:14:00'),
(22, 'Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi', 6, 19, '2021-10-26 09:14:00'),
(23, 'tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum', 5, 1, '2021-10-26 09:14:00'),
(24, 'Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec', 1, 11, '2021-10-26 09:14:00'),
(25, 'eu tempor erat neque non quam. Pellentesque habitant morbi tristique', 1, 15, '2021-10-26 09:14:00');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`) VALUES
(6, 'Noble Jenkins'),
(7, 'Jescie Price'),
(8, 'Aquila Keith'),
(9, 'Hamish Simmons'),
(10, 'Althea Mcdowell'),
(11, 'Ne Jenkins'),
(12, 'Jeie Price'),
(13, 'Aqula Keith'),
(14, 'Haish Simmons'),
(15, 'Althea Mcell'),
(16, 'Ne Jenns'),
(17, 'Jeie Pce'),
(18, 'Aqula Keh'),
(19, 'Haish Simmons'),
(20, 'Ahea Mcell'),
(21, 'Ne Jenns'),
(22, 'Jeie Pce'),
(23, 'Aqula Keh'),
(24, 'Haish Simmons'),
(25, 'Ahea Mcell');

--
-- Индексы сохранённых таблиц
--

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
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `chats`
--
ALTER TABLE `chats`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
