/** Hash value created by query plan is case sensitive
    -> use bind variable for match more cache for query plan 
    it's can be use to procedure too 
*/
select avg(salary) from employees where department_id = 30;
select avg(salary) from employees where department_id = 40;
select avg(salary) from employees where department_id = 50;
 
select sql_id,executions,parse_calls,first_load_time,last_load_time,sql_text from v$sql
where sql_text like '%avg(salary) from employees%'
order by first_load_time desc;
 
select avg(salary) from employees where department_id = :b;
 

/*auto create bind variable in procedure cursors */
declare
 v_dept_id number(2);
 v_count number(2);
begin
    for r1 in (select department_id from departments) loop
        select count(*) into v_count from employees where department_id = v_dept_id;
    end loop;
end;
/

/** BAD WRITING -> execute new query all the time */
declare
      type c1 is ref cursor;
      r1 c1;
      l_temp all_objects.object_name%type;
  begin
      for i in 1 .. 1000
      loop
          open r1 for
          'select object_name from all_objects where object_id = ' || i;
          fetch r1 into l_temp;
          close r1;
      end loop;
  end;
/

/*using bind variable for improve above query */
declare
      type c1 is ref cursor;
      r1 c1;
      l_temp all_objects.object_name%type;
  begin
      for i in 1 .. 1000
      loop
          open r1 for
          'select object_name from all_objects where object_id = :x' using i;
          fetch r1 into l_temp;
          close r1;
      end loop;
end;
/

/* the best way to write it */
declare
      l_temp all_objects.object_name%type;
  begin
      for r1 in (select object_name from all_objects where object_id < 1001) loop
        l_temp := r1.object_name;
      end loop;
  end;