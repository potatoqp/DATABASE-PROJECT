CREATE DATABASE travel_agency_improved;
USE travel_agency_improved;
#branch
CREATE TABLE branch(
br_code INT(11) NOT NULL ,
br_street VARCHAR(30) DEFAULT 'unknown',
br_num INT(4) DEFAULT '0',
br_city VARCHAR(30) DEFAULT 'unknown',
PRIMARY KEY (br_code)
);
#worker
CREATE TABLE WORKER
(
wrk_AT char(10) NOT NULL,
wrk_name VARCHAR(20) DEFAULT 'unknown',
wrk_lname VARCHAR(20) DEFAULT 'unknown',
wrk_salary FLOAT(7,2) DEFAULT '0',
wrk_br_code INT(11),
PRIMARY KEY (wrk_AT),
CONSTRAINT WORKBRCODE FOREIGN KEY (wrk_br_code) REFERENCES branch(br_code)
);

#driver
CREATE TABLE driver
(
drv_AT CHAR(10) NOT NULL,
drv_license ENUM('A','B','C','D'),
drv_route ENUM('LOCAL', 'ABROAD'),
drv_experience TINYINT(4) DEFAULT '0',
CONSTRAINT WORKERDRAT FOREIGN KEY (drv_AT) REFERENCES worker(wrk_AT),
PRIMARY KEY (drv_AT)
);

#guide
CREATE TABLE guide
(
gui_AT CHAR (10) NOT NULL,
gui_cv TEXT,
PRIMARY KEY (gui_AT),
CONSTRAINT WORKERGUIAT FOREIGN KEY (gui_AT) REFERENCES worker(wrk_AT)
);

#trip
CREATE TABLE trip(
tr_id INT(11) NOT NULL , 
tr_departure DATETIME NOT NULL,
tr_return DATETIME NOT NULL,
tr_maxseats TINYINT(4) DEFAULT '0',
tr_cost FLOAT(7,2) DEFAULT '0',
tr_br_code INT(11) NOT NULL,
tr_gui_AT CHAR(10),
tr_drv_AT CHAR(10),
PRIMARY KEY (tr_id),
CONSTRAINT TRIPBRCODE FOREIGN KEY (tr_br_code) REFERENCES branch(br_code),
CONSTRAINT TRIPGUIAT FOREIGN KEY (tr_gui_AT) REFERENCES guide(gui_AT),
CONSTRAINT TRIPDRVAT FOREIGN KEY (tr_drv_AT) REFERENCES driver(drv_AT)
);

#languages
CREATE TABLE languages
(
lng_gui_AT CHAR(10) NOT NULL,
lng_language VARCHAR(30),
PRIMARY KEY (lng_gui_AT,lng_language),
CONSTRAINT LNGGUIAT FOREIGN KEY (lng_gui_AT) REFERENCES guide(gui_AT)
);

#reservation
CREATE TABLE reservation
(
res_tr_id INT(11) NOT NULL,
res_seatnum TINYINT(4) NOT NULL,
res_name VARCHAR(20) DEFAULT 'UNKNOWN',
res_lname VARCHAR(20) DEFAULT 'unknown',
res_isadult ENUM('ADULT', 'MINOR'),
PRIMARY KEY (res_tr_id,res_seatnum),
CONSTRAINT RESTRID FOREIGN KEY (res_tr_id) REFERENCES trip(tr_id)
);

#admin
CREATE TABLE admin
(
adm_AT CHAR(10) NOT NULL,
adm_type ENUM('LOGISTICS', 'ADMINISTRATIVE', 'ACCOUNTING'),
adm_diploma VARCHAR(200) DEFAULT 'unknown',
PRIMARY KEY (adm_AT),
CONSTRAINT WORKERADMAT FOREIGN KEY (adm_AT) REFERENCES worker(wrk_AT)
);

#phones
CREATE TABLE phones
(
ph_br_code INT(11) NOT NULL,
ph_number CHAR(10),
PRIMARY KEY (ph_br_code,ph_number),
CONSTRAINT PHBRCODE FOREIGN KEY (ph_br_code) REFERENCES branch(br_code)
);

#manages
CREATE TABLE manages
(
mng_adm_AT CHAR(10) NOT NULL,
mng_br_code INT(11) NOT NULL,
PRIMARY KEY (mng_adm_AT, mng_br_code),
CONSTRAINT MNGADMAT FOREIGN KEY (mng_adm_AT) REFERENCES admin(adm_AT),
CONSTRAINT MNGBRCODE FOREIGN KEY (mng_br_code) REFERENCES branch(br_code)
);

#destination
CREATE TABLE destination
(
dst_id INT(11) NOT NULL,
dst_name VARCHAR(50) DEFAULT 'UNKNOWN',
dst_descr TEXT,
dst_rtype ENUM('LOCAL', 'ABROAD'),
dst_language VARCHAR(30) DEFAULT 'UNKNOWN',
dst_location INT(11),
PRIMARY KEY (dst_id),
CONSTRAINT LOCATIONID FOREIGN KEY (dst_location) REFERENCES destination(dst_id)
);

#travel_to
CREATE TABLE travel_to
(
to_tr_id INT(11) NOT NULL,
to_dst_id INT(11) NOT NULL,
to_arrival DATETIME,
to_departure DATETIME,
PRIMARY KEY (to_tr_id,to_dst_id),
CONSTRAINT TOTRID FOREIGN KEY (to_tr_id) REFERENCES trip(tr_id),
CONSTRAINT TODSTID FOREIGN KEY (to_dst_id) REFERENCES destination(dst_id)
);

#event
CREATE TABLE event
(
ev_tr_id INT(11) NOT NULL,
ev_start DATETIME NOT NULL,
ev_end DATETIME,
ev_descr TEXT,
PRIMARY KEY (ev_tr_id,ev_start),
CONSTRAINT EVTRID FOREIGN KEY (ev_tr_id) REFERENCES trip(tr_id)
);

