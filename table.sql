create table Patient(
    patient_id integer,
    patient_name varchar(20) not null,
    blood_group varchar(4),
    disease varchar(20),
    patient_address varchar(20),
    patient_contact_no varchar(20),
    primary  key (patient_id)
);

create table Donar(
    donar_id integer,
    donar_name varchar(20) not null,
    blood_group varchar(4),
    donar_contact_no varchar(20),
    donar_address varchar(20),
    disease varchar(20),
    primary key (donar_id)
);

create table BloodBank(
    blood_bank_id integer,
    blood_bank_name varchar(20),
    blood_bank_address varchar(20),
    blood_bank_contact_no varchar(20),
    primary key (blood_bank_id)
);

create table Donate(
    donate_id integer,
    donar_id integer,
    date_of_donation date,
    blood_bank_id integer,
    flag integer default 1,
    primary key(donate_id),
    foreign key (donar_id) references Donar(donar_id),
    foreign key (blood_bank_id) references BloodBank(blood_bank_id)
);

create table Blood(
    b_code integer Primary key,
    b_group varchar2(5) not null,
    packets integer,
    donar_id integer references Donar(donar_id)
    blood_bank_id integer references BloodBank(blood_bank_id)
);

create table Donar_contactno(
    donar_id integer references Donar(donar_id),
    phone_no integer,
    telephone_no integer
);

create table Bloodbank_no(
    blood_bank_id integer references Bloodbank(blood_bank_id),
    telephone_no integer,
    reception_no integer
);



--INSERTING DATA IN TABLES    

insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1001,'PA','A+','N/A','Dhaka','01234');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1002,'PB','B+','N/A','Khulna','04234');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1003,'PC','A+','N/A','Khulna','01634');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1004,'PD','B+','N/A','Dhaka','01294');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1005,'PE','A+','N/A','Dhaka','01434');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1006,'PF','A+','N/A','Dhaka','01234');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1007,'PG','B+','N/A','Khulna','04234');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1008,'PH','A+','N/A','Khulna','01634');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1009,'PI','B+','N/A','Dhaka','01294');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1010,'PJ','A+','N/A','Dhaka','01434');



insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(101,'DA','A+','0134','Dhaka');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(102,'DB','A+','0134','Dhaka');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(103,'DC','B+','0134','Khulna');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(104,'DD','A+','0134','Khulna');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(105,'DE','B+','0134','Dhaka');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(106,'DF','A+','0134','Chittagong');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(107,'DG','A+','0134','Dhaka');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(108,'DH','B+','0134','Khulna');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(109,'DI','A+','0134','Chittagong');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(110,'DJ','B+','0134','Dhaka');



insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(1,'BBA','Dhaka','911');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(2,'BBB','Khulna','912');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(3,'BBC','Dhaka','913');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(4,'BBD','Khulna','914');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(5,'BBE','Dhaka','915');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(6,'BBF','Khulna','916');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(7,'BBG','Dhaka','917');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(8,'BBH','Khulna','918');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(9,'BBI','Dhaka','919');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(10,'BBJ','Khulna','920');



insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10001,101,TO_DATE('28/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10002,104,TO_DATE('27/02/2018', 'DD/MM/YYYY'),2);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10003,102,TO_DATE('26/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10004,106,TO_DATE('25/04/2018', 'DD/MM/YYYY'),2);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10005,105,TO_DATE('24/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10006,106,TO_DATE('28/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10007,107,TO_DATE('27/02/2018', 'DD/MM/YYYY'),2);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10008,108,TO_DATE('26/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10009,109,TO_DATE('25/02/2018', 'DD/MM/YYYY'),2);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10010,110,TO_DATE('24/02/2018', 'DD/MM/YYYY'),1);



INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (1, 'A+', 1, 101, 1);
INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (2, 'A+', 1, 102, 1);
INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (3, 'B+', 1, 103, 2);
INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (4, 'A+', 1, 104, 2);
INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (5, 'B+', 1, 105, 1);
INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (6, 'A+', 1, 106, 3);
INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (7, 'A+', 1, 107, 1);
INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (8, 'B+', 1, 108, 2);
INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (9, 'A+', 1, 109, 3);
INSERT INTO Blood (b_code, b_group, packets, donar_id, blood_bank_id) VALUES (10, 'B+', 1, 110, 1);


INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (101, 0134, NULL);
INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (102, 0134, NULL);
INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (103, 0134, NULL);
INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (104, 0134, NULL);
INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (105, 0134, NULL);
INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (106, 0134, NULL);
INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (107, 0134, NULL);
INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (108, 0134, NULL);
INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (109, 0134, NULL);
INSERT INTO Donar_contactno (donar_id, phone_no, telephone_no) VALUES (110, 0134, NULL);

INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (1, 911, NULL);
INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (2, 912, NULL);
INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (3, 913, NULL);
INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (4, 914, NULL);
INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (5, 915, NULL);
INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (6, 916, NULL);
INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (7, 917, NULL);
INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (8, 918, NULL);
INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (9, 919, NULL);
INSERT INTO Bloodbank_no (blood_bank_id, telephone_no, reception_no) VALUES (10, 920, NULL);
