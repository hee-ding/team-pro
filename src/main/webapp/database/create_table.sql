CREATE TABLE `board` (
	`seq` int NOT NULL,
	`category_seq` int NOT NULL,
	`title` varchar(50) NOT NULL,
	`content` text NULL,
	`write_seq` int NOT NULL,
	`write_date` datetime NOT NULL,
	`status` int(1) NOT NULL
);

CREATE TABLE `category` (
	`seq` int NOT NULL,
	`category` varchar(20) NOT NULL,
	`topic` varchar(20) NOT NULL
);

CREATE TABLE `reaction` (
	`seq` int NOT NULL,
	`view_count` int NOT NULL,
	`like_count` int NOT NULL,
	`board_seq` int NOT NULL
);

CREATE TABLE `tag` (
	`seq` int NOT NULL,
	`tag` varchar(100) NOT NULL,
	`board_seq` int NOT NULL
);

CREATE TABLE `image` (
	`seq` int NOT NULL,
	`name` varchar(50) NOT NULL,
	`size` int NOT NULL,
	`board_seq` int NOT NULL
);

CREATE TABLE `member_login_log` (
	`seq` int NOT NULL,
	`create_date` datetime NOT NULL,
	`member_seq` int NOT NULL
);

CREATE TABLE `review` (
	`seq` int NOT NULL,
	`content` text NOT NULL,
	`write_date` datetime NOT NULL,
	`writer_seq` int NOT NULL,
	`star_score` float(2,1) NOT NULL,
	`status` int(1) NOT NULL,
	`board_seq` int NOT NULL
);

CREATE TABLE `comment` (
	`seq` int NOT NULL,
	`content` text NOT NULL,
	`writer_seq` int NOT NULL,
	`write_date` datetime NOT NULL,
	`status` int(1) NOT NULL,
	`board_seq` int NOT NULL
);

CREATE TABLE `comment_modify` (
	`seq` int NOT NULL,
	`modify_date` datetime NOT NULL,
	`comment_seq` int NOT NULL
);

CREATE TABLE `comment_delete` (
	`seq` int NOT NULL,
	`delete_date` datetime NOT NULL,
	`comment_seq` int NOT NULL
);

CREATE TABLE `board_modify` (
	`seq` int NOT NULL,
	`modify_date` datetime NOT NULL,
	`board_seq` int NOT NULL
);

CREATE TABLE `board_delete` (
	`seq` int NOT NULL,
	`delete_date` datetime NOT NULL,
	`board_seq` int NOT NULL
);

CREATE TABLE `member` (
	`seq` int NOT NULL,
	`nickname` varchar(100) NULL,
	`id` varchar(100) NULL,
	`password` varchar(100) NULL,
	`name` varchar(20) NULL,
	`birthday` date NULL,
	`phone` varchar(20) NULL,
	`email` varchar(1000) NULL,
	`type` varchar(1) NULL,
	`zipcode` varchar(100) NULL,
	`address` varchar(100) NULL,
	`fulladdress` varchar(200) NULL,
	`referaddress` varchar(100) NULL
);


CREATE TABLE `membership` (
	`seq` int NOT NULL,
	`member_seq` int NOT NULL,
	`name` varchar(100) NOT NULL,
	`price` int NOT NULL,
	`period` int(2) NOT NULL,
	`board_seq` int NOT NULL
);

CREATE TABLE `cart` (
	`seq` int NOT NULL,
	`membership_seq` int NOT NULL,
	`member_seq` int NOT NULL
);

CREATE TABLE `pay` (
	`merchant_uid` varchar(100) NOT NULL,
	`membership_seq` int NOT NULL,
	`type` varchar(30) NOT NULL,
	`imp_uid` varchar(30) NOT NULL,
	`status` int(1) NOT NULL,
	`pay_date` datetime NOT NULL,
	`member_seq` int NOT NULL
);


CREATE TABLE `membership_register` (
	`seq` int NOT NULL,
	`register_date` datetime NULL,
	`expiry_date` datetime NULL,
	`status` int(1) NOT NULL,
	`merchant_uid` varchar(100) NOT NULL
);

CREATE TABLE `membership_hold` (
	`seq` int NOT NULL,
	`hold_date` datetime NOT NULL,
	`hold_end_date` datetime NULL,
	`hold_sum_date` int NULL,
	`register_seq` int NOT NULL
);

