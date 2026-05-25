-- used for in-class activity 05

drop schema if exists books2 cascade;
create schema if not exists books2;

create table if not exists books2.authors (
	id			int primary key
	, author	varchar(50)
);

create table if not exists books2.books (
	id			int primary key
	, title		varchar(50)
	, author_id	int references books2.authors(id) deferrable
);

create table if not exists books2.editions (
	id			int primary key
	, edition	varchar(50)
	, book_id	int references books2.books(id) deferrable
);

insert into books2.authors values
	(1, 'J. K. Rowling')
	, (2, 'J. R. R. Tolkien')
	, (3, 'Jesse Chaney')
	, (4, 'Kevin McGrath')
;

insert into books2.books values
	(1, 'The Fellowship of the Ring', 2)
	, (2, 'The Two Towers', 2)
	, (3, 'The Return of the King', null)
	, (4, 'Philosopher''s Stone', 1)
	, (5, 'Chamber of Secrets', 1)
	, (6, 'Prisoner of Azkabang', null)
	, (7, 'Goblet of Fire', null)
;

insert into books2.editions values 
	(1, 'English', 1)
	, (2, 'Spanish', 1)
	, (3, 'Hindi', 1)
	, (4, 'English', 2)
	, (5, 'Hindi', 2)
	, (6, 'English', 3)
	, (7, 'Hindi', 3)
	, (8, 'English', 7)
;
