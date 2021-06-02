#--------------
#Create Schema
#--------------
CREATE SCHEMA IF NOT EXISTS Football_League;
USE Football_League;

#--------------
#Create Tables
#--------------
CREATE TABLE IF NOT EXISTS Person
( CNIC VARCHAR(15) NOT NULL,
  First_Name VARCHAR(45) NOT NULL,
  Last_Name VARCHAR(45) NOT NULL,
  Phone_Number VARCHAR(15) NOT NULL,
  Age INT NOT NULL,
  PRIMARY KEY (CNIC));

CREATE TABLE IF NOT EXISTS Team 
( Team_Serial INT NOT NULL,
  Team_Name VARCHAR(45) NOT NULL,
  Wins INT NULL,
  Losses INT NULL,
  Draws INT NULL,
  Points INT NULL,
  Captain_CNIC VARCHAR(15) NULL,
  Registration_Fee INT NULL,
  PRIMARY KEY (Team_Serial));
  
CREATE TABLE IF NOT EXISTS Venue
( Venue_Serial INT NOT NULL,
  Venue_Name VARCHAR(30) NULL,
  Location VARCHAR(50) NULL,
  PRIMARY KEY (Venue_Serial));

CREATE TABLE IF NOT EXISTS Ball 
( Ball_Serial INT NOT NULL,
  Brand VARCHAR(45) NULL,
  Price INT NOT NULL,
  PRIMARY KEY (Ball_Serial));

CREATE TABLE IF NOT EXISTS Game 
( Game_Serial INT NOT NULL,
  Venue INT NULL,
  Team_A INT NULL,
  Team_B INT NULL,
  Match_Day DATE NULL,
  Match_Time TIME NULL,
  Result VARCHAR(45) NULL,
  Ball INT NULL,
  Referee VARCHAR(15) NULL,
  PRIMARY KEY (Game_Serial));

CREATE TABLE IF NOT EXISTS Referee 
( CNIC VARCHAR(15), 
  Salary INT NULL,
  Experience INT NULL,
  PRIMARY KEY (CNIC));

CREATE TABLE IF NOT EXISTS Player
( CNIC VARCHAR(15),
  Team INT NULL,
  Playing_Position VARCHAR(45) NULL,
  Goals_or_CleanSheets INT NULL,
  YellowCards INT NULL,
  RedCards INT NULL,
  Specialty VARCHAR(45) NULL,
  PRIMARY KEY (CNIC));

CREATE TABLE IF NOT EXISTS Goal 
( Goal_Serial INT NOT NULL,
  Scored_In_Match INT NULL,
  Scored_By_Player VARCHAR(15) NULL,
  Goal_Time INT NULL,
  PRIMARY KEY (Goal_Serial));

#---------------------------
#Add Foreign key constraints
#---------------------------
ALTER TABLE Team
 ADD FOREIGN KEY (Captain_CNIC) REFERENCES Person(CNIC); 

ALTER TABLE Game
 ADD FOREIGN KEY (Team_A) REFERENCES Team(Team_Serial),
 ADD FOREIGN KEY (Team_B) REFERENCES Team(Team_Serial),
 ADD FOREIGN KEY (Venue) REFERENCES Venue(Venue_Serial),
 ADD FOREIGN KEY (Ball) REFERENCES Ball(Ball_Serial),
 ADD FOREIGN KEY (Referee) REFERENCES Person(CNIC);

ALTER TABLE Player
 ADD FOREIGN KEY (Team) REFERENCES Team(Team_Serial);
  
ALTER TABLE Goal
 ADD FOREIGN KEY (Scored_In_Match) REFERENCES Game(Game_Serial),
 ADD FOREIGN KEY (Scored_By_Player) REFERENCES Person(CNIC);
 
ALTER TABLE Referee
 ADD FOREIGN KEY (CNIC) REFERENCES Person(CNIC) on delete cascade on update cascade;
 