#insert branch
INSERT INTO branch VALUES
(2, 'Korinthou', 13, 'Patra'),
(3, 'Naumaxias Ellhs', 91, 'Patra'),
(4, 'Gewrgiou', 45, 'Korinthos'),
(5, 'Purosvestiou', 32, 'Patra'),
(6, 'Korinthou', 125, 'Patra'),
(7, 'Vyrwnos', 58, 'Kalamata'),
(8, 'Theodorou', 39, 'Orestiada'),
(9, 'Ellhnws', 78, 'Athina'),
(10, 'Swthriou', 67, 'Athina'),
(11, 'Nikolaou', 44, 'Kerkura'),
(12, 'Xarilaou', 122, 'Athina'),
(13, 'Kwlokotrwnh', 1, 'Patra'),
(14, 'Psathou', 69, 'Otava'),
(15, 'Giannoulas', 99, 'Kalamata'),
(16, 'Periklews', 177, 'Orestiada'),
(17, 'Fragou', 22, 'Tripolh'),
(18, 'Psarwn', 75, 'Kalamata'),
(19, 'Iwannh', 66, 'Athina'),
(20, 'Kalavritwn', 25, 'Kalavrita'),
(21, 'Dhmhtriou', 133, 'Orestiada'),
(22, 'Platonos', 88, 'Iwannina'),
(23, 'Trikouph', 7, 'Athina'),
(24, 'Anastasews', 97, 'Athina'),
(25, 'Mukwnou', 31, 'Mukwnos'),
(26, 'Alexandrou', 234, 'Athina'),
(27, 'Hraklh', 2, 'Volos'),
(28, 'Papoulia', 90, 'Athina'),
(29, 'Athanasiou', 68, 'Kalamata'),
(30, 'Nauarinou', 11, 'Kalamata'),
(31, 'Panagiwth', 81, 'Volos'),
(32, 'Andronikhs', 5, 'Iwannina');

SELECT* FROM branch;

#insert into phones
INSERT INTO phones VALUES
(2, '6945453434'),
(3, '6948237263'),
(4, '6937284935'),
(5, '6971354152'),
(6, '6923462464'),
(7, '6902843536'),
(8, '6927274514'),
(9, '6913354053'),
(10, '692332405'),
(11, '692321045'),
(12, '696234245'),
(13, '694204653'),
(15, '694050240'),
(16, '693040523'),
(17, '691234567'),
(18, '698765432'),
(19, '698789087'),
(20, '694747829'),
(21, '692242045'),
(22, '693038256'),
(23, '692432405'),
(24, '693023405'),
(25, '694303040'),
(26, '692828506'),
(27, '698320402'),
(28, '694383856'),
(29, '691425869'),
(30, '690285856'),
(31, '690693857');

SELECT* FROM phones;

#insert into worker
INSERT INTO worker VALUES 
('AB12345', 'Gewrgios', 'Pappadopoulos', 1500.21, 2),
('AB12355', 'Thanasis', 'Darsaklis', 1300.54, 3),
('AB12344', 'Iwannhs', 'Pappoulias', 1345.45, 2),
('AB12334', 'Orestis', 'Iwannou', 2312.57, 5),
('AB11234', 'Gewrgia', 'Pappagewrgiou', 1670.23, 5),
('AB12234', 'Iwanna', 'Oikonomopoulou', 1456.66, 5),
('AB22134', 'Vasiliki', 'Athanasiou', 1678.34, 8),
('AB22341', 'Periklis', 'Fragos', 2899.99, 9),
('AB22431', 'Dhmhtrhs', 'Athanasopoulos', 2456.56, 10),
('AB22222', 'Gewrgious', 'Gewrgiou', 1899.99, 11),
('AB11111', 'Periklis', 'Anastasiou', 1777.77, 12),
('AB33333', 'Omhros', 'Periklews', 1555.55, 13),
('AB44444', 'Thewdoros', 'Petiniarhs', 2333.34, 13),
('AB55555', 'Stauros', 'Doulamhs', 1345.45, 13),
('AB66666', 'Dhmhtrhs', 'Dhmopoulos', 1888.88, 17),
('AB77777', 'Panagiwta', 'Dhmakopoulou', 1643.23, 18),
('AB88888', 'Kwnstantina', 'Zagwriou', 1566.32, 19),
('AB99999', 'Anastashs', 'Komninos', 1987.42, 20),
('AB00000', 'Panagiwths', 'Pappadopoulos', 2546.32, 22),
('AB01234', 'Elias', 'Pappadopoulos', 3567.77, 22),
('AB00022', 'Thanasis', 'Gewrgiou', 1522.21, 23),
('AB00011', 'Makhs', 'Kanelopoulos', 1699.99, 24),
('AB00033', 'Sofia', 'Panagiwtakopoulou', 1888.88, 26),
('AB00044', 'Vasiliki', 'Gewrgakopoulou', 1987.87, 26),
('AB00055', 'Athanasia', 'Vasilakopoulou', 2456.45, 27),
('AB00066', 'Gewrgios', 'Tsalas', 1845.43, 28),
('AB00077', 'Iwannhs', 'Dedoushs', 1967.67, 29),
('AB00088', 'Vaggelhs', 'Goletsos', 1845.67, 30),
('AB00099', 'Vasilis', 'Vordakis', 1967.32, 31),
('AB00111', 'Orestis', 'Taramas', 1878.22, 28),
('ABC1111', 'Theodoros', 'Paulopoulos', 1400.23, 2),
('ABC1112', 'Gewrgios', 'Theodoropoulos', 1532.21, 3),
('ABC1113', 'Grhgorhs', 'Grhgoropoulos', 1600.23, 5),
('ABC1114', 'Xrhstos', 'Gewrgiou', 1678.24, 8),
('ABC1115', 'Nikos', 'Athanasopoulos', 1789.23, 8),
('ABC1116', 'Swthrhs', 'Papadopoulos', 1678.23, 10),
('ABC1117', 'Gewrgios', 'Anestopoulos', 1500.23, 12),
('ABC1118', 'Thanasis', 'Papadopoulos', 1867.25, 13),
('ABC1119', 'Georgia', 'Athanasopoulou', 1876.23, 13),
('ABC1110', 'Kwnstadina', 'Gewrgiou', 1678.23, 30);

