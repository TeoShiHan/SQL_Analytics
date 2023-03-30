-- checking the pet details that is involving in treatment along with
-- payment status
create or replace type petdt_typ 
    as object(
        pet_id VARCHAR2(7),
        name   VARCHAR2(19),
        gender VARCHAR2(14),
        age    number(3),
        type   VARCHAR2(10),
        breed  VARCHAR2(40)
    );
/

create or replace type ownerdt_typ 
    as object(
        pet_id VARCHAR2(7),
        name   VARCHAR2(28),
        mobile VARCHAR2(12),
        email  VARCHAR2(36)
    );
/

create or replace type treatdt_typ 
    as object(
        pet_id   VARCHAR2(7),
        name     VARCHAR2(29),
        price   NUMBER(6,1),
        t_date   date,
        pay_stat VARCHAR2(6),
        doc_name VARCHAR2(20)
     );
/    



create or replace procedure prc_trea_det
    (v_start_date in date, 
     v_end_date in date
    )
    is
        pet        petdt_typ;
        owner      ownerdt_typ;
        treat      treatdt_typ;
        v_curr_pet pet.pet_id%type;
        v_pint     varchar2(20);
        
        cursor petdt_cursor is
            select
                distinct tr.pet_id, p.name, p.gender,
                trunc((sysdate-p.date_of_birth)/365) as age,
                pet_type, breed
            from
                treatment tr, pet p
            where
                tr.pet_id = p.pet_id and
                treatment_date       between
                v_start_date         and
                v_end_date
            order by tr.pet_id;
        
        cursor ownerdt_cursor is
            select 
                distinct tr.pet_id , c.name,
                c.mobile, c.email
            from 
                treatment tr, pet p, customer c
            where
                tr.pet_id = p.pet_id            and
                p.customer_id = c.customer_id   and
                treatment_date                  between
                v_start_date                    and  
                v_end_date
            order by tr.pet_id;
            
        cursor treatdt_cursor is
            select
                tr.pet_id, tsk.description, 
                tsk.price, treatment_date, 
                payment_status, e.name
            from 
                treatment tr, employee e, task tsk
            where 
                tr.employee_id = e.employee_id  and
                tsk.task_id = tr.task_id        and
                treatment_date                  between
                v_start_date   and  v_end_date
            order by tr.pet_id, payment_status;
    begin
        pet       := petdt_typ('null', 'null', 'null', 0,'null','null');
        owner     := ownerdt_typ('null', 'null', 'null', 'null');
        treat     := treatdt_typ('null', 'null',0,'11/11/11','null','null');
        v_curr_pet:= '0';
        
        open petdt_cursor;
        open ownerdt_cursor;
        open treatdt_cursor;
        
        loop
            fetch petdt_cursor into
                pet.pet_id, pet.name, pet.gender, 
                pet.age, pet.type, pet.breed;
            exit when petdt_cursor%notfound;
            
            fetch ownerdt_cursor into --Qty = petdt
                owner.pet_id, owner.name, owner.mobile, owner.email;
            
            dbms_output.put_line(chr(10));
            dbms_output.put_line('| ' || lpad(rpad('=',110,'='),119));
            dbms_output.put_line(
                '|' ||
                lpad(('#DETAIL '  || petdt_cursor%rowcount),21)
                );
            dbms_output.put_line('| ' || lpad(rpad('=',110,'='),119));
            dbms_output.put_line('|'  || lpad('PET DETAILS',21));
            dbms_output.put_line('| ' || lpad(rpad('-',40,'-'),49));
            dbms_output.put('|' || lpad('PET ID ',17));
            dbms_output.put_line('| ' || rpad(pet.pet_id,17));
            dbms_output.put('|' || lpad('Name   ',17));
            dbms_output.put_line('| ' || rpad(pet.name,17));
            dbms_output.put('|' || lpad('Gender ',17));
            dbms_output.put_line('| ' || rpad(pet.gender,17));
            dbms_output.put('|' || lpad('Age    ',17));
            dbms_output.put_line('| ' || rpad(pet.age,17));
            dbms_output.put('|' || lpad('Type   ',17));
            dbms_output.put_line('| ' || rpad(pet.type,17));
            dbms_output.put('|' || lpad('Breed  ',17));
            dbms_output.put_line('| ' || rpad(pet.breed,17));
            dbms_output.put_line('| ' || lpad(rpad('-',40,'-'),49));
            dbms_output.put_line('|' || lpad('CUSTOMER DETAILS',26));
            dbms_output.put_line('| ' || lpad(rpad('-',40,'-'),49));
            dbms_output.put('|' || lpad('Name   ',17));
            dbms_output.put_line('| ' || rpad(owner.name,17));
            dbms_output.put('|' || lpad('Mobile ',17));
            dbms_output.put_line('| ' || rpad(owner.mobile,17));
            dbms_output.put('|' || lpad('Email  ',17));
            dbms_output.put_line('| ' || rpad(owner.email,17));
            dbms_output.put_line('| ' || lpad(rpad('-',40,'-'),49));
            dbms_output.put(chr(10));
            dbms_output.put_line('|'  || lpad('HISTORY : ',20));
            dbms_output.put(
                '|'  ||
                rpad(' ',10,' ') ||
                rpad('Treatment', 22)
            );
            dbms_output.put(rpad('price(RM)',   22));
            dbms_output.put(rpad('Treatment Date',   22));
            dbms_output.put_line(rpad('Payment Status', 22));
            dbms_output.put_line('| ' || lpad(rpad('-',110,'-'),119));
            
            
            
            if treatdt_cursor%rowcount >1 then
                    dbms_output.put('|'  ||
                        rpad(' ',10,' ') ||
                        rpad(treat.name, 22)
                    );
                    dbms_output.put(rpad(treat.price,   22));
                    dbms_output.put(rpad(treat.t_date,   22));
                    dbms_output.put_line(rpad(treat.pay_stat, 22));
            end if; 
            
            treat.pet_id := pet.pet_id;
            
            while treat.pet_id = owner.pet_id
            loop    
                fetch treatdt_cursor into
                treat.pet_id, treat.name, treat.price, treat.t_date, 
                treat.pay_stat, treat.doc_name;
                exit when treatdt_cursor%notfound;
                
                if treat.pet_id = owner.pet_id then
                    dbms_output.put('|'||
                        rpad(' ',10,' ') ||
                        rpad(treat.name, 22)
                    );
                    dbms_output.put(rpad(treat.price,   22));
                    dbms_output.put(rpad(treat.t_date,   22));
                    dbms_output.put_line(rpad(treat.pay_stat, 22));
                end if;    
            end loop;
            dbms_output.put_line('| ' || lpad(rpad('=',110,'='),119));
        end loop;
        
        dbms_output.put_line(
            '|' || lpad('Total Pet Qty : ', 26) || 
            petdt_cursor%rowcount);
            
        close petdt_cursor;
        close ownerdt_cursor;
        close treatdt_cursor;
    end;
/