ALTER TABLE Player
 ADD FOREIGN KEY (CNIC) REFERENCES Person(CNIC) on delete cascade on update cascade;

#---------------------------
#Create Triggers
#---------------------------
create trigger goal_scored
after insert on goal
for each row
update Player
set Goals_or_CleanSheets=Goals_or_CleanSheets+1
where CNIC=New.Scored_By_Player;
 
#---------------------------
#Insert Rows
#---------------------------
INSERT INTO Person
VALUES 
('3740574847264', 'Dave', 'Anderson', '03009754864', 30), ('654874847264', 'David', 'Miller', '03029754564', 31),
('3512748474565', 'Brad', 'Johnathan', '03339875864', 27), ('3625874898541', 'Carl', 'Jones', '03129752587', 20),
('4581276589264', 'Utah', 'Johnson', '03425865264', 20), ('4521596562322', 'Yonah', 'Wendy', '03118545234', 18),
('3746574512589', 'Omar', 'Rashid', '03009755412', 21), ('3620544226399', 'David', 'Ponds', '03426895562', 19),
('3736265235841', 'Del', 'Ali', '03009765895', 17), ('3740574544452', 'Edgar', 'Davids', '03009459588', 18),
('3740584844544', 'Oberton', 'Moths', '03009655566', 21), ('6115474847264', 'Dave', 'Lamins', '03428754864', 20),
('3722564845455', 'John', 'Tempa', '03326664864', 22), ('3987574845523', 'Terae', 'Benjani', '03425654898', 17),
('3740574865623', 'Aron', 'Cantona', '03015747548', 20), ('3740596565523', 'Pitt', 'Drazer', '03009665864', 23),
('3755220847264', 'Johnathan', 'Shearer', '03006632364', 21), ('3740885547264', 'David', 'Franks', '03219885464', 20),
('3784574848745', 'Frank', 'Holmes', '03016722014', 18), ('3740987445555', 'Aora', 'Watson', '03215754844', 18),
('3740566554264', 'Bert', 'Thomas', '03118485864', 19), ('3740987110236', 'Aaron', 'Washi', '03116594844', 20),
('37406564411023', 'Ponds', 'Wembley', '03206581120', 23), ('7845587445521', 'Ross', 'Jamie', '03335855844', 18),
('3362587449562', 'Raquel', 'Adams', '03226352152', 20), ('3740982655002', 'Aora', 'Buffay', '03125165696', 20),
('3740987521554', 'Adam', 'Jordan', '03218765325', 18), ('3745987659856', 'Carl', 'Bing', '03215652314', 24),
('3766387400215', 'Broth', 'Warner', '03216630204', 22), ('3540987023695', 'Youth', 'Piras', '03220154844', 22),
('3740001445215', 'Zach', 'King', '03215524854', 17), ('3740981205965', 'John', 'Roberts', '03215363201', 18),
('37409411545965', 'Damon', 'Zinger', '03232156844', 22), ('3741189665855', 'Leonard', 'Hofstader', '03112032844', 20),
('3745897400235', 'Purr', 'Ian', '03215001214', 20), ('3740987445658', 'George', 'Best', '03212154822', 18),
('3740987446550', 'Ian', 'Norman', '03215758545', 17), ('3740987110205', 'Amazon', 'Wright', '03215721214', 19),
('3740981125645', 'Robert', 'Pires', '03154758878', 22), ('3740912125574', 'Aora', 'Busby', '03211544888', 21),
('3458987400125', 'Hugh', 'Tower', '03024154822', 21), ('3450021440125', 'Hulk', 'Romano', '03112154822', 20),
('3458987965875', 'Yoda', 'Law', '03115854542', 18);

INSERT INTO Team
VALUES 
(1, 'Saints', 1, 2, 0, 3, '3625874898541', 3500),
(2, 'Ravens', 0, 1, 1, 1, '3755220847264', 3500),
(3, 'Lycans', 1, 1, 0, 3, '3740982655002', 3500),
(4, 'Gladiators', 1, 0, 2, 5, '3540987023695', 3500),
(5, 'SPFC', 1, 0, 1, 4, '3740987445658', 3500);

