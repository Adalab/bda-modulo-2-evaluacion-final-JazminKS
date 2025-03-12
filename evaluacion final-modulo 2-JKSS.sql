
##### EJERCICIOS #####

-- Base de Datos Sakila: Para este ejercicio utilizaremos la bases de datos Sakila que hemos estado utilizando durante el repaso de SQL. 
-- Es una base de datos de ejemplo que simula una tienda de alquiler de películas. 
-- Contiene tablas como film(películas), actor(actores), customer(clientes), rental(alquileres), category(categorías), entre otras. 
-- Estas tablas contienen información sobre películas, actores, clientes, alquileres y más, y se utilizan para realizar consultas y análisis de datos en el contexto de una tienda de alquiler de películas.

-- 1.  Selecciona todos los nombres de las películas sin que aparezcan duplicados.

USE sakila;

#PASO 1
SELECT title
      FROM film;

#SOLUCIÓN FINAL
SELECT DISTINCT title
      FROM film;

-- 2.  Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

#PASO 1
SELECT title, rating
      FROM film;

#SOLUCIÓN FINAL
SELECT title, rating
      FROM film
      WHERE rating = "PG-13";

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

#PASO 1
SELECT title, `description`
      FROM film;

#SOLUCIÓN FINAL
SELECT title, `description`
      FROM film
      WHERE `description` REGEXP "amazing";

-- 4.  Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

#PASO 1
SELECT title, `length`
     FROM film;

#SOLUCIÓN FINAL
SELECT title, `length`
     FROM film
     WHERE `length` > 120;

-- 5.  Recupera los nombres de todos los actores.

SELECT first_name, last_name
      FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

#PASO 1
SELECT first_name, last_name
      FROM actor;

#SOLUCIÓN FINAL
SELECT first_name, last_name
     FROM actor
     WHERE last_name = "Gibson";

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

#PASO 1
SELECT actor_id, first_name, last_name
      FROM actor;

#SOLUCIÓN FINAL
SELECT actor_id, first_name, last_name
      FROM actor
      WHERE actor_id BETWEEN 10 AND 20;

-- 8.  Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

#PASO 1
SELECT title, rating
      FROM film;

#SOLUCIÓN FINAL
SELECT title, rating
     FROM film
     WHERE rating NOT LIKE "R" AND rating NOT LIKE "PG-13";

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

#PASO 1
SELECT film_id, rating
     FROM film;

#SOLUCIÓN FINAL
SELECT COUNT(film_id), rating
     FROM film
     GROUP BY rating;

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

#PASO 1
SELECT customer_id, first_name, last_name
     FROM customer;

#PASO 2 
SELECT rental_id
      FROM rental;

#SOLUCIÓN FINAL
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rental
      FROM customer AS c
      INNER JOIN rental AS r
      ON c.customer_id = r.customer_id  
      GROUP BY customer_id;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

##PASO 1
SELECT c.category_id, c.film_id, r.`name`
     FROM film_category AS c
     INNER JOIN category AS r
     ON c.category_id = r.category_id;

## PASO 2
SELECT a.rental_id, a.inventory_id, i.film_id
     FROM rental AS a
     INNER JOIN inventory AS i
     USING (inventory_id);

## SOLUCIÓN FINAL
SELECT c.`name`, COUNT(r. rental_id) AS total_rental
     FROM film_category AS f
     INNER JOIN category AS c
     USING (category_id)
     INNER JOIN inventory AS i
	 USING (film_id)
     INNER JOIN rental AS r
     USING (inventory_id)
     GROUP BY c.`name`;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

#PASO 1
SELECT rating, `length`
      FROM film;

#SOLUCIÓN FINAL
SELECT rating, AVG(`length`) AS average
     FROM film
     GROUP BY rating;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

#PASO 1
SELECT title
     FROM film;

SELECT film_id
     FROM film_actor;

SELECT film_id, first_name, last_name
     FROM actor;

#PASO 2
SELECT f.title, CONCAT( r.first_name, " ", r.last_name) AS full_name
      FROM film AS f
      INNER JOIN film_actor AS a
      USING (film_id)
      INNER JOIN actor AS r
      USING (actor_id);

#SOLUCION FINAL
SELECT f.title, CONCAT( r.first_name, " ", r.last_name) AS full_name
     FROM film AS f
     INNER JOIN film_actor AS a
     USING (film_id)
     INNER JOIN actor AS r
     USING (actor_id)
     WHERE f.title = "Indian Love";

