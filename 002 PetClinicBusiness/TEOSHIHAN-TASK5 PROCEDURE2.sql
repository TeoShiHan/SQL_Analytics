-- this query is use to apply job for the client


 create or replace procedure prc_apply_job
    (in_client_id     varchar2,
     in_position_id   varchar2,
     in_method        varchar2
    )
    is
        v_client_los client.level_of_study%type;
        v_job_req    position.min_req%type;
        v_today_app  number(1);
        v_pass_req   boolean;
        e_below_req  exception;
        e_one_pday   exception;
    begin
        select count(client_id)
        into   v_today_app
        from   application
        where  client_id = in_client_id and
               application_date = sysdate;
    
        select level_of_study
        into   v_client_los
        from   client
        where  client_id = in_client_id;
        
        select min_req
        into   v_job_req
        from   position
        where  position_id = in_position_id;
        
        if v_today_app > 0 then
            raise e_one_pday;
        end if;
        
        v_client_los := upper(v_client_los);
        v_job_req    := upper(v_job_req);
       
        
        if v_client_los = 'SPM' then
            v_pass_req := (v_job_req = 'SPM');
        elsif v_client_los = 'BACHELOR DEGREE' then
            v_pass_req := 
                (v_job_req = 'SPM')             or
                (v_job_req = 'BACHELOR DEGREE');
        elsif v_client_los = 'MASTER DEGREE' then
            v_pass_req := 
                (v_job_req = 'SPM')             or
                (v_job_req = 'BACHELOR DEGREE') or
                (v_job_req = 'MASTER DEGREE');
        elsif v_client_los = 'DOCTORATE' then
             v_pass_req := 
                (v_job_req = 'SPM')             or
                (v_job_req = 'BACHELOR DEGREE') or
                (v_job_req = 'MASTER DEGREE')   or
                (v_job_req = 'DOCTORATE');
        end if;
        
        if not v_pass_req then
            raise e_below_req;
        else
            insert into application values(
                in_client_id,
                sysdate,
                in_position_id,
                in_method
            );
            dbms_output.put_line('Successfully made application');
        end if;
        
    exception    
        when e_below_req then
            dbms_output.put_line(
              'the level_of_study ' || v_client_los || ' is ' ||
              'below the minimum requirement'  
            );
            dbms_output.put_line(
                '[HIGH] doctorate -> master degree -> bachelor '||
                'degree -> spm [LOW]'
            );
        when no_data_found then
            dbms_output.put_line(
                'please enter a valid client_id or position_id');
        when e_one_pday then
            dbms_output.put_line(
                'Each client can only apply 1 time per day');
    end;
/