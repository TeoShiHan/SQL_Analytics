create or replace trigger trg_client_audit
before
    insert or update or delete on client
    FOR EACH ROW
declare
    v_alter_string          varchar(300);
begin
    case
        when inserting then
            v_alter_string := 'CREATE CLIENT ' || :new.client_id;
            
        when updating('client_id') then
            v_alter_string := v_alter_string ||
                'alter client ID : ' ||
                :old.client_id || '->'|| 
                :new.client_id;
        
        when updating('client_name') then
            v_alter_string := v_alter_string   ||
                'alter client_name : ' ||
                :old.client_name    || '->'    || 
                :new.client_name;
           
        when updating('date_of_birth') then
            v_alter_string := v_alter_string     ||
                'alter date_of_birth : ' ||
                :old.date_of_birth    || '->'    || 
                :new.date_of_birth;
                
        when updating('mobile') then
            v_alter_string := v_alter_string ||
                'alter mobile : ' ||
                :old.mobile    ||     '->'|| 
                :new.mobile;
        
        when updating('email') then
            v_alter_string := v_alter_string ||
                'alter email : ' ||
                :old.email    || '->'    || 
                :new.email;
        
        when updating('level_of_study') then
            v_alter_string := v_alter_string ||
                'alter level_of_study : ' ||
                :old.level_of_study    || '->'    || 
                :new.level_of_study;
                
        when deleting then 
            v_alter_string := 'DELETE CLIENT ' || :old.client_id;        
    end case;
    
    case
        when inserting or updating then
            insert into clientAudit values (
                clientAudit_seq.nextVal,
                :new.client_id,
                :new.client_name,
                :new.date_of_birth,
                :new.mobile,
                :new.email,
                :new.level_of_study,
                sysdate,
                v_alter_string
            );  
        when deleting then
            insert into clientAudit values (
                clientAudit_seq.nextVal,
                :old.client_id,
                :old.client_name,
                :old.date_of_birth,
                :old.mobile,
                :old.email,
                :old.level_of_study,
                sysdate,
                v_alter_string
            );
     end case;
end;
/            