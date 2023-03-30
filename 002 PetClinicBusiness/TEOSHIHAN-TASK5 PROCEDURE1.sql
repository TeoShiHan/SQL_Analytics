-- This query is to allocate the staff to new time slot like from monday-wed to wednesday-friday
-- It also can create new slot into the database if it is allowed to


-- calculate empty slot quantity based on latest job slot assignment
create or replace function get_emp_qty_in_slot(
    in_start_day    number,
    in_end_day      number,
    in_start_time   varchar2,
    in_end_time     varchar2,
    work_type       varchar2
)
return number
is
    v_slot_emp_qty number(4);
begin
    select
        count(lA.employee_id)
    into 
        v_slot_emp_qty    
    from 
        latestAssignment lA, employee e, position pos
    where
        starting_weekday = in_start_day and
        ending_weekday = in_end_day     and
        to_char(starting_time,'sssss') = 
        to_char(
            to_date(in_start_time,'hh24:mi'),'sssss')
        and
        to_char(ending_time,'sssss') = 
        to_char(
            to_date(in_end_time,'hh24:mi'),'sssss')
        and 
        e.position_id = pos.position_id and
        pos.type = work_type            and
        e.employee_id = lA.employee_id;
    return v_slot_emp_qty;       
end;
/

-- ensuring the slot is a working day
create or replace function validate_day(
    in_start_day number,
    in_end_day   number
)
return boolean
is
    invalid_range     exception;
    involve_holiday   exception;
begin
    if in_start_day >= in_end_day or 
       in_start_day < 0 or in_end_day < 0 
       or in_start_day > 7 or in_end_day > 7 then
       raise invalid_range;
    elsif in_start_day = 1 then
       raise involve_holiday;
    else
       return false;
    end if;
exception
    when invalid_range then
        dbms_output.put_line('invalid_range');
    when involve_holiday then
        dbms_output.put_line('should not involve sunday'); 
end;
/

-- ensuring the time is a working hour
create or replace function validate_time(
    in_start_time varchar,
    in_end_time   varchar
    )
    return boolean
    is
        v_starting_time varchar(10);
        v_ending_time   varchar(10);
        no_night_shift exception;
        too_early      exception;
        invalid_range  exception;
        work_too_few   exception;
    begin
        v_starting_time := 
            to_char(to_date(in_start_time, 'hh24:mi'),'sssss');
        v_ending_time   := 
            to_char(to_date(in_end_time, 'hh24:mi'),'sssss');
        if v_ending_time > 61200 then
            raise no_night_shift;
        elsif v_starting_time < 28800 then
            raise too_early;
        elsif v_starting_time > v_ending_time then
            raise invalid_range;
        elsif  v_ending_time - v_starting_time < 14400 then
            raise work_too_few;
        else
            return true;
        end if;    
    exception
        when no_night_shift then
            dbms_output.put_line('should work before 5:00 pm');
        when too_early then
            dbms_output.put_line('should work after 8:00 am');
        when invalid_range then
            dbms_output.put_line('invalid time range');
        when work_too_few then
            dbms_output.put_line('should work at least 4 hours');
    end;
/    
        
-- allocate the staff to the time slot
create or replace procedure reallocate_emp_slot
    (v_employee_id      in varchar2, 
     v_new_start_day    in number,
     v_new_end_day      in number,
     v_new_start_time   in varchar2,
     v_new_end_time     in varchar2,
     v_allow_new_slot   in boolean
    )
    is
        no_working_stuff     exception;
        new_slot_prohibited  exception;
        v_current            latestAssignment%rowtype;
        v_day_valid          boolean;   
        v_time_valid         boolean;
        v_current_slot_emp   number(4);
        v_worker_pos         varchar(30);
        v_new_slot_emp       number(4);
    
    begin
        select * 
        into   v_current
        from   latestAssignment
        where  employee_id = v_employee_id;
        
        select pos.type
        into   v_worker_pos
        from   position pos, employee emp
        where  emp.position_id = pos.position_id and
               emp.employee_id = v_employee_id;
        
        v_day_valid := 
            validate_day(v_new_start_day, v_new_end_day);
        
        v_time_valid :=
            validate_time(v_new_start_time, v_new_end_time);
        
        v_current_slot_emp :=
            get_emp_qty_in_slot(
                v_current.starting_weekday,
                v_current.ending_weekday,
                to_char(v_current.starting_time, 'hh24:mi'),
                to_char(v_current.ending_time, 'hh24:mi'),
                v_worker_pos);
         
        if v_current_slot_emp < 1 then
            raise no_working_stuff;
        end if;
        
        
        dbms_output.put_line(
            'working ' || v_worker_pos || ' in slot : ' ||
            v_current_slot_emp);
            
        v_new_slot_emp :=
            get_emp_qty_in_slot(
                v_new_start_day ,  v_new_end_day,
                v_new_start_time, v_new_end_time,
                v_worker_pos
            );
            
        dbms_output.put_line(
            'There are ' || v_new_slot_emp || ' ' ||
            v_worker_pos || ' in this slot'
        );
        
        if v_new_slot_emp = 0 then
            dbms_output.put_line(
                'This time slot never exist before ');
            if v_allow_new_slot then
                dbms_output.put_line(
                    'Creating new slot...' || chr(10) ||
                    'Allocating worker to new slot');
                insert into workloadManagement values (
                    v_employee_id, sysdate, v_new_start_day,
                    v_new_end_day, 
                    to_date(v_new_start_time,'hh24:mi'),
                    to_date(v_new_end_time,'hh24:mi')
                ); 
            else
                raise new_slot_prohibited;
            end if;
        else
             dbms_output.put_line(
                'Allocating the worker to new slot... ');
                insert into workloadManagement values (
                    v_employee_id, sysdate, v_new_start_day,
                    v_new_end_day, 
                    to_date(v_new_start_time,'hh24:mi'),
                    to_date(v_new_end_time,'hh24:mi')
                );
        end if;
    
    exception
        when no_data_found then
            dbms_output.put_line('Employee not found!');
        when new_slot_prohibited then    
            dbms_output.put_line(
                'Failure in allocating because new slot' ||
                ' creation is not allowed');
    end;
/