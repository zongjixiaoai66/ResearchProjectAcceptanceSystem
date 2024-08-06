/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb3 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `t246`;
CREATE DATABASE IF NOT EXISTS `t246` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `t246`;

DROP TABLE IF EXISTS `config`;
CREATE TABLE IF NOT EXISTS `config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='配置文件';

DELETE FROM `config`;

DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE IF NOT EXISTS `dictionary` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dic_code` varchar(200) DEFAULT NULL COMMENT '字段',
  `dic_name` varchar(200) DEFAULT NULL COMMENT '字段名',
  `code_index` int DEFAULT NULL COMMENT '编码',
  `index_name` varchar(200) DEFAULT NULL COMMENT '编码名字  Search111 ',
  `super_id` int DEFAULT NULL COMMENT '父字段id',
  `beizhu` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 COMMENT='字典';

DELETE FROM `dictionary`;
INSERT INTO `dictionary` (`id`, `dic_code`, `dic_name`, `code_index`, `index_name`, `super_id`, `beizhu`, `create_time`) VALUES
	(1, 'sex_types', '性别类型名称', 1, '男', NULL, NULL, '2021-11-15 08:21:55'),
	(2, 'sex_types', '性别类型名称', 2, '女', NULL, NULL, '2021-11-15 08:21:55'),
	(3, 'shangxia_types', '是否使用', 1, '使用', NULL, NULL, '2021-11-15 08:21:55'),
	(4, 'shangxia_types', '是否使用', 2, '禁用', NULL, NULL, '2021-11-15 08:21:55'),
	(5, 'xiangmu_types', '项目类型名称', 1, '项目类型1', NULL, NULL, '2021-11-15 08:21:55'),
	(6, 'xiangmu_types', '项目类型名称', 2, '项目类型2', NULL, NULL, '2021-11-15 08:21:55'),
	(7, 'xiangmu_types', '项目类型名称', 3, '项目类型3', NULL, NULL, '2021-11-15 08:21:55'),
	(8, 'xiangmu_types', '项目类型名称', 4, '项目类型4', NULL, NULL, '2021-11-15 08:21:55'),
	(9, 'xiangmu_yesno_types', '项目管理员审核类型名称', 1, '待审核', NULL, NULL, '2021-11-15 08:21:55'),
	(10, 'xiangmu_yesno_types', '项目管理员审核类型名称', 2, '通过', NULL, NULL, '2021-11-15 08:21:56'),
	(11, 'xiangmu_yesno_types', '项目管理员审核类型名称', 3, '不通过', NULL, NULL, '2021-11-15 08:21:56'),
	(12, 'zhuanjia1_types', '专家1审核类型名称', 1, '待审核', NULL, NULL, '2021-11-15 08:21:56'),
	(13, 'zhuanjia1_types', '专家1审核类型名称', 2, '通过', NULL, NULL, '2021-11-15 08:21:56'),
	(14, 'zhuanjia1_types', '专家1审核类型名称', 3, '不通过', NULL, NULL, '2021-11-15 08:21:56'),
	(15, 'zhuanjia2_types', '专家2审核类型名称', 1, '待审核', NULL, NULL, '2021-11-15 08:21:56'),
	(16, 'zhuanjia2_types', '专家2审核类型名称', 2, '通过', NULL, NULL, '2021-11-15 08:21:56'),
	(17, 'zhuanjia2_types', '专家2审核类型名称', 3, '不通过', NULL, NULL, '2021-11-15 08:21:56'),
	(18, 'zhuanjia3_types', '专家3审核类型名称', 1, '待审核', NULL, NULL, '2021-11-15 08:21:56'),
	(19, 'zhuanjia3_types', '专家3审核类型名称', 2, '通过', NULL, NULL, '2021-11-15 08:21:56'),
	(20, 'zhuanjia3_types', '专家3审核类型名称', 3, '不通过', NULL, NULL, '2021-11-15 08:21:56'),
	(21, 'gonggao_types', '公告类型名称', 1, '公告类型1', NULL, NULL, '2021-11-15 08:21:56'),
	(22, 'gonggao_types', '公告类型名称', 2, '公告类型2', NULL, NULL, '2021-11-15 08:21:56'),
	(23, 'zuizhong_types', '最终审核结果类型名称', 1, '正在审核', NULL, NULL, '2021-11-16 03:15:59'),
	(24, 'zuizhong_types', '最终审核结果类型名称', 2, '通过', NULL, NULL, '2021-11-16 03:15:59'),
	(25, 'zuizhong_types', '最终审核结果类型名称', 3, '不通过', NULL, NULL, '2021-11-16 03:15:59'),
	(27, 'xiangmu_types', '项目类型名称', 5, '项目类型5', NULL, NULL, '2021-11-16 09:36:50');

