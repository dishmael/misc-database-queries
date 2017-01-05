use lab;
drop view Availability;
drop view Utilization;
drop table LDOMS;
drop table Blades;
drop table Chassis;
drop table Status;
#--
#-- Create the Status table
#--
create table Status (
	ID int not null auto_increment,
	Name varchar(16) not null,
	primary key(ID)
);
#--
#-- Create the Chassis table
#--
create table Chassis (
	ID int not null,
	Name varchar(10) not null,
	Address varchar(16) not null,
	Status int not null,
	primary key(ID),
	foreign key(Status) references Status(ID)
);
#--
#-- Create the Blades table
#--
create table Blades (
	ID int not null auto_increment,
	Chassis int not null,
	Blade int not null,
	Name varchar(10) not null,
	Address varchar(16) not null,
	CPU int not null,
	Threads int not null,
	Memory int not null,
	Storage int not null,
	SAN enum('N','Y') default 'Y' not null,
	Status int not null,
	primary key(ID),
	foreign key(Status) references Status(ID),
	foreign key(Chassis) references Chassis(ID) on delete cascade
);
#--
#-- Create the LDOMs table
#--
create table LDOMS (
	ID int not null auto_increment,
	Name varchar(16) not null,
	Description varchar(128) not null,
	Address varchar(16) not null,
	Blade int not null,
	CPU int not null,
	Threads int not null,
	Memory int not null,
	Storage int not null,
	Requestor varchar(64),
	Requested date,
	Provisioned date,
	Decomission date,
	Status int not null,
	primary key(ID),
	foreign key(Status) references Status(ID),
	foreign key(Blade) references Blades(ID) on delete cascade
);
#--
#-- Insert Status entries
#--
insert into Status (Name) values ('Active');
insert into Status (Name) values ('Bound');
insert into Status (Name) values ('Damaged');
insert into Status (Name) values ('Inactive');
insert into Status (Name) values ('Unknown');
#--
#-- Insert the two Chassis
#--
insert into Chassis (ID, Name, Address, Status) values (0, 'Chassis-0', '10.10.5.6', 1);
insert into Chassis (ID, Name, Address, Status) values (1, 'Chassis-1', '10.10.5.7', 1);
#--
#-- Insert CH0-BL0 through CH0-BL9
#--
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 0, 'Blade-0', '10.10.5.10', 16, 128, 32768, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 1, 'Blade-1', '10.10.5.11', 16, 128, 32768, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 2, 'Blade-2', '10.10.5.12', 16, 128, 32768, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 3, 'Blade-3', '10.10.5.13', 16, 128, 32768, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 4, 'Blade-4', '10.10.5.14', 16, 128, 32768, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 5, 'Blade-5', '10.10.5.15', 16, 128, 32768, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 6, 'Blade-6', '10.10.5.16', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 7, 'Blade-7', '10.10.5.17', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 8, 'Blade-8', '10.10.5.18', 8, 64, 16384, 500, 'N', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (0, 9, 'Blade-9', '10.10.5.19', 8, 64, 16384, 500, 'N', 1);
#--
#-- Insert CH1-BL0 through CH1-BL9
#--
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 0, 'Blade-0', '10.10.5.20', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 1, 'Blade-1', '10.10.5.21', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 2, 'Blade-2', '10.10.5.22', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 3, 'Blade-3', '10.10.5.23', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 4, 'Blade-4', '10.10.5.24', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 5, 'Blade-5', '10.10.5.25', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 6, 'Blade-6', '10.10.5.26', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 7, 'Blade-7', '10.10.5.27', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 8, 'Blade-8', '10.10.5.28', 8, 64, 16384, 500, 'Y', 1);
insert into Blades 
	(Chassis, Blade, Name, Address, CPU, Threads, Memory, Storage, san, Status)
	values (1, 9, 'Blade-9', '10.10.5.29', 8, 64, 16384, 500, 'N', 1);