SELECT* FROM worker;

#insert into guide
INSERT INTO guide VALUES
('AB00011', 'Tha sas deiksw to topio'),
('AB00033', 'Tha sas deiksw ta aksiotheta'),
('AB00055', 'Tha sas paw voltes'),
('AB12345', 'Tha sas deiksw to arxaiologiko mouseio'),
('AB12344', 'Tha sas deiksw to istoriko mouseio'),
('AB22134', 'Tha sas deiksw to zwlogiko khpo'),
('AB22341', 'Tha sas deiksw to megalo mouseio'),
('AB33333', 'Tha sas deiksw to agalma'),
('AB00099', 'Tha sas deiksw to topio'),
('AB12334', 'Tha sas deiksw ton xwro');

SELECT* FROM guide;

#insert into driver
INSERT INTO driver VALUES
('AB00066', 'A', 'LOCAL', 2),
('AB00044', 'A', 'LOCAL', 3),
('AB11111', 'B', 'ABROAD', 3),
('AB12345', 'C', 'ABROAD', 5),
('AB11234', 'A', 'LOCAL', 2),
('AB22134', 'A', 'LOCAL', 1),
('AB44444', 'B', 'ABROAD', 4),
('AB66666', 'A', 'LOCAL', 2),
('AB99999', 'B', 'ABROAD', 3),
('AB22222', 'C', 'ABROAD', 6);

SELECT* FROM driver;

#insert into admin
INSERT INTO admin VALUES
('AB00011', 'LOGISTICS', 'Logistiko Panepistimio'),
('AB12234', 'ADMINISTRATIVE', 'Dioikhsh Epixeirisewn Patra'),
('AB00111', 'ACCOUNTING', 'Logistiko Panepistimio'),
('AB00077', 'ADMINISTRATIVE', 'Dioikhsh Epixeirisewn Athina'),
('AB22431', 'ACCOUNTING', 'Logistiko IEK'),
('AB88888', 'LOGISTICS', 'Logistiko IEK'),
('AB22222', 'ADMINISTRATIVE', 'Dioikhsh Epixeirisewn Athina'),
('AB00000', 'LOGISTICS', 'Logistiko Athinas'),
('AB55555', 'ADMINISTRATIVE', 'Dioikhsh Epixeirisewn Patra'),
('AB01234', 'ACCOUNTING', 'Logistiko Panepistimio');

SELECT* FROM admin;

#insert into manages
INSERT INTO manages VALUES
('AB00077', 5),
('AB22222', 3),
('AB55555', 12),
('AB12234', 6);

SELECT* FROM manages;

#insert into languages
INSERT INTO languages VALUES
('AB00011', 'Greek'),
('AB00033', 'Russian'),
('AB00055', 'English'),
('AB12345', 'Greek'),
('AB12344', 'Chinese'),
('AB22134', 'Polish'),
('AB22341', 'English'),
('AB33333', 'Chinese'),
('AB00099', 'Russian'),
('AB12334', 'English');

SELECT* FROM languages;

#insert into trip
INSERT INTO trip VALUES
(1, '2022-12-12T10:34:09', '2022-12-30T10:20:12', 50, 1500.12, 2, 'AB00011', 'AB00066'),
(2, '2022-12-11T09:23:45', '2022-12-29T09:20:20', 50, 1500.12, 2, 'AB00011', 'AB00066'),
(31, '2022-12-28T10:35:35', '2023-01-02T08:32:32', 50, 1500.21, 3, 'AB22341', 'AB00044'),
(32, '2022-11-12T13:23:43', '2022-11-19T12:45:34', 45, 1672.65, 11,'AB00099', 'AB22222' ),
(33, '2022-10-10T16:56:43', '2022-10-12T16:43:23', 43,1984.45, 6, 'AB12344', 'AB22222'),
(34, '2022-09-23T14:23:24', '2022-09-27T13:25:26', 34, 2019.12, 8, 'AB12345', 'AB22134'),
(35, '2022-09-22T12:12:12', '2022-09-27T12:14:14', 35, 1968.23, 9, 'AB22341', 'AB00066'),
(36, '2022-09-12T08:12:12', '2022-09-16T10:34:12', 40,  1857.25, 10, 'AB33333', 'AB44444'),
(37, '2022-08-15T12:23:45', '2022-08-19T13:23:12', 50,  1789.56, 16, 'AB00033', 'AB00044'),
(38, '2022-08-12T16:34:24', '2022-08-22T12:45:23', 50,  1678.23, 3, 'AB22341', 'AB00044'),
(39, '2022-07-12T12:12:12', '2022-07-18T18:18:18', 40,  2975.45, 18, 'AB00055', 'AB11234'),
(40, '2022-07-18T12:23:45', '2022-07-22T19:18:12', 34,  1968.54, 20, 'AB00055', 'AB00066'),
(41, '2022-07-19T13:14:23', '2022-07-28T15:34:23', 30,  1789.45, 16, 'AB22134', 'AB11111'),
(42, '2022-07-23T13:14:23', '2022-07-29T14:32:23', 50,  1956.67, 2, 'AB12345', 'AB12345'),
(43, '2022-09-23T17:12:45', '2022-09-27T13:23:54', 43,  1789.45, 3, 'AB12334', 'AB44444'),
(44, '2022-08-26T15:34:21', '2022-09-02T12:24:12', 50,  1978.34, 5, 'AB00055', 'AB22134'),
(45, '2022-09-12T13:21:45', '2022-09-16T14:56:21', 43,  1867.33, 21, 'AB33333', 'AB11111'),
(46, '2022-10-10T10:10:10', '2022-10-14T14:14:14', 47,  1578.23, 22, 'AB12334', 'AB44444'),
(47, '2022-10-15T10:14:13', '2022-10-19T19:14:21', 50,  1856.67, 25, 'AB22341', 'AB22222'),
(48, '2022-10-13T14:23:12', '2022-10-17T15:24:23', 32,  1945.54, 27, 'AB00033', 'AB11234'),
(49, '2022-10-24T15:23:16', '2022-10-30T19:24:12', 50,  1678.67, 25, 'AB12344', 'AB22134'),
(50, '2022-08-12T17:24:12', '2022-08-22T19:25:27', 43,  1898.89, 30, 'AB00099', 'AB11111'),
(51, '2022-09-30T20:12:45', '2022-10-07T03:02:01', 34,  1999.99, 10, 'AB12345','AB00066'),
(52, '2022-11-11T11:11:11', '2022-11-18T18:18:18', 38, 2345.45, 7, 'AB00033', 'AB22134'),
(53, '2022-12-19T12:34:56', '2022-12-30T19:34:55', 39, 1789.89, 11, 'AB12334','AB99999'),
(54, '2023-01-15T16:35:23', '2023-01-19T16:34:23', 55, 1898.78, 17, 'AB00055', 'AB66666'),
(55, '2023-01-19T19:35:23', '2023-01-30T13:46:25', 53, 1456.34, 23, 'AB33333', 'AB66666'),
(56, '2023-01-17T17:32:53', '2023-01-28T18:25:23', 51, 1678.56, 3, 'AB12345', 'AB12345'),
(57, '2023-01-20T19:24:21', '2023-02-01T20:23:12', 55, 1898.78, 30, 'AB00099', 'AB22134'),
(58, '2023-02-06T19:34:56', '2023-02-15T19:25:26', 55, 2045.56, 8, 'AB12344', 'AB12345');

