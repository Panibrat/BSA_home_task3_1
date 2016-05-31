-- �������� ������ ������� ������� ���� ������������� � �������� �� 20 ��� � ����������� ���� ����� 5
select
  users_books.user_id,
  users.age,
  count(users_books.book_id) as book_count
from
  users left join users_books on users.id = users_books.user_id
where
  users.age >= 20
group by users.id
having count(users_books.book_id) > 5;
 
 
-- �������� ������ ������� ������� ������������� � ����� ������� ������������ ����� 3
select
  first_name,
  last_name
from
  users
where
  first_name like '%3%'
  or last_name like '%3%';
 
 
-- �������� ������ ������� ������� ������ ������������� ������� �� ����� ����� � ������ "Book #21"
select id
from users
where id not in (
  select user_id
  from users_books inner join books on books.id = users_books.book_id
  where books.title = "Book #21"
);
 
 
-- �������� ������ ������� ������� ���� is_active � ������� users;
alter table users add column is_active bool not null default false;
 
 
-- �������� ������, ������� ��������� is_active = 1 ��� �������������, ������� ����� ��� ������� ���� �����
update
  users
set
  is_active = true
where
  users.id in (select distinct users_books.user_id from users_books);
 
 
-- �������� ������ ������� ������� ���� isbestseller (bool) � ������� books
alter table books add column isbestseller bool not null default false;
 
 
-- �������� ������ ������� �������� isbestseller = 1 ��� ����, ������� ���� ����� �������������� ����� 10 ���
update
  books
set
  isbestseller = true
where
  books.id in (select book_id from users_books group by book_id having count(user_id) > 10);