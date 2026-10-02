-- @expect-error
select vector('[1, 2, 3]') * 2 from dual;

select vector('[3, 4, 0]') / vector('[1, 2, 1]') from dual;