-- 14.  Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

#PASO 1
SELECT title
     FROM film;

#SOLUCION FINAL
SELECT title
     FROM film
     WHERE title REGEXP "dog" OR title REGEXP "cat";

-- 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.

## PASO 1
SELECT actor_id, first_name, last_name
     FROM actor;             

SELECT actor_id, film_id
     FROM film_actor;

## SOLUCIÓN FINAL
SELECT first_name, last_name
     FROM actor
     WHERE actor_id NOT IN (SELECT actor_id
					        FROM film_actor);
                      
-- 16.  Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

#PASO 1
SELECT title, release_year
     FROM film;

#SOLUCIÓN FINAL
SELECT title, release_year
      FROM film
      WHERE release_year BETWEEN 2005 AND 2010;

-- 17.  Encuentra el título de todas las películas que son de la misma categoría que "Family".

#PASO 1
SELECT title
      FROM film;

SELECT film_id
      FROM film_category;

SELECT category_id
      FROM category;

#PASO 2
SELECT f.title, a.`name`
     FROM film AS f
     INNER JOIN film_category AS c
     USING (film_id)
     INNER JOIN category AS a
     USING (category_id);

#SOLUCIÓN FINAL
SELECT f.title, a.`name`
     FROM film AS f
     INNER JOIN film_category AS c
     USING (film_id)
     INNER JOIN category AS a
     USING (category_id)
     WHERE a.`name` = "Family";

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

## PASO 1
SELECT actor_id, film_id
     FROM film_actor;

SELECT actor_id, first_name, last_name
     FROM actor;

## PASO 2
SELECT actor_id, COUNT(film_id) 
     FROM film_actor
     GROUP BY actor_id
     HAVING COUNT(film_id) > 10;

## SOLUCIÓN FINAL
SELECT first_name, last_name
      FROM actor
      WHERE actor_id IN (SELECT actor_id
                         FROM film_actor
                         GROUP BY actor_id
                         HAVING COUNT(film_id) > 10);
                   
-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

#PASO 1
SELECT title, `length`, rating
      FROM film;

#SOLUCION FINAL
SELECT title, `length`, rating
      FROM film
      WHERE rating = "R" AND `length` > 120;
 
 -- 20.  Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
 
##PASO 1
SELECT film_id, title, `length`
     FROM film
     WHERE AVG (`length`) > 120;
 
 ##PASO 2
SELECT f.film_id, f.title, f.`length`, c.`name`
     FROM film AS f
     INNER JOIN film_category AS r
     USING(film_id)
     INNER JOIN category AS c
     USING(category_id);

## SOLUCIÓN FINAL
SELECT f.`length`, c.`name`
     FROM film AS f
     INNER JOIN film_category AS r
     USING(film_id)
     INNER JOIN category AS c
     USING(category_id)
     GROUP BY c.`name`
     HAVING AVG (f.`length`) > 120;

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

#PASO 1
SELECT actor_id, film_id
      FROM film_actor;

SELECT first_name, last_name
      FROM actor;

#SOLUCION FINAL
SELECT b.actor_id, a.first_name, a.last_name, COUNT(b.film_id) 
      FROM film_actor AS b
      INNER JOIN actor AS a
      USING(actor_id)
      GROUP BY b.actor_id
      HAVING COUNT(b.film_id) > 5;

-- 22.  Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
--      películas correspondientes

## PASO 1
SELECT DATEDIFF('2005-05-31 08:01:28', '2005-05-27 07:03:28');

## PASO 2
SELECT film_id, title
     FROM film;

SELECT film_id, inventory_id
     FROM inventory;

SELECT rental_id, inventory_id, rental_date, return_date
      FROM rental;

## PASO 3
SELECT rental_id
      FROM rental
      WHERE DATEDIFF(return_date, rental_date) >5 ;

## PASO 4
SELECT r.rental_id, r.inventory_id, film_id, f.title, r.rental_date, r.return_date
      FROM rental AS r
      LEFT JOIN inventory AS i
      USING(inventory_id)
      LEFT JOIN film AS f
      USING(film_id);

## SOLUCIÓN FINAL
SELECT r.rental_id, r.inventory_id, f.title, r.rental_date, r.return_date
      FROM rental AS r
      LEFT JOIN inventory AS i
      USING(inventory_id)
      LEFT JOIN film AS f
      USING(film_id)
      WHERE r.rental_id IN (SELECT rental_id
                           FROM rental
                           WHERE DATEDIFF(return_date, rental_date) >5);