DROP TABLE IF EXISTS `gonggao`;
CREATE TABLE IF NOT EXISTS `gonggao` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `gonggao_name` varchar(200) DEFAULT NULL COMMENT '公告名称 Search111  ',
  `gonggao_photo` varchar(200) DEFAULT NULL COMMENT '公告图片 ',
  `gonggao_types` int NOT NULL COMMENT '公告类型 Search111  ',
  `insert_time` timestamp NULL DEFAULT NULL COMMENT '公告发布时间 ',
  `gonggao_content` text COMMENT '公告详情 ',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间 show1 show2 nameShow',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='公告信息';

DELETE FROM `gonggao`;
INSERT INTO `gonggao` (`id`, `gonggao_name`, `gonggao_photo`, `gonggao_types`, `insert_time`, `gonggao_content`, `create_time`) VALUES
	(1, '公告名称1', 'http://localhost:8080/xiangmuyanshou/upload/1637042761518.jfif', 1, '2021-11-15 08:21:56', '<p>公告详情1111</p>', '2021-11-15 08:21:56');

DROP TABLE IF EXISTS `shenherizhi`;
CREATE TABLE IF NOT EXISTS `shenherizhi` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `shenherizhi_table` varchar(200) DEFAULT NULL COMMENT '审核人所属表',
  `shenherizhi_name` varchar(200) DEFAULT NULL COMMENT '审核人名字 Search111 ',
  `shenherizhi_phone` varchar(200) DEFAULT NULL COMMENT '审核人手机号 Search111 ',
  `shenherizhi_id_number` varchar(200) DEFAULT NULL COMMENT '审核人身份证号 Search111 ',
  `shenherizhi_jieguo` varchar(200) DEFAULT NULL COMMENT '审核结果 Search111 ',
  `insert_time` timestamp NULL DEFAULT NULL COMMENT '审核时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COMMENT='审核日志';

DELETE FROM `shenherizhi`;
INSERT INTO `shenherizhi` (`id`, `shenherizhi_table`, `shenherizhi_name`, `shenherizhi_phone`, `shenherizhi_id_number`, `shenherizhi_jieguo`, `insert_time`, `create_time`) VALUES
	(4, '项目管理员表', '张22', '17703786911', '410224199610232011', '审核通过', '2021-11-16 09:08:34', '2021-11-16 09:08:34'),
	(5, '项目管理员表', '张22', '17703786911', '410224199610232011', '审核通过', '2021-11-16 09:15:36', '2021-11-16 09:15:36'),
	(6, '项目管理员表', '张222', '17703786222', '410224199610232222', '审核通过', '2021-11-16 09:16:44', '2021-11-16 09:16:44'),
	(7, '项目管理员表', '张222', '17703786222', '410224199610232222', '审核通过', '2021-11-16 09:20:32', '2021-11-16 09:20:31'),
	(8, '项目管理员表', '张222', '17703786222', '410224199610232222', '审核通过', '2021-11-16 09:23:14', '2021-11-16 09:23:14'),
	(9, '项目管理员表', '张222', '17703786222', '410224199610232222', '审核通过', '2021-11-16 09:24:37', '2021-11-16 09:24:37'),
	(10, '项目管理员表', '张222', '17703786222', '410224199610232222', '审核通过', '2021-11-16 09:24:42', '2021-11-16 09:24:42'),
	(11, '项目管理员表', '张222', '17703786222', '410224199610232222', '审核通过', '2021-11-16 09:26:37', '2021-11-16 09:26:37'),
	(12, '项目管理员表', '张111', '17703786111', '410224199610232111', '审核通过', '2021-11-16 09:29:17', '2021-11-16 09:29:17'),
	(13, '项目管理员表', '张333', '17703786333', '410224199610232333', '审核通过', '2021-11-16 09:29:53', '2021-11-16 09:29:53'),
	(14, '项目管理员表', '张333', '17703786333', '410224199610232333', '审核不通过', '2021-11-16 09:30:26', '2021-11-16 09:30:26');

