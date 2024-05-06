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