SELECT* FROM trip;

#insert into event

INSERT INTO event VALUES
(1, '2022-12-13T12:43:23', '2022-12-13T14:45:32', 'Fun event for children and adults'),
(2, '2022-12-12T12:43:12', '2022-12-26T16:32:45', 'Fun event for everyone alike'),
(31, '2022-12-29T12:21:12', '2022-12-30T18:12:12', 'Extreme sports for adults'),
(32, '2022-11-13T12:12:12', '2022-11-15T16:12:43', 'Relegious expedition'),
(33, '2022-10-11T12:14:12', '2022-10-12T13:12:54', 'Amusment Park visit'),
(34, '2022-09-24T14:32:12', '2022-09-25T13:45:34', 'Visit to hospital'),
(35, '2022-09-23T13:23:45', '2022-09-25T14:24:23', 'Expedition to the mountain'),
(36, '2022-09-13T12:23:43', '2022-09-15T14:43:23', 'Expedition to the monastery'),
(37, '2022-08-16T13:24:54', '2022-08-18T15:23:12', 'Amusment Park visit'),
(38, '2022-08-13T13:24:54', '2022-08-13T18:24:54', 'Exploration in the forest'),
(39, '2022-07-13T12:35:21', '2022-07-15T14:32:12', 'Extreme sports for children'),
(40, '2022-07-19T14:23:45', '2022-07-20T15:32:12', 'Funtime'),
(41, '2022-07-20T11:21:16', '2022-07-24T16:23:12', 'Football matches'),
(42, '2022-07-24T16:34:18', '2022-07-28T18:25:45', 'Italian Pizza'),
(43, '2022-09-24T17:23:12', '2022-09-25T19:23:54', 'Basketball Match'),
(44, '2022-08-27T13:25:15', '2022-08-30T16:24:21', 'Race'),
(45, '2022-09-14T16:12:43', '2022-09-15T14:21:12', 'Fun event for everyone alike'),
(46, '2022-10-11T14:23:12', '2022-10-13T16:23:12', 'Visit to factory'),
(47, '2022-10-16T15:26:35', '2022-10-18T18:23:43', 'Expedition to the mountain'),
(48, '2022-10-14T14:23:45', '2022-10-16T14:23:43', 'Amusment Park visit'),
(49, '2022-10-25T17:14:23', '2022-10-29T12:14:23', 'Expedition to the monastery'),
(50, '2022-08-13T14:23:43', '2022-08-20T13:43:23', 'Marathon running'),
(51, '2022-09-30T21:12:32', '2022-10-01T21:23:23', 'Birthday Party'),
(52, '2022-11-12T12:12:12', '2022-11-13T14:25:43', 'Funtime'),
(53, '2022-12-20T14:23:43', '2022-12-24T16:23:12', 'Arcade games'),
(54, '2023-01-17T13:34:21', '2023-01-18T15:32:21', 'NBA event'),
(55, '2023-01-20T12:35:21', '2023-01-26T18:23:21', 'Visit to hospital'),
(56, '2023-01-18T14:23:43', '2023-01-19T14:23:12', 'Visit to museum'),
(57, '2023-01-21T15:24:21', '2023-01-25T15:32:12', 'Visit to museum'),
(58, '2023-02-07T16:23:12', '2023-02-13T14:23:12', 'Fun event');

SELECT* FROM event;

#insert into reservation

INSERT INTO reservation VALUES
(34, 15, 'Iwannhs', 'Spilliotopoulos', 'MINOR'),
(36, 14, 'Swthrhs', 'Iwannidhs', 'ADULT'),
(54, 17,'Kwstas', 'Karagiannhs', 'ADULT'),
(55, 17, 'Thanashs', 'Orestiadhs', 'ADULT'),
(35, 18, 'Giwrgos', 'Papathanashs', 'MINOR'),
(2, 19, 'Thewdoros', 'Papatheodwrou', 'ADULT'),
(49, 47, 'Vasilis', 'Miltiadhs', 'MINOR'),
(42, 56, 'Nikos', 'Anastasiou', 'ADULT'),
(35, 54, 'Nikos', 'Anastasiadhs', 'MINOR'),
(32, 21, 'Dhmhths', 'Alexiou', 'MINOR'),
(38, 21, 'Panagiwths', 'Alexopoulos', 'ADULT'),
(1, 27, 'Giwrgos', 'Xristopoulos', 'ADULT'),
(52, 28, 'Anesths', 'Thanasiou', 'MINOR'),
(50, 57, 'Periklis', 'Papathanasopoulos', 'ADULT'),
(47, 43, 'Xristos', 'Papaiwannou', 'ADULT'),
(58, 55, 'Thanasis', 'Pappadopoulos', 'MINOR'),
(50, 69, 'Vasilis', 'Pappadopoulos', 'ADULT'),
(40, 67, 'Thewdoros', 'Iwannou', 'MINOR'),
(35, 78, 'Theofilos', 'Theofilou', 'ADULT'),
(39, 81, 'Petros', 'Petrou', 'ADULT'),
(43, 79, 'Giwrgos', 'Theofilou', 'MINOR'),
(47, 91, 'Theodoros', 'Theodorou', 'ADULT'),
(49, 99, 'Nikos', 'Athanasiou', 'ADULT'),
(43, 90, 'Thanasis', 'Martanis', 'MINOR'),
(36, 47, 'Thanashs', 'Alexiou', 'ADULT'),
(32, 23, 'Anastashs', 'Kastanas', 'MINOR'),
(36, 28, 'Nikos', 'Anastasiadhs', 'ADULT'),
(48, 32, 'Axilleas', 'Papaiwannou', 'MINOR');