CREATE TABLE `news` (
	`seq` int NOT NULL,
	`req_member_seq` int NOT NULL,
	`req_date` datetime NOT NULL,
	`type` int NOT NULL,
	`read_check` char(1) NOT NULL,
	`view_check` char(1) NOT NULL,
	`board_seq` int NOT NULL
);

ALTER TABLE `board` ADD CONSTRAINT `PK_BOARD` PRIMARY KEY (
	`seq`
);

ALTER TABLE `category` ADD CONSTRAINT `PK_CATEGORY` PRIMARY KEY (
	`seq`
);

ALTER TABLE `reaction` ADD CONSTRAINT `PK_REACTION` PRIMARY KEY (
	`seq`
);

ALTER TABLE `tag` ADD CONSTRAINT `PK_TAG` PRIMARY KEY (
	`seq`
);

ALTER TABLE `image` ADD CONSTRAINT `PK_IMAGE` PRIMARY KEY (
	`seq`
);

ALTER TABLE `member_login_log` ADD CONSTRAINT `PK_MEMBER_LOGIN_LOG` PRIMARY KEY (
	`seq`
);

ALTER TABLE `review` ADD CONSTRAINT `PK_REVIEW` PRIMARY KEY (
	`seq`
);

ALTER TABLE `comment` ADD CONSTRAINT `PK_COMMENT` PRIMARY KEY (
	`seq`
);

ALTER TABLE `comment_modify` ADD CONSTRAINT `PK_COMMENT_MODIFY` PRIMARY KEY (
	`seq`
);

ALTER TABLE `comment_delete` ADD CONSTRAINT `PK_COMMENT_DELETE` PRIMARY KEY (
	`seq`
);

ALTER TABLE `board_modify` ADD CONSTRAINT `PK_BOARD_MODIFY` PRIMARY KEY (
	`seq`
);

ALTER TABLE `board_delete` ADD CONSTRAINT `PK_BOARD_DELETE` PRIMARY KEY (
	`seq`
);

ALTER TABLE `member` ADD CONSTRAINT `PK_MEMBER` PRIMARY KEY (
	`seq`
);

ALTER TABLE `membership` ADD CONSTRAINT `PK_MEMBERSHIP` PRIMARY KEY (
	`seq`
);

ALTER TABLE `cart` ADD CONSTRAINT `PK_CART` PRIMARY KEY (
	`seq`
);

ALTER TABLE `pay` ADD CONSTRAINT `PK_PAY` PRIMARY KEY (
	`merchant_uid`
);


ALTER TABLE `membership_register` ADD CONSTRAINT `PK_MEMBERSHIP_REGISTER` PRIMARY KEY (
	`seq`
);

ALTER TABLE `membership_hold` ADD CONSTRAINT `PK_MEMBERSHIP_HOLD` PRIMARY KEY (
	`seq`
);

ALTER TABLE `news` ADD CONSTRAINT `PK_NEWS` PRIMARY KEY (
	`seq`
);


ALTER TABLE board MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE category MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE reaction MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE tag MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE image MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE member_login_log MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE review MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE comment MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE comment_modify MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE comment_delete MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE board_modify MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE board_delete MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE member MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE membership MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE cart MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE membership_register MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE membership_hold MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE news MODIFY seq INT(11) NOT NULL AUTO_INCREMENT;



ALTER TABLE `board` ADD CONSTRAINT `FK_category_TO_board_1` FOREIGN KEY (
	`category_seq`
)
REFERENCES `category` (
	`seq`
);

ALTER TABLE `board` ADD CONSTRAINT `FK_member_TO_board_1` FOREIGN KEY (
	`write_seq`
)
REFERENCES `member` (
	`seq`
);

ALTER TABLE `reaction` ADD CONSTRAINT `FK_board_TO_reaction_1` FOREIGN KEY (
	`board_seq`
)
REFERENCES `board` (
	`seq`
);

ALTER TABLE `tag` ADD CONSTRAINT `FK_board_TO_tag_1` FOREIGN KEY (
	`board_seq`
)
REFERENCES `board` (
	`seq`
);

ALTER TABLE `image` ADD CONSTRAINT `FK_board_TO_image_1` FOREIGN KEY (
	`board_seq`
)
REFERENCES `board` (
	`seq`
);