INSERT INTO Player
VALUES
('3625874898541', 1, 'Forward', 0, 0, 0, 'Poacher'), ('4581276589264', 1, 'Forward', 0, 0, 0, 'Tactician'),
('4521596562322', 1, 'Forward', 0, 0, 0, 'Speedster'), ('3746574512589', 1, 'Defence', 0, 0, 0, 'Long Shots'),
('3620544226399', 1, 'Defence', 0, 0, 0, 'Aerial Threat'), ('3736265235841', 1, 'Keeper', 0, 0, 0, 'Acrobat'),
('3740574544452', 1, 'Defence', 0, 0, 0, 'Engine'), ('3740584844544', 1, 'Keeper', 0, 0, 0, 'Shot Stopper'),
('6115474847264', 2, 'Forward', 0, 0, 0, 'Dribbling'), ('3722564845455', 2, 'Forward', 0, 0, 0, 'Nutmegs'),
('3987574845523', 2, 'Forward', 0, 0, 0, 'Headers'), ('3740574865623', 2, 'Defence', 0, 0, 0, 'Passing'),
('3740596565523', 2, 'Defence', 0, 0, 0, 'Tackling'), ('3755220847264', 2, 'Keeper', 0, 0, 0, 'Agility'),
('3740885547264', 2, 'Defence', 0, 0, 0, 'Strength'), ('3784574848745', 2, 'Keeper', 0, 0, 0, 'Composure'),
('3740987445555', 3, 'Forward', 0, 0, 0, 'Agility'), ('3740566554264', 3, 'Forward', 0, 0, 0, 'Finishing'),
('3740987110236', 3, 'Forward', 0, 0, 0, 'Speedster'), ('37406564411023', 3, 'Defence', 0, 0, 0, 'Man Marking'),
('7845587445521', 3, 'Defence', 0, 0, 0, 'Aerial Threat'), ('3362587449562', 3, 'Keeper', 0, 0, 0, 'Shot Stopper'),
('3740982655002', 3, 'Defence', 0, 0, 0, 'Sliding Tackle'), ('3740987521554', 3, 'Keeper', 0, 0, 0, 'Positioning'),
('3745987659856', 4, 'Forward', 0, 0, 0, 'Free Kicks'), ('3766387400215', 4, 'Forward', 0, 0, 0, 'Positioning'),
('3540987023695', 4, 'Forward', 0, 0, 0, 'Long Shots'), ('3740001445215', 4, 'Defence', 0, 0, 0, 'Tactician'),
('3740981205965', 4, 'Defence', 0, 0, 0, 'Strength'), ('37409411545965', 4, 'Keeper', 0, 0, 0, 'Shot Stopper'),
('3741189665855', 4, 'Defence', 0, 0, 0, 'Speedster'), ('3745897400235', 4, 'Keeper', 0, 0, 0, 'Aerial Threat'),
('3740987445658', 5, 'Forward', 0, 0, 0, 'Play Maker'), ('3740987446550', 5, 'Forward', 0, 0, 0, 'Speedster'),
('3740987110205', 5, 'Forward', 0, 0, 0, 'Finishing'), ('3740981125645', 5, 'Defence', 0, 0, 0, 'Positioning'),
('3740912125574', 5, 'Defence', 0, 0, 0, 'Long Shots'), ('3458987400125', 5, 'Keeper', 0, 0, 0, 'Agility'),
('3450021440125', 5, 'Defence', 0, 0, 0, 'Strength'), ('3458987965875', 5, 'Keeper', 0, 0, 0, 'Positioning');

INSERT INTO Referee
VALUES 
('3740574847264', 1000, 36), 
('654874847264', 1500, 24), 
('3512748474565', 800, 42);