SELECT* FROM reservation;

#insert into destination

INSERT INTO destination VALUES
(1, 'Carribean', 'Many islands', 'ABROAD', 'Spanish', 1),
(2, 'Athens', 'Capital of Greece', 'LOCAL', 'Greek', 2),
(3, 'Volos', 'City of Greece', 'LOCAL', 'Greek', 2),
(4, 'Madrid', 'Capital of Spain', 'ABROAD', 'Spanish', 3),
(5, 'Paris', 'Capital of France', 'ABROAD', 'French', 4),
(6, 'Kalamata', 'City of Greece', 'LOCAL', 'Greek', 2),
(7, 'Carribean', 'Many islands', 'ABROAD', 'Spanish', 1),
(8, 'Athens', 'Capital of Greece', 'LOCAL', 'Greek', 2),
(9, 'Volos', 'City of Greece', 'LOCAL', 'Greek', 2),
(10, 'Madrid', 'Capital of Spain', 'ABROAD', 'Spanish', 3),
(11, 'Paris', 'Capital of France', 'ABROAD', 'French', 4),
(12, 'Kalamata', 'City of Greece', 'LOCAL', 'Greek', 2),
(13, 'Orestiada', 'City of Greece', 'LOCAL', 'Greek', 2),
(14, 'London', 'City of England', 'ABROAD', 'English', 5),
(15, 'Amaliada', 'City of Greece', 'LOCAL', 'Greek', 2),
(16, 'Bejing', 'Capital of China', 'ABROAD', 'Chinese', 6),
(17, 'Carribean', 'Many islands', 'ABROAD', 'Spanish', 1),
(18, 'Athens', 'Capital of Greece', 'LOCAL', 'Greek', 2),
(19, 'Volos', 'City of Greece', 'LOCAL', 'Greek', 2),
(20, 'Madrid', 'Capital of Spain', 'ABROAD', 'Spanish', 3),
(21, 'Paris', 'Capital of France', 'ABROAD', 'French', 4),
(22, 'Kalamata', 'City of Greece', 'LOCAL', 'Greek', 2),
(23, 'Orestiada', 'City of Greece', 'LOCAL', 'Greek', 2),
(24, 'London', 'City of England', 'ABROAD', 'English', 5),
(25, 'Crete', 'Island of Greece', 'LOCAL', 'Greek', 2),
(26, 'Mukwnos', 'Island of Greece', 'LOCAL', 'Greek', 2),
(27, 'Rhodes', 'Island of Greece', 'LOCAL', 'Greek', 2),
(28, 'Barcelona', 'City of Spain', 'ABROAD', 'Spanish', 3),
(29, 'Rome', 'Capital of Italy', 'ABROAD', 'Italian', 7),
(30, 'Milan', 'City of Italy', 'ABROAD', 'Italian', 7),
(31, 'Napoli', 'City of Italy', 'ABROAD', 'Italian', 7),
(32, 'Rome', 'Capital of Italy', 'ABROAD', 'Italian', 7),
(33, 'Turin', 'City of Italy', 'ABROAD', 'Italian', 7),
(34, 'Montevideo', 'Capital of Uruguay', 'ABROAD', 'Spanish', 8),
(35, 'Barcelona', 'City of Spain', 'ABROAD', 'Spanish', 3),
(36, 'Mukwnos', 'Island of Greece', 'LOCAL', 'Greek', 2);

SELECT* FROM destination;


#insert into travel_to

INSERT  INTO travel_to VALUES
(1, 1, '2022-12-12T10:34:09', '2022-12-30T10:20:12' ),
(2, 2, '2022-12-11T09:23:45', '2022-12-29T09:20:20'),
(2, 6, '2022-12-11T12:23:45', '2022-12-29T09:20:20'),
(31, 5, '2022-12-28T10:35:35', '2023-01-02T08:32:32'),
(32, 5, '2022-11-12T13:23:43', '2022-11-19T12:45:34'),
(33, 3, '2022-10-10T16:56:43', '2022-10-12T16:43:23'),
(34, 22, '2022-09-23T14:23:24', '2022-09-27T13:25:26'),
(35, 10, '2022-09-22T12:12:12', '2022-09-27T12:14:14'),
(36, 11, '2022-09-12T08:12:12', '2022-09-16T10:34:12'),
(37, 29, '2022-08-15T12:23:45', '2022-08-19T13:23:12'),
(37, 30, '2022-08-15T14:34:25', '2022-08-19T13:23:12'),
(38, 30, '2022-08-12T16:34:24', '2022-08-22T12:45:23'),
(38, 31, '2022-08-12T18:26:54', '2022-08-22T12:45:23'),
(39, 32, '2022-07-12T12:12:12', '2022-07-18T18:18:18'),
(39, 33, '2022-07-12T15:14:13', '2022-07-18T18:18:18'),
(40, 25, '2022-07-18T12:23:45', '2022-07-22T19:18:12'),
(40, 26, '2022-07-18T13:25:47', '2022-07-22T16:18:12'),
(40, 27, '2022-07-18T16:46:35', '2022-07-22T19:18:12'),
(41, 28, '2022-07-19T13:14:23', '2022-07-28T17:34:23'),
(41, 20, '2022-07-19T15:12:13', '2022-07-28T15:34:23'),
(42, 1, '2022-07-23T13:14:23', '2022-07-29T14:32:23'),
(42, 17,'2022-07-23T13:43:13', '2022-07-29T14:40:23'),
(43, 18, '2022-09-23T17:12:45', '2022-09-27T13:23:54'),
(43, 19, '2022-09-23T18:12:25', '2022-09-27T13:23:54'),
(44, 16, '2022-08-26T15:34:21', '2022-09-02T12:24:12'),
(45, 34, '2022-09-14T16:12:43', '2022-09-15T14:21:12'),
(46, 36, '2022-10-10T10:10:10', '2022-10-14T14:14:14'),
(47, 23,'2022-10-15T10:14:13', '2022-10-19T13:14:21'),
(47, 25, '2022-10-15T15:12:13', '2022-10-19T18:14:21'),
(47, 20, '2022-10-15T19:14:13', '2022-10-19T22:14:21');

