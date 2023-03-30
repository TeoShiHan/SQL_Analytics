-- REPORT OF DEMAND WORKFORCE BASED ON OPEN POSITION RATIO
create or replace procedure prc_workload_demand(v_oppos_pr in number) 
    is
        type dem_by_pa  IS VARRAY(3) OF varchar2(30);
        type dem_by_qty IS VARRAY(4) OF varchar2(30);
        by_pa         dem_by_pa;
        by_qty        dem_by_qty;       
        v_oa_avg_slry number(5);
        v_max_qty     number(3);
        v_max_pa      number(5,2);
        v_pos_ti      position.title%type;
        v_demand      number(3);
        v_curr_qty    number(3);
        v_open_qty    number(3);
        v_open_pa     number(10,2);
        v_avg_salary  number(5);
        v_pa_str      varchar2(20);
        v_slry_rank   varchar2(20);

        cursor demdata_cursor is
            select 
                p.title, p.demand, 
                count(e.position_id),
                trunc(sum(e.salary)/count(e.position_id))
            from 
                employee e, position p
            where 
                e.position_id = p.position_id
            group by 
                p.title, p.demand;

    begin
        v_max_pa :=0.00;
        v_max_qty:=0;
        by_pa    := dem_by_pa('NULL','NULL','NULL');
        by_qty   := dem_by_qty('NULL','NULL','NULL','NULL');

        dbms_output.put_line(
            lpad(
                'REPORT OF DEMAND WORKFORCE BASED 
                ON OPEN POSITION RATIO ',74,'_'
            ) 
            || v_oppos_pr || '%' || rpad('_',24,'_'));
        dbms_output.put_line(rpad('=',101,'='));
        dbms_output.put_line(
            rpad('Position Title'    , 30, ' ')  || ' | ' || 
            rpad('Current working'   , 16 , ' ') || ' | ' || 
            rpad('Demand'            , 7 , ' ')  || ' | ' || 
            rpad('Open Pos. Ratio(%)', 19, ' ')  || ' | ' || 
            rpad('Avg. Cost(RM)   |'     , 20, ' ')
            );
        dbms_output.put_line(rpad('=',101,'='));
        
        
        select avg(salary) into v_oa_avg_slry
        from employee;
        
        open demdata_cursor;
        
        loop
            fetch demdata_cursor into
                v_pos_ti,
                v_demand,
                v_curr_qty,
                v_avg_salary;
            exit when demdata_cursor%notfound;

            v_open_pa := ((v_demand-v_curr_qty)/v_demand)*100;
            
            if v_open_pa < v_oppos_pr then
                continue;
            end if;
            
            v_pa_str  := v_demand-v_curr_qty 
                || '/' || v_demand 
                || '= ' || v_open_pa || '%';
            
            if v_avg_salary >= v_oa_avg_slry then
                v_slry_rank := v_avg_salary || ' (ABOVE AVG)';
            else
                v_slry_rank := v_avg_salary || ' (BELOW AVG)';
            end if;
    
            if v_max_pa < v_open_pa then
                v_max_pa := v_open_pa;
                by_pa    := dem_by_pa(v_pos_ti, v_pa_str, 
                            v_slry_rank);
            end if;
            
            if v_max_qty < v_demand -v_curr_qty then
                v_max_qty := v_demand -v_curr_qty;
                by_qty    := dem_by_qty(v_pos_ti, v_demand, 
                v_curr_qty, v_slry_rank);
            end if;
            

            dbms_output.put_line(
                rpad(v_pos_ti    , 30, ' ') || ' | ' || 
                rpad(v_curr_qty  , 16 , ' ')|| ' | ' || 
                rpad(v_demand    , 7 , ' ') || ' | ' || 
                rpad(v_pa_str    , 19, ' ') || ' | ' || 
                rpad(v_slry_rank || '|' , 21, ' '));
                
        end loop;                                  
        close demdata_cursor;
        dbms_output.put_line(rpad('=',101,'='));
        dbms_output.put_line(
            'Overall Avg. Cost(RM) : ' || v_oa_avg_slry);
        
        dbms_output.put_line(
            chr(10) || chr(10)
            || 'MOST DEMAND POSITION BY OPEN POSITION RATIO(%)' 
            || CHR(13) || CHR(10) || 
            rpad('*',46,'*'));
        dbms_output.put_line(
            'Name         : ' || by_pa(1) || CHR(13) || CHR(10) ||
            'Open Pa(%)   : ' || by_pa(2));
        dbms_output.put_line('Avg.cost(RM) : ' || by_pa(3));
 
        dbms_output.put_line(
            CHR(10) || CHR(10) 
            ||'MOST DEMAND POSITION BY OPEN POSITION QTY' 
            || CHR(10) ||rpad('*',43,'*'));
                                     
        dbms_output.put_line(
            'Name         : ' || by_qty(1) || CHR(13) || CHR(10) ||
            'Avg.cost(RM) : ' || by_qty(4) || CHR(13) || CHR(10) ||
            'Demand       : ' || by_qty(2));
            
        dbms_output.put_line('Current Qty  : ' || by_qty(3));
        dbms_output.put_line('----------------- ');
        dbms_output.put_line(
            'Insufficient : ' || 
            (TO_number(by_qty(2))-TO_number(by_qty(3))));
        dbms_output.put_line('----------------- ');
    END;
/