ALTER TABLE `member_login_log` ADD CONSTRAINT `FK_member_TO_member_login_log_1` FOREIGN KEY (
	`member_seq`
)
REFERENCES `member` (
	`seq`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_member_TO_review_1` FOREIGN KEY (
	`writer_seq`
)
REFERENCES `member` (
	`seq`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_board_TO_review_1` FOREIGN KEY (
	`board_seq`
)
REFERENCES `board` (
	`seq`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_member_TO_comment_1` FOREIGN KEY (
	`writer_seq`
)
REFERENCES `member` (
	`seq`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_board_TO_comment_1` FOREIGN KEY (
	`board_seq`
)
REFERENCES `board` (
	`seq`
);

ALTER TABLE `comment_modify` ADD CONSTRAINT `FK_comment_TO_comment_modify_1` FOREIGN KEY (
	`comment_seq`
)
REFERENCES `comment` (
	`seq`
);

ALTER TABLE `comment_delete` ADD CONSTRAINT `FK_comment_TO_comment_delete_1` FOREIGN KEY (
	`comment_seq`
)
REFERENCES `comment` (
	`seq`
);

ALTER TABLE `board_modify` ADD CONSTRAINT `FK_board_TO_board_modify_1` FOREIGN KEY (
	`board_seq`
)
REFERENCES `board` (
	`seq`
);

ALTER TABLE `board_delete` ADD CONSTRAINT `FK_board_TO_board_delete_1` FOREIGN KEY (
	`board_seq`
)
REFERENCES `board` (
	`seq`
);

ALTER TABLE `membership` ADD CONSTRAINT `FK_member_TO_membership_1` FOREIGN KEY (
	`member_seq`
)
REFERENCES `member` (
	`seq`
);

ALTER TABLE `membership` ADD CONSTRAINT `FK_board_TO_membership_1` FOREIGN KEY (
	`board_seq`
)
REFERENCES `board` (
	`seq`
);

ALTER TABLE `cart` ADD CONSTRAINT `FK_membership_TO_cart_1` FOREIGN KEY (
	`membership_seq`
)
REFERENCES `membership` (
	`seq`
);

ALTER TABLE `cart` ADD CONSTRAINT `FK_member_TO_cart_1` FOREIGN KEY (
	`member_seq`
)
REFERENCES `member` (
	`seq`
);

ALTER TABLE `pay` ADD CONSTRAINT `FK_membership_TO_pay_1` FOREIGN KEY (
	`membership_seq`
)
REFERENCES `membership` (
	`seq`
);

ALTER TABLE `pay` ADD CONSTRAINT `FK_member_TO_pay_1` FOREIGN KEY (
	`member_seq`
)
REFERENCES `member` (
	`seq`
);

ALTER TABLE `membership_register` ADD CONSTRAINT `FK_pay_TO_membership_register_1` FOREIGN KEY (
	`merchant_uid`
)
REFERENCES `pay` (
	`merchant_uid`
);

ALTER TABLE `membership_hold` ADD CONSTRAINT `FK_membership_register_TO_membership_hold_1` FOREIGN KEY (
	`register_seq`
)
REFERENCES `membership_register` (
	`seq`
);

ALTER TABLE `news` ADD CONSTRAINT `FK_member_TO_news_1` FOREIGN KEY (
	`req_member_seq`
)
REFERENCES `member` (
	`seq`
);

ALTER TABLE `news` ADD CONSTRAINT `FK_board_TO_news_1` FOREIGN KEY (
	`board_seq`
)
REFERENCES `board` (
	`seq`
);


CREATE TABLE `admin` (
	`seq` int NOT NULL primary key,
	`id` varchar(100) NULL,
	`nickname` varchar(100) NULL,
	`password` varchar(100) NULL
);


create table `likeaction` (
	`seq` int NOT NULL primary key,
	`like_check` int NOT NULL,
	`useseq` int NOT NULL,
	`board_seq` int NOT NULL,
	constraint foreign key (useseq) references member (seq),
	constraint foreign key (board_seq) references board (seq)
);

create table `notification` (
	`seq` int auto_increment NOT NULL primary key,
	`category_seq` int NOT NULL,
	`subject` varchar(50) NOT NULL,
	`writer_admin` int NOT NULL,
	`date`  datetime  NOT NULL,
	`hit`  int NOT NULL,
	`content`  text NOT NULL,
	constraint foreign key (category_seq) references category (seq),
	constraint foreign key (writer_admin) references admin (seq)
);