SELECT* FROM travel_to;


#create IT
CREATE TABLE IT (
IT_AT char(10),
it_pas VARCHAR(10) DEFAULT 'password',
it_start_date DATE NOT NULL,
it_end_date DATE,
CONSTRAINT ITWRKAT FOREIGN KEY (IT_AT) REFERENCES worker(wrk_AT)
);

#insert_into IT
INSERT INTO IT VALUES
('ABC1111', '123AD43AB2', '2018-12-31', '2019-12-31'),
('ABC1112', '1234AD43AB', '2019-12-31', '2020-05-12'),
('ABC1113', '12345AD43A', '2020-05-12', '2020-12-31'),
('ABC1114', '123456AD43', '2020-12-31', NULL),
('ABC1115', '1234567AD4', '2021-04-04', '2021-05-04'),
('ABC1116', '12345678AD', '2021-05-08', '2021-08-09'),
('ABC1117', '123456789A', '2021-09-15', '2021-11-19'),
('ABC1118', 'AD12345678', '2021-11-24', NULL),
('ABC1119', 'ADG1234567', '2021-12-31', '2022-12-17'),
('ABC1110', 'ADGV123456', '2022-12-17', NULL);
;
SELECT* FROM IT;

#create table LOG
CREATE TABLE log (
user VARCHAR(20),
action  VARCHAR(30),
timestamp TIMESTAMP
);

#create offers
CREATE TABLE offers (
of_id int(10) UNIQUE,
start_date DATE,
end_date DATE,
person_cost FLOAT(7,2),
of_dst INT(11),
PRIMARY KEY (of_id),
CONSTRAINT DSTOF FOREIGN KEY (of_dst) REFERENCES destination (dst_id)
);

#create reservationoffers
CREATE TABLE reservation_offers (
res_of_id int(10) UNIQUE,
lname VARCHAR(50),
name VARCHAR(50),
off_id int(10),
amount INT(10),
PRIMARY KEY (res_of_id),
CONSTRAINT OFRESID FOREIGN KEY (off_id) REFERENCES offers(of_id)
);

#insert into offers
INSERT INTO offers VALUES
(1, '2021-12-31', '2023-08-08', 680.80, 5),
(2, '2021-12-31', '2023-08-06', 670.56, 10),
(3, '2021-12-31', '2023-08-09', 470.23, 16);

SELECT* FROM offers;

#insert into reservation_offers
INSERT INTO reservation_offers VALUES
(1, 'Hernandez', 'Thalia', 1, 58),
(2, 'Rich', 'Josue', 1, 65),
(3, 'Lester', 'Mateo', 1, 69),
(4, 'Cassidy', 'Cole', 1, 79),
(5, 'Griffith', 'Goodwig', 1, 80),
(6, 'Layla', 'Buckley', 1, 87),
(7, 'Giovanni', 'Peter', 1, 89),
(8, 'Santiago', 'Johnny', 1, 76),
(9, 'Rodriguez', 'Lisa', 1, 64),
(10, 'Ross', 'Conrad', 1, 57),
(11, 'Wolf', 'Denis', 2, 110),
(12, 'Brooklyn', 'Gould', 2, 115),
(13, 'Booker', 'Isla', 2, 120),
(14, 'Holt', 'Addison', 2, 125),
(15, 'Phoenix', 'John', 2, 132),
(16, 'Tate', 'Andrew', 2, 137),
(17, 'Tate', 'Tristan', 2, 137),
(18, 'Rush', 'Dominique', 2, 143),
(19, 'Cena', 'John', 2, 147),
(20, 'Cruz', 'Alejandro', 2, 150),
(21, 'Kemp', 'Devin', 3, 152),
(22, 'Lambert', 'Larry', 3, 157),
(23, 'Stevenson', 'Genesis', 3, 165),
(24, 'Henry', 'Breanna', 3, 169),
(25, 'Rubio', 'Camron', 3, 171),
(26, 'Johnston', 'Tommy', 3, 178),
(27, 'Ponce', 'Emmalee', 3, 184),
(28, 'Lee', 'Kobe', 3, 186),
(29, 'Antonio', 'Rui', 3, 197),
(30, 'Warner', 'Garner', 3, 193),
(31, 'Griffith', 'John', 3, 179);

SELECT* FROM reservation_offers;

#3.1.3.1
DELIMITER $
CREATE PROCEDURE newdriver(wrk_AT_par CHAR(10), wrk_name_par VARCHAR(20), wrk_lname_par VARCHAR(20), wrk_salary_par FLOAT(7,2), drv_licence_par ENUM('A', 'B', 'C', 'D'), drv_route_par ENUM('LOCAL', 'ABROAD'), drv_experience_par TINYINT(4))
BEGIN
	DECLARE branch_code INT(10);
    
    SELECT w.wrk_br_code
    FROM worker w
    JOIN driver d
    ON d.drv_AT = w.wrk_AT
    GROUP BY w.wrk_br_code
	ORDER BY COUNT(d.drv_AT) ASC
    LIMIT 1 INTO branch_code;
    
    INSERT INTO worker
    VALUES(wrk_AT_par, wrk_name_par, wrk_lname_par, wrk_salary_par, branch_code);
    
    INSERT INTO driver 
    VALUES(wrk_AT_par, drv_licence_par, drv_route_par, drv_experience_par);

