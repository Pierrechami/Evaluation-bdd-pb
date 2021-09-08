-- connexion au serveur MySQL
mysql -h localhost:8889 -u root -p root

-- Afficher la liste des bases de données
SHOW databases;

-- Création de la  base de données
CREATE DATABASE  reservation_place_cinema ;

-- Sélectionner la bbd souhaité pour la création de table
USE reservation_place_cinema ;

-- Creation des tables

CREATE TABLE Administrator
(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL ,
    First_name VARCHAR(60) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE Infos
(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    phone INT(10) NOT NULL ,
    address VARCHAR(250) NOT NULL ,
    postal_code VARCHAR(5) NOT NULL ,
    city VARCHAR(60),
    id_administrator int(10) ,
    FOREIGN KEY (id_administrator) REFERENCES Administrator (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


CREATE TABLE CinemaComplex
(
    id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
    name VARCHAR(60) NOT NULL,
    id_info INT(10) NOT NULL ,
    FOREIGN KEY (id_info) REFERENCES Infos (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

CREATE TABLE Halls
(
    id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
    type_hall VARCHAR(60) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

CREATE TABLE MovieTheatres
(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    number_halls INT(10) NOT NULL ,
    nbr_places INT(10) NOT NULL ,
    id_complex INT(10) NOT NULL ,
    id_type_hall INT(10) NOT NULL ,
    FOREIGN KEY (id_complex) REFERENCES CinemaComplex (id) ,
    FOREIGN KEY (id_type_hall) REFERENCES Halls (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


CREATE TABLE Genre
(
    id INT(100) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
    libelle VARCHAR(50) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

CREATE TABLE Movies
(
    id INT(100) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
    name VARCHAR(60) NOT NULL ,
    time TIME NOT NULL ,
    director VARCHAR(60) NOT NULL ,
    id_genre INT(100) NOT NULL ,
    FOREIGN KEY (id_genre) REFERENCES Genre (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

CREATE TABLE Payment
(
    id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
    type_payment VARCHAR(60) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

CREATE TABLE PriceList
(
    id INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
    type_price VARCHAR(60) NOT NULL ,
    price DECIMAL (4,2) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

CREATE TABLE Customers
(
    id CHAR(36) PRIMARY KEY NOT NULL,
    name VARCHAR(20) NOT NULL ,
    first_name VARCHAR(20) NOT NULL ,
    age INT(2) NOT NULL ,
    email VARCHAR(254) NOT NULL UNIQUE,
    passeword CHAR(60) NOT NULL,
    id_tarif INT(10) NOT NULL ,
    FOREIGN KEY (id_tarif) REFERENCES PriceList (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

CREATE TABLE Bookings
(
    id CHAR(36) NOT NULL PRIMARY KEY ,
    start_time DATETIME NOT NULL,
    id_customer CHAR(36) NOT NULL,
    id_movie INT(100) NOT NULL ,
    id_movie_theatres INT(10) NOT NULL ,
    id_payment INT(10) NOT NULL ,
    FOREIGN KEY (id_customer) REFERENCES Customers (id) ,
    FOREIGN KEY (id_movie) REFERENCES Movies (id) ,
    FOREIGN KEY (id_movie_theatres) REFERENCES MovieTheatres (id),
    FOREIGN KEY (id_payment) REFERENCES Payment (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;


-- Insertion des scripts  d'alimentation factice de données dans la base

INSERT INTO Administrator ( name, First_name) VALUES ('Chamiande' , 'Pierre' ) , ('Chaminade' , 'Thomas') , ('Bonmatin' , 'Camille') , ('Charles' , 'Romain') ;

INSERT INTO Infos (phone , address, postal_code , city , id_administrator ) VALUES ('0552456711' , '166 rue combe des dames ' , '33000' , 'Bordeaux' , '1') , ( '0555908722' , '12 rue georges bonnac ' , '33600' , 'Pessac' , '2' )  , ('0555356733' , '7 quai des Queryries' , '33200' , 'Talence' , '3') , ('0555906544' , '9 Rue Montesquieu' , '33320' , 'Eysines' , '4')  ;

INSERT INTO CinemaComplex (name , id_info )  VALUES ( 'UGC Bordeaux' , '1' ) , ( 'UGC Pessac ' , '2' ) , ( 'UGC Talence' , '3' ) , ( 'UGC Eysines' , '4' ) ;

INSERT INTO Halls (type_hall) VALUES  ( 'Privé') , ('Confort') , ('Classique') , ('3d') ;

INSERT INTO MovieTheatres
( number_halls , nbr_places , id_complex , id_type_hall )
VALUES
('1', '70', '1', '3') ,
('2', '50', '1', '3') ,
('3', '50', '1', '3') ,
('4', '10', '1', '1') ,
('5', '25', '1', '2') ,
('6', '35', '1', '4') ,

('1', '66', '2', '3') ,
('2', '40', '2', '3') ,
('3', '40', '2', '3') ,
('4', '5', '2', '1') ,
('5', '20', '2', '2') ,
('6', '35', '2', '4') ,

('1', '70', '3', '3') ,
('2', '55', '3', '3') ,
('3', '50', '3', '3') ,
('4', '5', '3', '1') ,
('5', '25', '3', '2') ,
('6', '35', '3', '4') ,

('1', '55', '4', '3') ,
('2', '45', '4', '3') ,
('3', '45', '4', '3') ,
('4', '70', '4', '3') ,
('5', '5', '4', '1') ,
('6', '20', '4', '2') ;

INSERT INTO Genre (libelle)
VALUES ('Action') ,('Animé') ,('Comédies') ,('Documentaires') ,('Drames') ,('Emotions à la française') ,('Fantastique') ,('Français') ,('Horreur') ,('Indépendants') ,('International') ,('Jeunesse et famille') ,('Musique et comédies musicales') ,('Policier') , ('Romance') , ('SF') , ('Thriller');

INSERT INTO Movies ( name , time , director , id_genre )
VALUES
('The Tomorrow War' , '02:20:00' , 'Chris McKay', '1' ) ,
('30 jours max' , '01:30:00' , 'Tarek Boudali', '3' ) ,
('Legacy, notre héritage' , '01:40:00' , 'Yann Arthus-Bertrand', '4' ) ,
('Cherry' , '02:21:00' , 'Joe Russo, Anthony Russo', '5' ) ,
('Malcolm et Marie' , '01:45:00' , ' Chloé Zhao', '5' ) ,
('Raya et le Dernier Dragon' , '01:57:00' , 'Carlos López Estrada,', '12' ) ,
('Boîte noire' , '02:09:00' , ' Yann Gozlan', '14' ) ,
('Sans aucun remords' , '01:49:00' , 'Stefano Sollima', '1' ) ,
('Gintama: The Final' , '01:44:00' , 'Chizuru Miyawaki', '2' ) ,
('Annette' , '02:20:00' , 'Leos Carax', '13' ) ;


INSERT INTO Payment (type_payment)
VALUES ('Sur place '), ('En ligne ') ;

INSERT INTO PriceList ( type_price , price)
VALUES ('Plein tarif' , 9.20 ) , ('Étudiant' , 7.60 ) , ('Moins de 14 ans' , 5.90) ;

INSERT INTO Customers ( id , name , first_name , age , email , passeword,  id_tarif ,  )
VALUES
( UUID() , 'Dupont' , 'Damien ' , '23' , 'dupont.damien@orange.fr', '$2y$10$95CB2JSatsLn59L.7tleieti63hJsWB79.sVzsXkznmP3EYIYMZFK', '1' ) ,
( UUID() , 'Delboss' , 'Sarah' , '30' , 'delboss.saraaa@sfr.fr', '$2y$10$bySDxozCkoBnlbDP8Evrq.AFk28fcLEj0r0giaYA3VbIIRdAhG1wi', '1'  ) ,
( UUID() , 'Monchet ' , 'Julien ' , '50' , 'juju-du-24@gmail.com', '$2y$10$JVd2WMZhvR/aIeBLZKttN.f1wPUW3RxyPJPpDJX8dbW10qxVkyRYq', '1'  ) ,
( UUID() , 'Beauvieux' , 'Raphael' , '13' , 'raphou.psg@gmail.com', '$2y$10$HyBo40LN4zWdVHb6kY8QJecGclXM4bY3EZxeKRxSWruUrVF5iKFNy', '3' ) ,
( UUID() , 'Gay' , 'Theo' , '10' ,'theo.gay@orange.fr', '$2y$10$3WWbeyy8k25llzU3lbW0HOEABaGu/kv9Qu/OxB31A0q26OYgHrjY2', '3' ) ,
( UUID() , 'Alo' , 'Marine' , '18' , 'alo.marine@gmail.com', '$2y$10$TWUMSEb4BS5Xau.t.m6e8eiE7fR7pwljZ8CA7cXLoLKwJYkYGxsSG', '2' ) ,
( UUID() , 'Dautriat' , 'Laura' , '18' , 'laura.dautriat@orange.fr', '$2y$10$SXl/BamvEREk1CTWbiZno.JN9/llqHCC2kAr4Kjf20YJd9f9dQiLC', '2' ) ,
( UUID() , 'Cesaire' , 'Lucile' , '45' , 'lulu-du-24@gmail.com', '$2y$10$qF9jMCsx/CLqOrNdOzC0/OKfnW2rrGxTKprsh21YdlbfNJdUTAb2u', '1'  ) ,
( UUID() , 'Mauribot' , 'Manon' , '60' , 'manom.medecin@gmail.com', '$2y$10$DIBRwlZQceYD5HUHXu87D.YZzXBs95Em5jZVwfv2ASqDcLbJs06pC', '1' ) ,
( UUID() , 'Soulat' , 'Jean' , '39' , 'jean.soulat@sfr.fr', '$2y$10$w9Kl8N2ZEC5wBwim.HrZ.eG.kl2eQra.Jx7zy99NYqwNN/ZXlsdzi', '1' ) ;



INSERT INTO Bookings ( id , start_time , id_customer , id_movie , id_movie_theatres  , id_payment)
VALUES
(UUID() , '2021-07-27 10:30:00' , 'd2f94fd8-f03c-11eb-be47-8943b5c2ad1e' , '1' , '22'  , '2') ,
(UUID() , '2021-07-27 10:30:00' , 'd2f9fa32-f03c-11eb-be47-8943b5c2ad1e' , '1' , '22' , '2' ) ,
(UUID() , '2021-07-27 10:30:00' , 'd2f9fcd0-f03c-11eb-be47-8943b5c2ad1e' , '1' , '22', '1'  ) ,
(UUID() , '2021-07-27 10:30:00' , 'd2fa011c-f03c-11eb-be47-8943b5c2ad1e' , '1' , '21' ,'2' ) ,
(UUID() , '2021-07-27 11:00:00' , 'd2fa04aa-f03c-11eb-be47-8943b5c2ad1e' , '6' , '5' , '1' ) ,
(UUID() , '2021-07-27 11:00:00' , 'd2fa05a4-f03c-11eb-be47-8943b5c2ad1e' , '6' , '5' , '2' ) ,
(UUID() , '2021-07-27 14:30:00' , 'd2f9ff1e-f03c-11eb-be47-8943b5c2ad1e' , '2' , '14'  , '1') ,
(UUID() , '2021-07-27 15:30:00' , 'd2f9fff0-f03c-11eb-be47-8943b5c2ad1e' , '7' , '9' , '1' ) ,
(UUID() , '2021-07-27 16:00:00' , 'd2f9fdac-f03c-11eb-be47-8943b5c2ad1e' , '10' , '19' , '1' ) ,
(UUID() , '2021-07-27 22:00:00' , 'd2f9fe6a-f03c-11eb-be47-8943b5c2ad1e' , '9' , '5' , '2' ) ;


-- Requêtes sql permettant de démontrer la fiabilité de la bbd par rapport aux exigences du client


-- Montre grace au numéro de réservation qu'il y a la possibilité de réserver un film dans plusieurs cinémas
SELECT bookings.id  AS 'Numéro de reservation' , Movies.name AS 'Nom du film' , CinemaComplex.name AS 'Complex cinema'
FROM Bookings
JOIN Movies ON Movies.id = Bookings.id_movie
JOIN MovieTheatres ON  MovieTheatres.id = Bookings.id_movie_theatres
JOIN CinemaComplex ON MovieTheatres.id_complex = CinemaComplex.id
ORDER BY CinemaComplex.name ;

-- Montre des réservations avec le passage du même film et du même complexe, mais pas à la même salle
SELECT bookings.id  AS 'Numero de reservation' , Bookings.start_time , Movies.name AS 'Nom du film' , CinemaComplex.name AS 'Complex cinema' , MovieTheatres.number_halls AS 'Numéro de salle '
FROM Bookings
JOIN Movies ON Movies.id = Bookings.id_movie
JOIN MovieTheatres ON  MovieTheatres.id = Bookings.id_movie_theatres
JOIN CinemaComplex ON MovieTheatres.id_complex = CinemaComplex.id
ORDER BY Bookings.start_time  ;


-- Permet de calculer le nombre de places restant dans une salle pour une séance donné
SELECT CinemaComplex.name AS 'Nom du cinéma' , MovieTheatres.number_halls AS 'Numéro de salle' , MovieTheatres.nbr_places AS 'Nombre de place total' , count(Bookings.id_movie_theatres) AS 'Nombre de réservation' , MovieTheatres.nbr_places - count(Bookings.id_movie_theatres) AS 'Places restant'
FROM Bookings
JOIN MovieTheatres ON Bookings.id_movie_theatres = MovieTheatres.id
JOIN CinemaComplex  ON MovieTheatres.id_complex = CinemaComplex.id
GROUP BY MovieTheatres.id ;

-- différents tarifs
SELECT *
FROM Payment

-- Tableau permettant de savoir si les clients ont payé sur place ou en ligne
SELECT Bookings.id AS 'Numéro de réservation' , CONCAT(Customers.name , ' ' , Customers.first_name) AS 'Nom et Prénom du client' , Payment.type_payment 'Choix du paiement'
FROM Bookings
JOIN Customers ON Bookings.id_customer = Customers.id
JOIN Payment ON Bookings.id_payment = Payment.id ;

-- Tableau permettant de connaître l'administrateur du cinéma
SELECT CinemaComplex.name 'Nom du cinéma' ,  CONCAT(Administrator.name,  ' ' , Administrator.First_name) AS 'Nom Prenom'
FROM CinemaComplex
JOIN infos ON CinemaComplex.id_info = Infos.id
JOIN Administrator ON Infos.id_administrator = Administrator.id ;



-- Utilisation d'un utilitaire de sauvegarde de la base de données 
mysqldump -u root -p root -h localhost:8889 > evaluation.sql

--Utilisation d'un utilitaire de restauration de la base de données
mysql reservation_place_cinema < evaluation.sql