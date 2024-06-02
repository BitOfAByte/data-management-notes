CREATE TABLE persons
(
    id          SERIAL PRIMARY KEY,
    name        varchar,
    email       varchar,
    street_name varchar,
    zip         int,
    city        varchar
);

create table newsletters
(
    id                  serial PRIMARY KEY,
    delivery_preference varchar,
    type                varchar
);

create table subscribes_to
(
    id         serial primary key,
    person     int references persons (id),
    newsletter int references newsletters (id)
);

create table rental_boats
(
    number int primary key,
    price  int,
    type   varchar
);

create table rents_boat
(
    id     serial primary key,
    boat   int references rental_boats (number),
    person int references persons (id)
);


create table employees
(
    id       serial primary key,
    person   int references persons (id),
    password varchar
);

create table members
(
    id           serial primary key,
    person       int references persons (id),
    member_id    int,
    phone_number int,
    password     varchar
);

create table event
(
    id          serial unique,
    member      int references members (id),
    time        timestamp,
    name        varchar,
    description varchar,
    picture     varchar,
    primary key (id, member)
);

create table registered_for
(
    id     serial primary key,
    member int references members (id),
    event  int references event (id)
);

create table helps_at
(
    id     serial primary key,
    member int references members (id),
    event  int references event (id)
);

create table boat_space
(
    number int primary key,
    price  int,
    member int references members (id)
);
