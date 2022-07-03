create table app_user
(
    id            bigint not null
        primary key,
    username      text,
    hash_password text,
    active        boolean,
    enable        boolean,
    role          text,
    rating        bigint,
    road_maps     bigint,
    resturants    bigint,
    comments      bigint
);

alter table app_user
    owner to postgres;

create table comment
(
    id      bigint not null
        primary key,
    content text,
    user_id bigint
        constraint user_fkey
            references app_user
);

alter table comment
    owner to postgres;

create table restaurant
(
    id      bigint not null
        primary key,
    name    text,
    country text,
    city    text,
    type    text,
    rating  bigint,
    user_id bigint
        constraint user_fkey
            references app_user
);

alter table restaurant
    owner to postgres;

create table road_map
(
    id      bigint not null
        primary key,
    name    text,
    user_id bigint
        constraint user_fkey
            references app_user
);

alter table road_map
    owner to postgres;

create table road_map_restaurant
(
    restaurant_id bigint
        constraint restaurant_fkey
            references restaurant,
    road_map_id   bigint
        constraint road_map_fkey
            references road_map,
    id            bigint not null
        primary key
);

alter table road_map_restaurant
    owner to postgres;


