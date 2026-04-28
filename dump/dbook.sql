-- phpMyAdmin SQL Dump
-- version 5.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- База данных: `dbook`

-- Структура таблицы `Authors`

CREATE TABLE `Authors` (
  `author_id` int NOT NULL,
  `name` text NOT NULL,
  `surname` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Authors` (`author_id`, `name`, `surname`, `country`, `date_of_birth`) VALUES
(1, 'Валерий', 'Карпов', 'Россия', '1994-04-03'),
(2, 'Степан', 'Петров', 'Россия', '1984-08-08'),
(3, 'Игорь', 'Вышин', 'Казахстан', '1966-10-10'),
(4, 'Фома', 'Богданов', 'Россия', '1977-04-05'),
(5, 'Роберт', 'Полсон', 'США', '1999-01-10'),
(6, 'Люк', 'Шоу', 'США', '1985-04-11');

-- Структура таблицы `Books`

CREATE TABLE `Books` (
  `book_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `author_id` int NOT NULL,
  `publisher_id` int NOT NULL,
  `god_izdaniya` int NOT NULL,
  `genre` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Books` (`book_id`, `title`, `author_id`, `publisher_id`, `god_izdaniya`, `genre`, `price`) VALUES
(1, 'Дум', 1, 1, 2000, 'Фантастик', '521.00'),
(2, 'Соловей', 1, 1, 1995, 'Роман', '500.00'),
(3, 'Сладкая соль', 1, 1, 2005, 'Триллер', '999.00'),
(4, 'Степь', 3, 3, 2001, 'Приключения', '499.00'),
(5, 'Битва 1466', 4, 2, 1988, 'История', '400.00'),
(6, 'Подводные глубины', 2, 4, 2000, 'Образование и наука', '800.00'),
(7, 'Гэрри Потнер', 6, 2, 2004, 'Фантастика', '500.00'),
(8, 'Как добиться успеха ничего не делая', 5, 4, 2005, 'Бизнес', '600.00'),
(13, 'ХХУХ', 5, 1, 2012, 'Экшен', '555.00');

-- Структура таблицы `Customers`

CREATE TABLE `Customers` (
  `customer_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Customers` (`customer_id`, `name`, `surname`, `address`, `email`, `phone_number`) VALUES
(2, 'Коля', 'Иванов', 'кан. Грибоедова, д.31, к.1, кв.42', 'kolya.ivanov@gmail.com', '9568480268'),
(4, 'Богдан', 'Богомолов', 'ул. Ленина, д.1, кв.3', 'bog.dan@yandex.ru', '9345543554'),
(5, 'Александр', 'Александров', 'ул. Пушкина, д.7, кв.523', 'a.aleksandrov@mail.ru', '945564565445'),
(6, 'Евгения', 'Столярова', 'ул. Комсомольская, д.2, кв.112', 'evg.stlrv@mail.ru', '9435434543434');

-- Структура таблицы `Orders`

CREATE TABLE `Orders` (
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `order_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `book_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Orders` (`order_id`, `customer_id`, `order_date`, `status`, `book_id`) VALUES
(3, 2, '2024-11-10', 'Готов', 3),
(4, 4, '2023-11-24', 'В процессе', 4),
(5, 5, '2023-11-25', 'Готов', 7),
(6, 6, '2023-11-25', 'Готов', 7),
(7, 5, '2023-11-29', 'В процессе', 8),
(8, 4, '2023-11-29', 'Готов', 1),
(9, 5, '2023-11-29', 'Готов', 8);

-- Структура таблицы `OrdersBooks`

CREATE TABLE `OrdersBooks` (
  `order_id` int NOT NULL,
  `book_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `OrdersBooks` (`order_id`, `book_id`) VALUES
(8, 1),
(3, 3),
(4, 4),
(5, 7),
(6, 7),
(7, 8),
(9, 8);

-- Структура таблицы `Publishers`

CREATE TABLE `Publishers` (
  `publisher_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `country` varchar(255) DEFAULT 'Россия',
  `phone_number` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `Publishers` (`publisher_id`, `name`, `country`, `phone_number`) VALUES
(1, 'Сливасы', 'Россия', '912312341234'),
(2, 'Славная книга', 'Россия', '95834560402'),
(3, 'Хорошие книги', 'Казахстан', '9234234234'),
(4, 'Книжное издательство', 'Россия', '9456235674'),
(5, 'Издательство', 'Россия', '896349634063'),
(6, 'Издательство РФ', 'Россия', '896559634063');

-- Индексы
ALTER TABLE `Authors` ADD PRIMARY KEY (`author_id`);
ALTER TABLE `Books` ADD PRIMARY KEY (`book_id`);
ALTER TABLE `Customers` ADD PRIMARY KEY (`customer_id`);
ALTER TABLE `Orders` ADD PRIMARY KEY (`order_id`);
ALTER TABLE `Publishers` ADD PRIMARY KEY (`publisher_id`);

-- AUTO_INCREMENT
ALTER TABLE `Authors` MODIFY `author_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `Books` MODIFY `book_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
ALTER TABLE `Customers` MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `Orders` MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
ALTER TABLE `Publishers` MODIFY `publisher_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

COMMIT;