DROP TABLE IF EXISTS `token`;
CREATE TABLE IF NOT EXISTS `token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='token表';

DELETE FROM `token`;
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES
	(1, 6, 'admin', 'users', '管理员', 'yiba9btw7qg4199m5gkumrzj18z7g9t5', '2021-11-15 08:58:21', '2024-07-05 03:42:18'),
	(2, 1, 'a1', 'yonghu', '用户', 'a8w9vptz6p17oeu34yn90apbshnr8kr9', '2021-11-16 06:13:39', '2024-07-05 03:43:36'),
	(3, 2, 'a222', 'zhuanjia', '专家账户', 'wli95jba5w2hyl71cpdjz5h2t42vjcnz', '2021-11-16 08:43:17', '2021-11-16 10:16:24'),
	(4, 1, 'a11', 'xiangmuguanliyuan', '项目管理员', 's3vlojoap0lcfb8bibjqkwg79zwrc8tp', '2021-11-16 08:45:18', '2024-07-05 03:43:11'),
	(5, 1, 'a111', 'zhuanjia', '专家账户', '4gslgr1t6piywb8x6vm891jh25vs866l', '2021-11-16 09:29:04', '2024-07-05 03:43:23'),
	(6, 3, 'a333', 'zhuanjia', '专家账户', '7fd3lx1ieb8vdaj6hppbqswd1f4tet1z', '2021-11-16 09:29:40', '2021-11-16 10:29:41');

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `role` varchar(100) DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='管理员表';

DELETE FROM `users`;
INSERT INTO `users` (`id`, `username`, `password`, `role`, `addtime`) VALUES
	(6, 'admin', '123456', '管理员', '2021-04-27 06:51:13');

DROP TABLE IF EXISTS `xiangmu`;
CREATE TABLE IF NOT EXISTS `xiangmu` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `xiangmu_uuid_number` varchar(200) DEFAULT NULL COMMENT '项目唯一标识 Search111 ',
  `yonghu_id` int DEFAULT NULL COMMENT '用户',
  `xiangmu_name` varchar(200) DEFAULT NULL COMMENT '项目名称  Search111 ',
  `xiangmu_photo` varchar(200) DEFAULT NULL COMMENT '项目照片',
  `xiangmu_types` int DEFAULT NULL COMMENT '项目类型',
  `xiangmu_file` varchar(200) DEFAULT NULL COMMENT '验收申请书',
  `xiangmu_content` text COMMENT '项目简介',
  `xiangmuguanliyuan_id` int DEFAULT NULL COMMENT '项目管理员',
  `xiangmu_yesno_types` int DEFAULT NULL COMMENT '项目管理员审核结果 Search111 ',
  `xiangmuguanliyuan_content` text COMMENT '项目管理员审核意见',
  `zhuanjia1_uuid_number` varchar(200) DEFAULT NULL COMMENT '专家1的唯一标识 Search111 ',
  `zhuanjia1_name` varchar(200) DEFAULT NULL COMMENT '专家1姓名',
  `zhuanjia1_types` int DEFAULT NULL COMMENT '专家1的审核结果 Search111 ',
  `zhuanjia1_yijian_content` text COMMENT '专家1的审核意见',
  `zhuanjia2_uuid_number` varchar(200) DEFAULT NULL COMMENT '专家2的唯一标识 Search111 ',
  `zhuanjia2_name` varchar(200) DEFAULT NULL COMMENT '专家2姓名',
  `zhuanjia2_types` int DEFAULT NULL COMMENT '专家2的审核结果 Search111 ',
  `zhuanjia2_yijian_content` text COMMENT '专家2的审核意见',
  `zhuanjia3_uuid_number` varchar(200) DEFAULT NULL COMMENT '专家3的唯一标识 Search111 ',
  `zhuanjia3_name` varchar(200) DEFAULT NULL COMMENT '专家3姓名',
  `zhuanjia3_types` int DEFAULT NULL COMMENT '专家3的审核结果 Search111 ',
  `zhuanjia3_yijian_content` text COMMENT '专家3的审核意见',
  `zuizhong_types` int DEFAULT NULL COMMENT '最终审核结果 Search111 ',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='项目';

DELETE FROM `xiangmu`;
INSERT INTO `xiangmu` (`id`, `xiangmu_uuid_number`, `yonghu_id`, `xiangmu_name`, `xiangmu_photo`, `xiangmu_types`, `xiangmu_file`, `xiangmu_content`, `xiangmuguanliyuan_id`, `xiangmu_yesno_types`, `xiangmuguanliyuan_content`, `zhuanjia1_uuid_number`, `zhuanjia1_name`, `zhuanjia1_types`, `zhuanjia1_yijian_content`, `zhuanjia2_uuid_number`, `zhuanjia2_name`, `zhuanjia2_types`, `zhuanjia2_yijian_content`, `zhuanjia3_uuid_number`, `zhuanjia3_name`, `zhuanjia3_types`, `zhuanjia3_yijian_content`, `zuizhong_types`, `create_time`) VALUES
	(4, '1637044140014', 1, '项目1', 'http://localhost:8080/xiangmuyanshou/upload/1637044164835.webp', 1, 'http://localhost:8080/xiangmuyanshou/upload/1637045583686.xls', '<p>项目1的介绍</p>', NULL, 1, '', '', '', 1, '', '', '', 1, '', '', '', 1, '', 1, '2021-11-16 06:29:36'),
	(5, '1637051860708', 1, '项目2', 'http://localhost:8080/xiangmuyanshou/upload/1637051923735.jfif', 3, 'http://localhost:8080/xiangmuyanshou/upload/1637051970416.sql', '<p>项目2的简介</p>', 1, 1, '', '', '', 1, '', '', '', 1, '', '', '', 1, '', 1, '2021-11-16 08:39:40');

DROP TABLE IF EXISTS `xiangmuguanliyuan`;
CREATE TABLE IF NOT EXISTS `xiangmuguanliyuan` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(200) DEFAULT NULL COMMENT '账户',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `xiangmuguanliyuan_name` varchar(200) DEFAULT NULL COMMENT '项目管理员姓名 Search111 ',
  `xiangmuguanliyuan_phone` varchar(200) DEFAULT NULL COMMENT '联系电话 Search111 ',
  `xiangmuguanliyuan_id_number` varchar(200) DEFAULT NULL COMMENT '项目管理员身份证号 Search111 ',
  `xiangmuguanliyuan_photo` varchar(200) DEFAULT NULL COMMENT '头像',
  `sex_types` int DEFAULT NULL COMMENT '性别',
  `xiangmuguanliyuan_email` varchar(200) DEFAULT NULL COMMENT '电子邮箱',
  `xiangmuguanliyuan_address` varchar(200) DEFAULT NULL COMMENT '住址',
  `xiangmuguanliyuan_delete` int DEFAULT NULL COMMENT '逻辑删除',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='项目管理员';

DELETE FROM `xiangmuguanliyuan`;
INSERT INTO `xiangmuguanliyuan` (`id`, `username`, `password`, `xiangmuguanliyuan_name`, `xiangmuguanliyuan_phone`, `xiangmuguanliyuan_id_number`, `xiangmuguanliyuan_photo`, `sex_types`, `xiangmuguanliyuan_email`, `xiangmuguanliyuan_address`, `xiangmuguanliyuan_delete`, `create_time`) VALUES
	(1, '项目管理员1', '123456', '项目管理员1', '17703786911', '410224199610232011', 'http://localhost:8080/xiangmuyanshou/upload/1637028942633.jpg', 2, '22@qq.com', '地址11', 1, '2021-11-16 02:15:56'),
	(2, '项目管理员2', '123456', '项目管理员2', '17703786922', '410224199610232022', 'http://localhost:8080/xiangmuyanshou/upload/1637029038672.jpg', 1, '22@qq.com', '地址22', 1, '2021-11-16 02:17:31');

DROP TABLE IF EXISTS `yonghu`;
CREATE TABLE IF NOT EXISTS `yonghu` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(200) DEFAULT NULL COMMENT '账户',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `yonghu_name` varchar(200) DEFAULT NULL COMMENT '用户姓名 Search111 ',
  `yonghu_phone` varchar(200) DEFAULT NULL COMMENT '联系电话 Search111 ',
  `yonghu_id_number` varchar(200) DEFAULT NULL COMMENT '用户身份证号 Search111 ',
  `yonghu_photo` varchar(200) DEFAULT NULL COMMENT '头像 ',
  `sex_types` int DEFAULT NULL COMMENT '性别',
  `yonghu_email` varchar(200) DEFAULT NULL COMMENT '电子邮箱',
  `yonghu_address` varchar(200) DEFAULT NULL COMMENT '住址',
  `yonghu_delete` int DEFAULT NULL COMMENT '逻辑删除',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='用户';

DELETE FROM `yonghu`;
INSERT INTO `yonghu` (`id`, `username`, `password`, `yonghu_name`, `yonghu_phone`, `yonghu_id_number`, `yonghu_photo`, `sex_types`, `yonghu_email`, `yonghu_address`, `yonghu_delete`, `create_time`) VALUES
	(1, '用户1', '123456', '用户1', '17703786901', '410224199610232001', 'http://localhost:8080/xiangmuyanshou/upload/1637028584431.jpg', 2, '22@qq.com', '地址1', 1, '2021-11-16 01:41:20'),
	(2, '用户2', '123456', '用户2', '17703786902', '410224199610232002', 'http://localhost:8080/xiangmuyanshou/upload/1637028635385.jpg', 1, '22@qq.com', '地址2', 1, '2021-11-16 02:10:54');

DROP TABLE IF EXISTS `zhuanjia`;
CREATE TABLE IF NOT EXISTS `zhuanjia` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(200) DEFAULT NULL COMMENT '账户',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `zhuanjia_uuid_number` varchar(200) DEFAULT NULL COMMENT '专家唯一标识 Search111 ',
  `zhuanjia_name` varchar(200) DEFAULT NULL COMMENT '专家姓名 Search111 ',
  `zhuanjia_phone` varchar(200) DEFAULT NULL COMMENT '专家联系电话 Search111 ',
  `zhuanjia_id_number` varchar(200) DEFAULT NULL COMMENT '专家身份证号 Search111 ',
  `zhuanjia_photo` varchar(200) DEFAULT NULL COMMENT '头像',
  `shangxia_types` int DEFAULT NULL COMMENT '是否使用 Search111 ',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='专家账户';

DELETE FROM `zhuanjia`;
INSERT INTO `zhuanjia` (`id`, `username`, `password`, `zhuanjia_uuid_number`, `zhuanjia_name`, `zhuanjia_phone`, `zhuanjia_id_number`, `zhuanjia_photo`, `shangxia_types`, `create_time`) VALUES
	(1, '专家账户1', '123456', '1637029216630', '专家账户1', '17703786111', '410224199610232111', 'http://localhost:8080/xiangmuyanshou/upload/1637029348651.jpg', 1, '2021-11-16 02:22:40'),
	(2, '专家账户2', '123456', '1637029416911', '专家账户2', '17703786222', '410224199610232222', 'http://localhost:8080/xiangmuyanshou/upload/1637029448870.jpg', 1, '2021-11-16 02:24:12'),
	(3, '专家账户3', '123456', '1637029874646', '专家账户3', '17703786333', '410224199610232333', 'http://localhost:8080/xiangmuyanshou/upload/1637029906826.jpg', 1, '2021-11-16 02:31:49'),
	(4, '专家账户4', '123456', '1637054829569', '专家账户4', '17703786444', '410224199610232444', 'http://localhost:8080/xiangmuyanshou/upload/1637054864839.webp', 1, '2021-11-16 09:27:47');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
