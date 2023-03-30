-- generating the sales report in a particular year in a period of month

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
SET LINESIZE 120
SET PAGESIZE 120
SET SERVEROUTPUT ON

create or replace view mmyy_task_rev as
    with 
        oa_rev_by_mm as (
            select 
                extract(year from exam_date)  as year,  
                upper(
                    to_char(to_date(extract(month from exam_date), 
                    'MM'), 'month')
                ) as month,
                t.type, t.price
            from 
                task t, examination ex
            where 
                t.task_id = ex.task_id
            union all
            select
                extract(year from treatment_date)  as year, 
                upper(to_char
                    (to_date(extract(month from treatment_date), 
                     'MM'), 'month')
                ) as month,
                t.type, t.price
            from 
                task t, treatment tr
            where 
                t.task_id = tr.task_id     
        ),
        rev_by_yymm as(
            select    year, month, type, sum(price) as total_rev
            from      oa_rev_by_mm
            group by  year, month, type
            having    sum(price) > 0 
            order by  year, month, type
        )
    select * from rev_by_yymm
    with read only;


create or replace procedure prc_rev_summ(
    v_year in number, 
    v_starting_month in number, 
    v_ending_month in number
    )
    
    is
        v_mon_rev       number(10,2);
        v_range         number(2);
        type serve_rev  IS VARRAY(6) OF NUMBER(10,2);
        col_sum         serve_rev;
        v_month         varchar2(30);
        v_coun_rev      number(10,2);
        v_daycare_rev   number(10,2);
        v_diag_rev      number(10,2);
        v_groom_rev     number(10,2);
        v_surge_rev     number(10,2);
        v_clean_rev     number(10,2);
        v_grand_rev     number(10,2);
        
        cursor rev_data_cursor is
            with
                date_filter as
                (
                    select * 
                    from
                        mmyy_task_rev
                    where
                        year = v_year                  and
                        to_date(month,'MM')            between 
                        to_date(v_starting_month,'MM') and 
                        to_date(v_ending_month,'MM')
                )
            select 
                distinct vm.month,
                COALESCE(c.total_rev, 0) as counselling, 
                COALESCE(d.total_rev, 0) as daycare, 
                COALESCE(di.total_rev, 0)as diagnosis,
                COALESCE(g.total_rev, 0) as groom, 
                COALESCE(s.total_rev, 0) as surgery, 
                COALESCE(clean.total_rev, 0) as clean
            from
                mmyy_task_rev vm,
                (select month, total_rev from date_filter
                    where type='counselling')  c,
                (select month, total_rev from date_filter
                    where type='daycare')  d,
                (select month, total_rev from date_filter
                    where type='diagnosis')  di,
                (select month, total_rev from date_filter
                    where type='groom')  g,
                (select month, total_rev from date_filter
                    where type='surgery')s,
                (select month, total_rev from date_filter
                    where type='cleaning')  clean
            where 
                vm.month = c.month    (+)      and
                vm.month = d.month    (+)      and
                vm.month = di.month   (+)      and
                vm.month = g.month    (+)      and
                vm.month = s.month    (+)      and
                vm.month = clean.month(+)      and
                to_date(vm.month,'MM')         between 
                to_date(v_starting_month,'MM') and 
                to_date(v_ending_month  ,'MM')
            order by to_date(month,'MM');
    
    begin
        col_sum := serve_rev(0,0,0,0,0,0);
        v_range := v_ending_month - v_starting_month;
        
        
        if v_range <= 1 then
            dbms_output.put_line(
                'The interval between starting and 
                ending month cannot less 
                than or equal to 1!'
            );
            return;
        elsif 
            v_starting_month < 1 or v_starting_month > 12 or
            v_ending_month   < 1 or v_ending_month   > 12 then
            dbms_output.put_line('error month range!');
            return;
        else
            dbms_output.put(chr(09)||chr(09)||chr(09)||chr(09)||chr(09));
            dbms_output.put_line
            (
                'REVENUE SUMMARY ON YEAR ' || v_year      || ' BETWEEN ' ||
                 UPPER(to_char(to_date(v_starting_month,'MM'), 'month')) ||
                 'AND '|| UPPER(to_char(to_date(v_ending_month,'MM'), 'month'))   
                 || chr(10)
            );
            dbms_output.put_line(chr(09)||rpad('-',128,'-'));
            dbms_output.put('-'||lpad('MONTH \ SERVICE |',25));
            dbms_output.put_line
            ( 
                lpad('COUNSELLING',15) || lpad('DAYCARE',15) ||
                lpad('DIAGNOSIS',15)   || lpad('GROOM',15)   ||
                lpad('SURGERY',15)     || lpad('CLEANING',15)||
                lpad('MONTHLY SALES',20)
            );
            dbms_output.put_line(chr(09)||rpad('-',128,'-'));                     
        end if;


        open rev_data_cursor;
        loop
            fetch rev_data_cursor into 
                v_month    , v_coun_rev , v_daycare_rev, v_diag_rev,
                v_groom_rev, v_surge_rev, v_clean_rev;
            exit when rev_data_cursor%notfound;
            
            v_mon_rev := v_coun_rev + v_daycare_rev + v_diag_rev + 
                         v_groom_rev + v_surge_rev + v_clean_rev;
                         
            col_sum(1) := col_sum(1)+v_coun_rev;
            col_sum(2) := col_sum(2)+v_daycare_rev;
            col_sum(3) := col_sum(3)+v_diag_rev;
            col_sum(4) := col_sum(4)+v_groom_rev;
            col_sum(5) := col_sum(5)+v_surge_rev;
            col_sum(6) := col_sum(6)+v_clean_rev;
            
            dbms_output.put('-'||lpad(v_month || '|',25));
            dbms_output.put_line
            ( 
                lpad(v_coun_rev,15) || lpad(v_daycare_rev,15) ||
                lpad(v_diag_rev,15) || lpad(v_groom_rev,15)   ||
                lpad(v_surge_rev,15)|| lpad(v_clean_rev,15)   ||
                lpad(v_mon_rev,20)
            );
            
        end loop;
        
        v_grand_rev := 0;
        
        for i in 1..6
            loop
                v_grand_rev := v_grand_rev + col_sum(i);
            end loop;
        
        
        dbms_output.put_line(chr(09)||rpad('-',128,'-'));
        dbms_output.put('-'||lpad('Total : ',25));
            dbms_output.put_line
            ( 
                lpad(col_sum(1),15) || lpad(col_sum(2),15)   ||
                lpad(col_sum(3),15) || lpad(col_sum(4),15)   ||
                lpad(col_sum(5),15) || lpad(col_sum(6),15)   ||
                lpad('GRAND : '||v_grand_rev,20)
            );
        dbms_output.put_line(chr(09)||rpad('-',128,'-'));
        close rev_data_cursor;
    end;
/