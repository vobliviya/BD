CREATE DATABASE  IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shop`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.26

/*Операторы IN, BETWEEN, LIKE, IS NULL и агрегатные функции*/
/*IN - выборка из множества значений*/

SELECT
	`customers`.`cname`,
    `customers`.`city`,
	`customers`.`rating`,
    `customers`.`snum`
FROM
	`shop`.`customers`
    WHERE `customers`.`city` IN ('Новосибирск', 'Омск');
    
SELECT
	`sales`.`sdate`, `sales`.`amount`
FROM 
	`shop`.`sales`
WHERE
	`sales`.`sdate` IN ('2024-09-12', '2024-09-13','2024-09-17');
    
/*BETWEEN - выборка из диапозона значений*/
SELECT
	`sales`.`sdate`,`sales`.`amount`
FROM 
	`shop`.`sales`
WHERE
	`sales`.`sdate` BETWEEN '2024-09-12' AND '2024-09-17';
    
SELECT
	`salespeople`.`sname`,
	`salespeople`.`city`,
	`salespeople`.`comm`
FROM
	`shop`.`salespeople`
WHERE
	`salespeople`.`comm` BETWEEN 0.09 AND 0.11
	AND NOT `salespeople`.`comm` IN (0.09 , 0.11);
    
/*Исключение границ*/

SELECT
	`customers`.`cname`,
    `customers`.`city`,
	`customers`.`rating`,
    `customers`.`snum`
FROM
	`shop`.`customers`
WHERE 
    `customers`.`city` BETWEEN 'Н' AND 'Омскк'
    ORDER BY `customers`.`city`;