#--
#-- LDOMs for CH0-BL0
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.100', 1, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH0-BL1
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.101', 2, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH0-BL2
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.102', 3, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH0-BL3
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.103', 4, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH0-BL4
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.104', 5, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH0-BL5
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.105', 6, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH0-BL6
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.106', 7, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH0-BL7
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.107', 8, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH0-BL8
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.108', 9, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH0-BL9
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.109', 10, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH1-BL0
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.110', 11, 2, 16, 4096, 0, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('legacy-BEM1', '', '', 11, 2, 16, 4096, 100, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('nnm', 'Network Node Manager', '10.10.5.54', 11, 2, 16, 4096, 100, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('syslog_pri', 'DNS, Syslog, Trapd, NTP', '10.10.5.33', 11, 2, 16, 4096, 100, 1);
#--
#-- LDOMs for CH1-BL1
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.111', 12, 2, 16, 4096, 0, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('bpm', '', '10.10.5.51', 12, 2, 16, 4096, 100, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('legacy-BEM2', '', '', 12, 2, 16, 4096, 100, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('syslog_bak', 'DNS, Syslog, Trapd, NTP', '10.10.5.39', 12, 2, 16, 4096, 100, 1);
#--
#-- LDOMs for CH1-BL2
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.112', 13, 2, 16, 4096, 0, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('datastore', '', '10.10.5.45', 13, 2, 16, 4096, 300, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('sim2', '', '10.10.5.53', 13, 2, 16, 4096, 100, 1);
#--
#-- LDOMs for CH1-BL3
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.113', 14, 2, 16, 4096, 0, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('eHealth', 'eHealth', '10.10.5.36', 14, 2, 16, 4096, 300, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('sim1', '', '10.10.5.52', 14, 2, 16, 4096, 100, 1);
#--
#-- LDOMs for CH1-BL4
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.114', 15, 2, 16, 4096, 0, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('bem1', '', '10.10.5.42', 15, 2, 16, 4096, 100, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('ciscoworks', 'Cisco Works', '10.10.5.30', 15, 2, 16, 4096, 100, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('jumpstart', 'Jumpstart Server', '', 15, 2, 16, 4096, 100, 1);
#--
#-- LDOMs for CH1-BL5
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.115', 16, 2, 16, 4096, 0, 1);
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('bem2', '', '10.10.5.45', 16, 2, 16, 4096, 100, 1);
#--
#-- LDOMs for CH1-BL6
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.116', 17, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH1-BL7
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.117', 18, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH1-BL8
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.118', 19, 2, 16, 4096, 0, 1);
#--
#-- LDOMs for CH1-BL9
#--
insert into LDOMS (Name, Description, Address, Blade, CPU, Threads, Memory, Storage, Status)
	values ('primary', '', '10.10.5.119', 20, 2, 16, 4096, 0, 1);
#--
#-- Create Availability view
#--
CREATE VIEW Availability AS SELECT
  CONCAT('CH',Chassis.ID,'-BL',Blades.Blade) AS ID,
  Chassis.ID AS Chassis,
  Blades.ID AS Blade,
  Blades.CPU - SUM(LDOMS.CPU) AS CPU,
  Blades.Threads - SUM(LDOMS.Threads) AS Threads,
  Blades.Memory - SUM(LDOMS.Memory) AS Memory,
  Blades.Storage - SUM(LDOMS.Storage) AS Storage
FROM
  LDOMS left join Blades on
    LDOMS.Blade = Blades.ID left join Chassis on
    Blades.Chassis = Chassis.ID
GROUP BY
  Chassis.Name, Blades.Name;
#--
#-- Create Utilization view
#--
CREATE VIEW Utilization AS SELECT
  CONCAT('CH',Chassis.ID,'-BL',Blades.Blade) AS ID,
  Chassis.ID AS Chassis,
  Blades.ID AS Blade,
  CAST((100 * (SUM(LDOMS.CPU) / Blades.CPU)) as unsigned) AS CPU,
  CAST((100 * (SUM(LDOMS.Threads) / Blades.Threads)) as unsigned) AS Threads,
  CAST((100 * (SUM(LDOMS.Memory) / Blades.Memory)) as unsigned) AS Memory,
  CAST((100 * (SUM(LDOMS.Storage) / Blades.Storage)) as unsigned) AS Storage
FROM
  LDOMS left join Blades on
    LDOMS.Blade = Blades.ID left join Chassis on
    Blades.Chassis = Chassis.ID
GROUP BY
  Chassis.Name, Blades.Name;
