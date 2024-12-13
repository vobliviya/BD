/*соиденение таблиц*/
/*'естественное' соединение таблиц customers и salepeople 
при помощи ссылки из поля  `customers`.`snum` на первичный ключ `salespeaple`.`snum` */
SELECT 
    cname as 'имя покупателя', sname as 'имя продовца'
FROM
    shop.customers,
    `shop`.`salespeaple`
WHERE
     `customers`.`snum` =`salespeaple`.`snum`;


/*'естественное' соединение трех таблиц*/
SELECT 
    `customers`.`cname`,
    `salespeaple`.`sname`,
    `sales`.`sdate`,
    `sales`.`amount`
FROM
    shop.sales,
    shop.customers,
    `shop`.`salespeaple`
WHERE 
`sales`.`snum` = `salespeaple`.`snum` and sales.cnum=customers.cnum;


/*'не естественное' соединение таблиц (без использования ключевых полей)*/
SELECT 
    `customers`.`cname`,
    customers.city,
    `salespeaple`.`sname`,
    salespeaple.city
FROM
    customers,
    salespeaple
WHERE
    customers.city = salespeaple.city;

/*составные условия при соединении*/
SELECT 
    `customers`.`cname`,
    customers.city,
    `salespeaple`.`sname`,
    salespeaple.city
FROM
    customers,
    salespeaple
WHERE
    customers.city = salespeaple.city and customers.city = 'новосибирск';

/*составные условия при соединении*/
SELECT 
    `customers`.`cname`,
    customers.city,
    `salespeaple`.`sname`,
    salespeaple.city
FROM
    customers,
    salespeaple
WHERE
    customers.city = salespeaple.city
        AND customers.city In ( 'новосибирск', 'омск');
        
       /*использование неравинств при соединениях */ 
SELECT 
    `customers`.`cname`,
    customers.city,
    `salespeaple`.`sname`,
    salespeaple.city
FROM
    customers,
    salespeaple
WHERE
    customers.city < salespeaple.city
        AND rating = 200;

/*использование псевдонима (alias) для таблиц*/
/*соединение одной таблицы с собой*/
SELECT 
    `first`.cname, `second`.cname, `first`.rating
FROM
    customers `first`,
    customers `second`
WHERE
    `first`.rating = `second`.rating and `first`.cname < `second`.cname;
    
/*псевдонимы для разных стаблиц*/
SELECT 
    b.cname as 'покупатель', a.sname as 'продавец', b.rating as 'рейтинг покупатля'
FROM
    salespeaple a,
    customers b
WHERE
	a.snum = b.snum;

/*самосоединене для таблицы с циклической зависимостью*/
select f.empno, f.empname, s.empname from employee f, employee s
where f.manager = s.empno;





/*примеры соединений*/
/*поиск тех продавцов, которые не назначены покупателям, но обслуживали их заказы */
SELECT 
    b.cname as "клиент", a.amount as "сумма заказа",  c.sname as '"чужой" продавец', d.sname as '"свой" продавец'
FROM
    sales a,
    customers b,
    salespeaple c,
    salespeaple d
WHERE
    a.cnum = b.cnum AND a.snum <> b.snum and a.snum = c.snum and d.snum = d.snum;


/*поиск образцов 
выводим три колонки, в каждой - покупатель с определенным значением рейтинга*/
SELECT 
    a.cnum, a.cname, b.cnum, c.cnum
FROM
    customers a,
    customers b,
    customers c
WHERE
    a.rating = 100 AND b.rating = 200
        AND c.rating = 300
 order by a.cnum, b.cnum, c.cnum;

/* соединение таблиц, не входящих в результаты запроса*/
SELECT 
    b.cnum, b.cname , b.city
FROM
    customers a,
    customers b
WHERE
    a.snum = 101 AND a.city = b.city;

/*пары покупателей обслуживаемые одним и тем же продавцом*/
SELECT 
    sname, salespeaple.snum, a.cname, b.cname
FROM
    customers a,
    customers b,
    salespeaple
WHERE
    a.snum = b.snum 
    and salespeaple.snum = a.snum
    AND a.cname < b.cname
ORDER BY snum;

/*оператор join в сочетании с using()*/
SELECT 
    city ' общий город', cname'покупатель', sname'продавец'
FROM
    customers
        JOIN
    salespeaple USING (city)
    order by 1;

/*запрос эквивалентный предыдущему*/
SELECT 
    `customers`.`cname`,
    customers.city,
    `salespeaple`.`sname`,
    salespeaple.city
FROM
    customers,
    salespeaple
WHERE
    customers.city = salespeaple.city;

/*левое и правое соединение */
SELECT 
    customers.cname, salespeaple.sname
FROM
    customers
        LEFT JOIN
    salespeaple USING (snum); 

SELECT 
    customers.cname, salespeaple.sname
FROM
    customers
        right JOIN
    salespeaple USING (snum); 

SELECT 
    customers.cname, salespeaple.sname
FROM
    customers
		JOIN
    salespeaple USING (snum); 
    
    
    /*пример соединения  при помощи оператора ON*/
       SELECT 
    a.empname as 'менеджер', b.empname as "подчиненный"
FROM
    shop.employee a
        JOIN
    employee b ON a.empno = b.manager;
    
/*при левом соединении справа выводятся null значения для тех значений слева
   которые не сопоставлены ни одному значению справа.
   при отсутствии подчиненного у сотрудника, справа выводится Null*/ 
   SELECT 
    a.empname as 'менеджер', b.empname as "подчиненный"
FROM
    shop.employee a
        left JOIN
    employee b ON a.empno = b.manager;
 
 /*при правом соединении с лева выводятся null значения для тех значений справава
 которые не сопоставлены ни одному значению слева.
 при отсутствии менеджера для сотрудника слева выводится null,
 в остальных случаях выводится имя менеджера для состудника*/
   SELECT 
    a.empname as 'менеджер', b.empname as "подчиненный"
FROM
    shop.employee a
        right JOIN
    employee b ON a.empno = b.manager;    
  
    /*натуральное соединение таблиц sales и salespeaple - 
    автоматическое соединение по одноименным столбцам*/
 SELECT 
    sdate, amount, sname, cname
FROM
    sales a
        NATURAL JOIN
    salespeaple b
        NATURAL JOIN
    customers с
WHERE
    b.city = 'новосибирск';
    
    
   SELECT 
    a.sdate, a.amount, sname, cname
FROM
    sales a
        JOIN
    salespeaple b ON (b.snum),
    sales d
        JOIN
    customers c ON (c.cnum)
WHERE
    a.sdate = d.sdate
        AND a.amount = d.amount
        AND a.cnum = d.cnum
        AND a.snum = d.snum
        AND d.snum = b.snum
        AND a.cnum = c.cnum;
    /* Использование join для объединения результатов выборки из трёх таблиц*/
    SELECT 
    *
FROM
    sales a
        NATURAL LEFT JOIN
    salespeaple b
        JOIN
    customers c USING (cnum);
    /* При правом объединении таблиц customers и sales natural right join salespeaple получаем список всех покупателей из таблицы customers и null-значения там, где покупателям не назачен продавец */
     SELECT 
    *
FROM
    sales a
        NATURAL RIGHT JOIN
    salespeaple b
        JOIN
    customers c USING (cnum);
    /*С таблицей, полученной в результате соединений, можно использовать условия в предложении where */
    SELECT 
    *
FROM
    sales a
        NATURAL RIGHT JOIN
    salespeaple b
        JOIN
    customers c USING (cnum)
		WHERE 
        c.city ='Шахты'
		
        
    
    
    
    
    
    
    
    
    
