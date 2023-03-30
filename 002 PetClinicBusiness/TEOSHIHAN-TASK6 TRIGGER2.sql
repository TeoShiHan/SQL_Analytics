create or replace trigger trg_treatment_audit
before
    insert or update on treatment
    FOR EACH ROW
declare
    v_exist                 boolean;
    v_count                 number(1);
    v_rev                   number(10,2);
    v_ori_rev               number(10,2);
    v_ori_count             number(5);
    v_old_rev               number(10,2);
begin
    select count(*)
    into  v_count   --exist
    from  treatmentAudit 
    where pet_id = :new.pet_id;
    
    select price
    into   v_rev  --treatment price
    from   task
    where  task_id = :new.task_id;
    
    case
        when inserting then
            if v_count <= 0 then --no record
                insert into treatmentAudit 
                values (
                    treatmentAudit_seq.nextVal,
                    :new.pet_id, 1, v_rev);
            else
                select treatment_count, revenue
                into   v_ori_count, v_ori_rev
                from   treatmentAudit
                where  pet_id = :new.pet_id;
                
                update treatmentAudit
                set    revenue = v_ori_rev+v_rev
                where  pet_id = :new.pet_id;
                
                update treatmentAudit
                set    treatment_count = treatment_count+1
                where  pet_id = :new.pet_id;
                
            end if;
        
        when updating('task_id') then
            select price
            into   v_old_rev  --treatment price
            from   task
            where  task_id = :old.task_id;
            
            select revenue
                into   v_ori_rev
                from   treatmentAudit
                where  pet_id = :new.pet_id;
            
            update treatmentAudit
                set    revenue = v_ori_rev + v_rev -v_old_rev
                where  pet_id = :new.pet_id;    
    end case;
end;
/