-- ОПЕРАТОРЫ DDL

create schema myFirstSchema;

create table myFirstSchema.myFirstTable
(                                            -- Лучше всего создавать таблицу через точку, указывая схему (контекст)
    id          serial primary key,          -- serial - это int, который последовательно увеличивается на 1
    -- если мы id указываем, то он сохранится, если не указываем, то будет взят из сикуэнс (см modify id column)
    name        varchar(15) not null unique, -- varchar - это строковый тип. 15 - максимальная длина строки,
    -- not null unique - соответствующие ограничения не нал и уникальное название
    description varchar(100)
);

alter table myFirstSchema.myFirstTable -- внести изменения в таблицу
    add column discord_chanel_name varchar(10) not null; -- в случае, если уже есть записи, то будет ошибка

alter table myFirstSchema.myFirstTable
    alter column discord_chanel_name drop not null; -- решили удалить констрейнт нот нал

alter table myFirstSchema.myFirstTable
    alter column discord_chanel_name TYPE varchar(30);

--добавление, выбор и обновление данных в записи (ОПЕРАТОРЫ DML)

--добавление данных в запись
insert into myFirstSchema.myFirstTable
values (1, 'java developing',
        'course about programming by java and java environment',
        'java chanel');

-- обновление данных в записи
update myFirstSchema.myFirstTable
set id = 1000
where id = 1;
-- без оператора where будет пытаться применить ко всем записям

-- здесь id добавится из сикуанс (причем т.к. уже было id = 1, будет использовано id = 2, но если id не обновить до 1000,
-- то будет ошибка! т.к. почему-то тупая база берет из сикуанс id = 1).
-- данный способ вставки значений с указанием полей является более предпочтительным и безопасным, т.к. в случае
-- добавления и или удаления колонок значения будут правильно располагаться в таблице. В предыдущем примере может
-- быть нарушен данный порядок.
insert into myFirstSchema.myFirstTable (name, description, discord_chanel_name)
values ('piton',
        'course about programming by piton and piton environment',
        'piton ch');

insert into myFirstSchema.myFirstTable (name, description, discord_chanel_name)
values ('js',
        'course about programming by js and js environment',
        'js ch');

insert into myFirstSchema.myFirstTable (name, description, discord_chanel_name)
values ('C',
        'course about programming by C and C environment',
        'C ch');

delete
from myFirstSchema.myFirstTable
where id = 2;

-- ВЫБОР

select *
from myFirstSchema.myFirstTable; -- * - это выбор всех столбцов

select *
from myFirstSchema.myFirstTable
where id > 3
order by id;

select id, name -- выполняется 3ым
from myFirstSchema.myFirstTable -- выполняется 1ым
where id >= 2 -- выполняется 2ым в целях оптимизации дальнейших обработок
order by id DESC;
-- выполняется 4им -- сортировка в обратном порядке

-- таблица с внешним ключом
create table myFirstSchema.depending_table
(
    id        int references myFirstSchema.myFirstTable (id) not null,
    user_name varchar(255)                                   not null
);

insert into myFirstSchema.depending_table (id, user_name)
values (4, 'Vasiliy');

alter table myFirstSchema.myFirstTable
    drop constraint myfirsttable_pkey;

drop table myFirstSchema.myFirstTable;

drop schema myFirstSchema;