-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
--     "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
--     categoría "Horror" y luego exclúyelos de la lista de actores.

## PASO 1
SELECT actor_id, first_name, last_name
     FROM actor;

SELECT actor_id, film_id
     FROM film_actor;

SELECT film_id, title
     FROM film;

SELECT film_id, category_id
     FROM  film_category;

SELECT category_id, `name`
     FROM category;

## PASO 2
SELECT a.actor_id, a.first_name, a.last_name, c.title
     FROM actor AS a
     INNER JOIN film_actor AS f
     USING(actor_id)
     INNER JOIN film AS c
     USING(film_id);

SELECT f.film_id, f.title, c.`name`
     FROM film AS f
     INNER JOIN film_category AS i
     USING (film_id)
     INNER JOIN category AS c
     USING (category_id)
     WHERE c.`name` = "Horror";

## PASO 3
SELECT a.actor_id, a.first_name, a.last_name, d.title
     FROM actor AS a
     INNER JOIN film_actor AS b
     USING(actor_id)
     INNER JOIN film AS d
     USING(film_id)
     WHERE d.film_id IN (SELECT f.film_id
                         FROM film AS f
                         INNER JOIN film_category AS i
                         USING (film_id)
                         INNER JOIN category AS c
					     USING (category_id)
                         WHERE c.`name` = "Horror");
                 
## SOLUCIÓN FINAL
SELECT actor_id, first_name, last_name
     FROM actor 
     WHERE actor_id NOT IN (SELECT a.actor_id
                            FROM actor AS a
                            INNER JOIN film_actor AS b
							USING(actor_id)
                            INNER JOIN film AS d
                            USING(film_id)
                            WHERE d.film_id IN (SELECT f.film_id
                                                FROM film AS f
                                                INNER JOIN film_category AS i
                                                USING (film_id)
										        INNER JOIN category AS c
					                            USING (category_id)
                                                WHERE c.`name` = "Horror"));
                 
                 
-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.

##PASO 1
SELECT film_id, title, `length`
      FROM film;

SELECT film_id, category_id
      FROM  film_category;

SELECT category_id, `name`
      FROM category;

##PASO 2
SELECT a.film_id, a.title, a.`length`, c.`name`
      FROM film AS a
      INNER JOIN film_category AS b
      USING(film_id)
      INNER JOIN category AS c
      USING(category_id);

##SOLUCIÓN FINAL
SELECT a.film_id, a.title, a.`length`, c.`name`
     FROM film AS a
     INNER JOIN film_category AS b
     USING(film_id)
     INNER JOIN category AS c
     USING(category_id)
     WHERE a.`length`>180 AND c.`name`='Comedy';

-- 25. Encuentra todos los actores que han actuado juntos en al menos una película. 
--     La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.

#PASO 1
SELECT film_id, actor_id
     FROM film_actor;

SELECT actor_id, first_name, last_name
     FROM actor;

#PASO 2
SELECT a.film_id, CONCAT(r.first_name, " ", r.last_name) AS full_name
     FROM actor AS r
     INNER JOIN film_actor AS a
     USING (actor_id);

#PASO 3
SELECT a.film_id, COUNT(r.actor_id)
     FROM actor AS r
     INNER JOIN film_actor AS a
	 USING (actor_id)
     GROUP BY a.film_id
     HAVING COUNT(r.actor_id)<2;

SELECT COUNT(a.film_id), r.actor_id, CONCAT(r.first_name, " ", r.last_name) AS full_name
     FROM actor AS r
     INNER JOIN film_actor AS a
     USING (actor_id)
     GROUP BY r.actor_id
     HAVING COUNT(a.film_id);

#SOLUCIÓN FINAL
SELECT COUNT(a.film_id), CONCAT(r.first_name, " ", r.last_name) AS full_name
     FROM actor AS r
     INNER JOIN film_actor AS a
     USING (actor_id)
     WHERE a.film_id NOT IN (SELECT y.film_id
                             FROM actor AS t
                             INNER JOIN film_actor AS y
                             USING (actor_id)
                             GROUP BY y.film_id
                             HAVING COUNT(t.actor_id)<2)
    GROUP BY r.actor_id
    HAVING COUNT(a.film_id);