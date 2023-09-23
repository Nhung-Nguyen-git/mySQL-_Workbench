use sakila;
use city;
use country;
use address;
-- Lấy ra tên các thành phố và tên các quốc gia tương ứng của thành phố đó:-- 
SELECT city.city, country.country
FROM city
INNER JOIN country ON city.country_id = country.country_id;


-- lấy ra tên các thành phố của nước Mỹ:--

SELECT city.city
FROM city
INNER JOIN country ON city.country_id = country.country_id
WHERE country.country = 'United States';


-- Lấy ra các địa chỉ của thành phố Hanoi:
SELECT address.address
FROM address
INNER JOIN city ON address.city_id = city.city_id
WHERE city.city = 'Hanoi';

-- Lấy ra tên, mô tả, tên category của các bộ phim có rating = R
SELECT film.title, film.description, category.name
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE film.rating = 'R';

-- --Lấy ra thông tin của các bộ phim mà diễn viên NICK WAHLBERG tham gia 

SELECT film.title, film.description, film.release_year
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'NICK' AND actor.last_name = 'WAHLBERG';

-- Tìm email của các khách hàng ở Mỹ
SELECT customer.email
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
WHERE country.country = 'United States';








