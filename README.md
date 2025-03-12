### Evaluación Final Módulo 2: SQL

> Esta evaluación consta de una serie de preguntas que miden tu comprensión y habilidades en relación con SQL imprescindible para trabajar con bases de datos.
>
##  Criterios de evaluación

- Uso queries básicas: `SELECT`, `UPDATE`, `DELETE`, `INSERT*`
- Uso de las funciones: `GROUP BY`, `WHERE`, `HAVING`
- Uso de `JOINS` (incluyendo `UNION` y `UNION ALL`)
- Uso de subconsultas. 
- Uso de las subconsultas correlacionadas.

## Contenido

Para este ejercicio utilizaremos la bases de datos `Sakila`. Es una base de datos de ejemplo que simula una tienda de alquiler de películas. Contiene tablas como film (películas), actor (actores), customer(clientes), rental (alquileres), category (categorías), entre otras. 

![Diagrama](https://github.com/Adalab/bda-modulo-2-evaluacion-final-JazminKS/blob/main/FILES/Diagrama1.png){withd=80%}

## Desarrollo de ejercicio
    Ejemplo:
    Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.

```js
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
```











