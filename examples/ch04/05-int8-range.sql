-- @expect-error
select vector('[1.6, -2.4, 300]', 3, int8) from dual;