END $
DELIMITER ;

CALL newdriver('AB11822', 'Fratzis', 'Kornilakis', 5000.12, 'D', 'ABROAD', '2');
CALL newdriver('AB11821', 'Nikos', 'Kornilakis', 5321.12, 'C', 'ABROAD', '5');
SELECT* FROM worker;
SELECT* FROM driver;

#3.1.3.2

#ftiaxnoume merikes eggrafes gia na epalitheusoume to apotelesma

SELECT* FROM branch;
SELECT* FROM worker;
INSERT INTO branch VALUES
(33, 'Papandreou', 1, 'Patras');

INSERT INTO worker VALUES
('TEST123', 'Giannis', 'Theodoropoulos', 2600.12, 33),
('TEST122', 'Orestis', 'Theodoropoulos', '2567.12', 33),
('TEST133', 'Giannis', 'Theodoropoulos', '2764.13', 33),
('TEST111', 'Orestis', 'Theodoropoulos', '2653.12', 33);

INSERT INTO driver VALUES
('TEST123', 'B', 'LOCAL', 4),
('TEST133', 'D', 'ABROAD', 5);

INSERT INTO guide VALUES
('TEST122', 'TEST TEST TEST'),
('TEST111', 'TEST TEST TEST TEST');

SELECT* FROM trip;

INSERT INTO trip VALUES
(67, '2022-12-13T10:34:09', '2022-12-25T10:34:09', 58, 2674.23, 33, 'TEST122', 'TEST123'),
(68, '2022-12-15T10:34:09', '2022-12-29T10:34:09', 54, 3231.31, 33, 'TEST111', 'TEST133');

INSERT INTO reservation VALUES
(67, 31, 'Nikos', 'Xardalias', 'ADULT'),
(67, 32, 'Iwanna', 'Xardalia', 'MINOR'),
(68, 43, 'Xristina', 'Gewrgiou', 'ADULT');

DELIMITER $
CREATE PROCEDURE detailsdatenocurs (br_code_par INT(10), start_date_par DATETIME, end_date_par DATETIME)
BEGIN
SELECT tr.tr_cost, tr.tr_maxseats, (SELECT COUNT(*) FROM reservation WHERE res_tr_id = tr.tr_id LIMIT 1) AS reservations, tr.tr_maxseats - (SELECT COUNT(*) FROM reservation WHERE res_tr_id = tr.tr_id LIMIT 1) AS free_seats,
			(SELECT w.wrk_name FROM worker w JOIN driver d ON d.drv_AT = w.wrk_AT WHERE w.wrk_br_code = br_code_par LIMIT 1) AS driver_name, (SELECT w.wrk_lname FROM worker w JOIN driver d ON d.drv_AT = w.wrk_AT WHERE w.wrk_br_code = br_code_par LIMIT 1) AS driver_lname,
			(SELECT w.wrk_name FROM worker w JOIN guide g ON g.gui_AT = w.wrk_AT WHERE w.wrk_br_code = br_code_par LIMIT 1) AS guide_name, (SELECT w.wrk_lname FROM worker w JOIN guide g ON g.gui_AT = w.wrk_AT WHERE w.wrk_br_code = br_code_par LIMIT 1) AS guide_lname,
            tr.tr_departure, tr.tr_return
			FROM trip tr
			JOIN driver d ON 
			d.drv_AT = tr.tr_drv_AT
			JOIN guide g ON
			g.gui_AT = tr.tr_gui_AT
			WHERE tr.tr_br_code = br_code_par
			AND tr.tr_departure BETWEEN start_date_par AND end_date_par;
END$
DELIMITER ;

CALL detailsdatenocurs(33, '2022-12-13T10:34:09', '2022-12-18T10:34:09');



#3.1.3.3
DELIMITER $
CREATE PROCEDURE deleteadmin(adm_name_par VARCHAR(50), adm_lname_par VARCHAR(50))
BEGIN
DECLARE admin_AT char(10);
DECLARE admin_type char(20);

SELECT ad.adm_type
INTO admin_type
FROM worker w
JOIN admin ad ON ad.adm_AT = w.wrk_AT
WHERE w.wrk_name = adm_name_par AND w.wrk_lname = adm_lname_par;



SELECT ad.adm_AT
INTO admin_AT
FROM worker w 
JOIN admin ad ON ad.adm_AT = w.wrk_AT
WHERE w.wrk_name = adm_name_par AND w.wrk_lname = adm_lname_par;

IF admin_type LIKE 'ADMINISTRATIVE' THEN
	SELECT 'Cannot remove this Administrator';
ELSE
	DELETE FROM admin WHERE adm_AT = admin_AT;
END IF;

END $
DELIMITER ;


CALL deleteadmin('Iwannhs','Dedoushs');
CALL deleteadmin('Panagiwths','Pappadopoulos');


#3.1.3.4 a)
DELIMITER $
CREATE PROCEDURE clientreservation(min_price INT(10), max_price INT(10))
BEGIN

SELECT lname, name
FROM reservation_offers
WHERE amount BETWEEN min_price AND max_price;

END $
DELIMITER ;

CALL clientreservation(150,180);

#3.1.3.4 b)
DELIMITER $
CREATE PROCEDURE lnamereservation(lname_par VARCHAR(50))
BEGIN


SELECT lname, name, off_id
FROM reservation_offers
WHERE lname = lname_par;

SELECT COUNT(*) AS clients_reserved_1
FROM reservation_offers
WHERE lname = lname_par AND off_id = 1;

