CREATE TABLE `user` (
                        `id` int NOT NULL AUTO_INCREMENT,
                        `email` varchar(100) NOT NULL,
                        `password` varchar(255) NOT NULL,
                        `nickname` varchar(50) NOT NULL,
                        `age` int DEFAULT NULL,
                        `gender` varchar(10) DEFAULT NULL,
                        `address` varchar(255) DEFAULT NULL,
                        `bio` varchar(255) DEFAULT NULL,
                        `intro` text,
                        `role` varchar(20) DEFAULT 'user',
                        `avatar` varchar(255) DEFAULT NULL,
                        `answer` varchar(255) DEFAULT NULL COMMENT '密保答案，用于找回密码',
                        `status` varchar(20) DEFAULT 'active' COMMENT '用户状态，如 active, suspended, deleted 等',
                        PRIMARY KEY (`id`),
                        UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `tag` (
                       `id` int NOT NULL AUTO_INCREMENT,
                       `name` varchar(50) NOT NULL,
                       PRIMARY KEY (`id`),
                       UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `photo` (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `album_id` int NOT NULL,
                         `url` varchar(255) NOT NULL,
                         `description` text,
                         `upload_time` datetime DEFAULT CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `album_tag` (
                             `album_id` int NOT NULL COMMENT '相册ID',
                             `tag_id` int NOT NULL COMMENT '标签ID',
                             PRIMARY KEY (`album_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




CREATE TABLE `album_like` (
                              `id` int NOT NULL AUTO_INCREMENT,
                              `user_id` int NOT NULL,
                              `album_id` int NOT NULL,
                              `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `unique_like` (`user_id`,`album_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `album` (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `user_id` int NOT NULL,
                         `title` varchar(100) NOT NULL,
                         `description` text,
                         `cover_url` varchar(255) DEFAULT NULL,
                         `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
                         `status` varchar(20) DEFAULT 'public',
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

