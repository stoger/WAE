-- Drop existing tables if they exist
DROP TABLE IF EXISTS `group18_posts`;
DROP TABLE IF EXISTS `group18_categories`;
DROP TABLE IF EXISTS `group18_user`;

-- Create `User` table
CREATE TABLE IF NOT EXISTS `group18_user` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Insert a static row into `User`
-- username 'test', password 'test'
INSERT INTO `group18_user` (`username`, `password`)
VALUES ('test', '%%V-/_+0V$L}:7W42,,$df&1XcyoW$60ddcb118056b7b5f3b6e6daee4ead0f1814406cdb66a6b36a08b05debce343ddcbf17059aa070b9e60e9f361ab501ee1bf6c007263d69a9d68e65484368c0a6');

-- Create `Category` table
CREATE TABLE IF NOT EXISTS `group18_categories` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Insert categories into `Category`
INSERT INTO `group18_categories` (`name`)
VALUES 
    ('News'), 
    ('Bücherbörse'), 
    ('Erstsemester Tipps'), 
    ('Schwarzes Brett'), 
    ('Sporttreffen');

-- Create `Post` table
CREATE TABLE IF NOT EXISTS `group18_posts` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `last_edited` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `user_id` INT NOT NULL,
    `category_id` INT NOT NULL,
    `likes` INT DEFAULT 0, -- New `likes` column
    FOREIGN KEY (`user_id`) REFERENCES `group18_user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`category_id`) REFERENCES `group18_categories`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Insert a static row into `Post`
INSERT INTO `group18_posts` (`title`, `content`, `user_id`, `category_id`, `likes`)
VALUES ('My First Post', 'Hello world! This is a test post.', 1, 1, 0);