SELECT COUNT(*) AS clients_reserved_2
FROM reservation_offers
WHERE lname = lname_par AND off_id = 2;

SELECT COUNT(*) AS clients_reserved_3
FROM reservation_offers
WHERE lname = lname_par AND off_id = 3;

END $
DELIMITER ;

CALL lnamereservation('Griffith');

#3.1.4.1 trip
DELIMITER $
CREATE TRIGGER tripinsert
AFTER INSERT ON trip
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'INSERT (trip)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER tripdelete
AFTER DELETE ON trip
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'DELETE (trip)', CURRENT_TIMESTAMP());

END $
DELIMITER ;


DELIMITER $
CREATE TRIGGER tripupdate
AFTER UPDATE ON trip
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'UPDATE (trip)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

SELECT* FROM trip;
SELECT* FROM log;

INSERT INTO trip 
VALUES (69, '2023-02-06T19:34:56', '2023-02-15T19:25:26', 55, 2045.56, 8, 'AB12344', 'AB12345');

DELETE FROM trip
WHERE tr_id = 69;

UPDATE trip
SET tr_maxseats = 56
WHERE tr_id = 58;

#3.1.4.1 reservation
DELIMITER $
CREATE TRIGGER reservationinsert
AFTER INSERT ON reservation
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'INSERT (reservation)', CURRENT_TIMESTAMP());

END $
DELIMITER ;



DELIMITER $
CREATE TRIGGER reservationdelete
AFTER DELETE ON reservation
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'DELETE (reservation)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER reservationupdate
AFTER UPDATE ON reservation
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'UPDATE (reservation)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

SELECT* FROM reservation;
SELECT* FROM log;

INSERT INTO reservation
VALUES (42, 26, 'Nikos', 'Kourkoulis', 'MINOR');

DELETE FROM reservation
WHERE res_lname = 'Kourkoulis';

UPDATE reservation
SET res_lname = 'Bourboulis'
WHERE res_lname = 'Kourkoulis';


#3.1.4.1 event

DELIMITER $
CREATE TRIGGER eventinsert
AFTER INSERT ON event
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'INSERT (event)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER eventdelete
AFTER DELETE ON event
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'DELETE (event)', CURRENT_TIMESTAMP());

END $
DELIMITER ;


DELIMITER $
CREATE TRIGGER eventupdate
AFTER UPDATE ON event
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'UPDATE (event)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

SELECT*  FROM event;
SELECT* FROM log;

INSERT INTO event
VALUES (58, '2023-02-08T16:23:12', '2023-02-15T14:23:12', 'Fun event');

DELETE FROM event
WHERE ev_tr_id = 58;

UPDATE event
SET ev_descr = 'Very Fun Event'
WHERE ev_descr = 'Fun event';


#3.1.4.1 travel_to

DELIMITER $
CREATE TRIGGER travelinsert
AFTER INSERT ON travel_to
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'INSERT (travel)', CURRENT_TIMESTAMP());

END $
DELIMITER ;


DELIMITER $
CREATE TRIGGER traveldelete
AFTER DELETE ON travel_to
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'DELETE (travel)', CURRENT_TIMESTAMP());

END $
DELIMITER ;


DELIMITER $
CREATE TRIGGER travelupdate
AFTER UPDATE ON travel_to
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'UPDATE (travel)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

SELECT* FROM travel_to;
SELECT* FROM log;

INSERT INTO travel_to
VALUES (47, 30, '2022-10-15T19:14:13', '2022-10-19T22:14:21');

UPDATE travel_to
SET to_dst_id = 31
WHERE to_tr_id = 47 AND to_dst_id = 30;

DELETE FROM travel_to
WHERE to_tr_id = 47 AND to_dst_id = 31;

#3.1.4.1 destination

DELIMITER $
CREATE TRIGGER destinationinsert
AFTER INSERT ON destination
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'INSERT (destination)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER destinationdelete
AFTER DELETE ON destination
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'DELETE (destination)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER destinationupdate
AFTER UPDATE ON destination
FOR EACH ROW
BEGIN
	
    INSERT INTO log
    VALUES(CURRENT_USER(), 'UPDATE (destination)', CURRENT_TIMESTAMP());

END $
DELIMITER ;

SELECT* FROM destination;
SELECT* FROM log;

INSERT INTO destination
VALUES (37, 'Mukwnos', 'Island of Greece', 'LOCAL', 'Greek', 2);

UPDATE destination
SET  dst_name = 'Corfu'
WHERE dst_id = 37;

DELETE FROM destination
WHERE dst_id = 37;


#3.1.4.2
DELIMITER $
CREATE TRIGGER nochangedate
BEFORE UPDATE ON trip
FOR EACH ROW
BEGIN
	DECLARE res_trip INT(10);
    
	SELECT res_tr_id
    INTO res_trip
    FROM reservation
    WHERE res_tr_id = NEW.tr_id
    LIMIT 1;
    
    IF res_trip = NEW.tr_id THEN
		SET NEW.tr_departure = OLD.tr_departure;
        SET NEW.tr_return = OLD.tr_return;
        SET NEW.tr_cost = OLD.tr_cost;
	END IF;
    
END $
DELIMITER ;

 



SELECT* FROM trip;
SELECT* FROM reservation;

UPDATE trip 
SET tr_departure = '2022-12-13T10:34:09'
WHERE tr_id = 1;

UPDATE trip 
SET tr_return = '2022-12-29T10:34:09'
WHERE tr_id = 1;

UPDATE trip 
SET tr_cost = 100.23
WHERE tr_id = 1;



#3.1.4.3
DELIMITER $
CREATE TRIGGER nolesssalary
BEFORE UPDATE ON worker
FOR EACH ROW
BEGIN
	IF (NEW.wrk_salary < OLD.wrk_salary) THEN
		SIGNAL SQLSTATE VALUE '45000'
        SET MESSAGE_TEXT = 'You cannot reduce the salary of a worker.';
	END IF;

END $
DELIMITER ;

UPDATE worker
SET wrk_salary = 10.32
WHERE wrk_AT = 'AB00000';