INSERT INTO BALL
VALUES 
(1, 'Adidas', 1100),(2, 'Adidas', 800),(3, 'Nike', 1200),
(4, 'Puma', 750),(5, 'PUMA', 850),(6, 'Adidas', 900),(7, 'Nike', 800),
(8, 'Nike', 1000),(9, 'Puma', 500),(10, 'Mitre', 850);

INSERT INTO Venue
VALUES 
(1, 'Total Football', 'Chak Shahzad, Islamabad'),
(2, 'Total Football', 'Ayub Park, Rawalpindi'),
(3, 'High Velocity', 'Sector E-11, Islamabad'),
(4, 'ICAS', 'Sector G-11, Islamabad');

INSERT INTO Game
VALUES 
(1, 1, 1, 2, '2017-6-5', '17:00:00', '1-0', 1, '3740574847264'),
(2, 2, 3, 4, '2017-6-5', '18:00:00', '0-2', 1, '3740574847264'),
(3, 1, 1, 5, '2017-6-6', '17:00:00', '0-1', 2, '654874847264'),
(4, 3, 2, 4, '2017-6-6', '18:00:00', '2-2', 2, '654874847264'),
(5, 4, 3, 1, '2017-6-7', '17:00:00', '1-0', 3, '3512748474565'),
(6, 1, 4, 5, '2017-6-7', '18:00:00', '0-0', 3, '3512748474565'),
(7, 4, 2, 3, '2017-6-8', '17:00:00', NULL, 5, '3740574847264'),
(8, 1, 3, 5, '2017-6-8', '18:00:00', NULL, 5, '3740574847264'),
(9, 3, 1, 4, '2017-6-9', '17:00:00', NULL, 8, '654874847264'),
(10, 2, 2, 5, '2017-6-9', '18:00:00', NULL, 8, '654874847264');

INSERT INTO Goal
VALUES 
(1, 1, '3625874898541', 10),
(2, 2, '3745987659856', 12),
(3, 2, '3540987023695', 5),
(4, 3, '3740987110205', 29),
(5, 4, '3987574845523', 11),
(6, 4, '3766387400215', 4),
(7, 4, '3987574845523', 25),
(8, 4, '3540987023695', 30),
(9, 5, '3740566554264', 1);

#---------------------------
#Create Queries
#---------------------------
#Query to know who is at the top
select Team.Team_Name
from Team
where Points=(select max(points) from team);

#Query to display table small
select Team_Name, Points
from Team
order by points desc;

#Query to display full table
select Team_Name Team, Wins W, Losses L, Draws D, Points Pts
from Team
order by points desc;

#Query to get all info on a team
select *
from Team
where Team_Name='Saints';

#Query to get all info on a Player
select *
from Person, Player
where Person.First_Name='Youth' and Person.CNIC=Player.CNIC;

#Query to get info on all matches on a particular date
select t1.Team_Name Team_A, t2.Team_Name Team_B, Match_Time Time, Result, p.Last_Name Referee, v.Venue_Name Venue   
from Game as g, Person as p, Team as t1, Team as t2, Venue as v
where Match_Day='2017-6-7' and referee=p.CNIC and Team_A=t1.Team_Serial and Team_B=t2.Team_Serial and Venue=v.Venue_Serial;

#Query to get the Top Scorer
select Person.First_Name First_Name, Person.Last_Name Last_Name, Goals_or_CleanSheets Goals
from Person, Player
where Player.CNIC=Person.CNIC and Player.Goals_or_CleanSheets=(select max(Goals_or_CleanSheets) from Player);

#Query to delete person also deletes player
delete from person
where CNIC='3625874898541';

select *
from person
where cnic='3625874898541';

#Query to update first name in person also updates it in player
select first_name
from person
where cnic='3746574512589';

update person
set cnic='Hi there!'
where cnic='3746574512589';

select *
from player
where cnic='Karla';