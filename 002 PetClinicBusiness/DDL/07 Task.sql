ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
SET LINESIZE 120
SET PAGESIZE 100

CREATE TABLE Task(
   task_id      VARCHAR(6)  NOT NULL PRIMARY KEY,
   type         VARCHAR(11) NOT NULL,
   description  VARCHAR(29) NOT NULL,
   price       NUMBER(6,1) NOT NULL
);
INSERT INTO Task VALUES ('TA0001','counselling','psychology',216.7);
INSERT INTO Task VALUES ('TA0002','counselling','nutritional',272.8);
INSERT INTO Task VALUES ('TA0003','counselling','therapeutic',292.7);
INSERT INTO Task VALUES ('TA0004','daycare','walk',50.9);
INSERT INTO Task VALUES ('TA0005','daycare','play',53.3);
INSERT INTO Task VALUES ('TA0006','daycare','feed',43.6);
INSERT INTO Task VALUES ('TA0007','diagnosis','blood test',69.3);
INSERT INTO Task VALUES ('TA0008','diagnosis','fecal sample testing',67.3);
INSERT INTO Task VALUES ('TA0009','diagnosis','radiology',88.7);
INSERT INTO Task VALUES ('TA0010','diagnosis','urinalysis',184);
INSERT INTO Task VALUES ('TA0011','groom','blade',111);
INSERT INTO Task VALUES ('TA0012','groom','nail trimming',117.1);
INSERT INTO Task VALUES ('TA0013','groom','shave',102.8);
INSERT INTO Task VALUES ('TA0014','groom','bath',85.2);
INSERT INTO Task VALUES ('TA0015','groom','ear cleaning',101.1);
INSERT INTO Task VALUES ('TA0016','groom','brush',59.2);
INSERT INTO Task VALUES ('TA0017','groom','tooth brushing',44.8);
INSERT INTO Task VALUES ('TA0018','groom','dry',35.8);
INSERT INTO Task VALUES ('TA0019','surgery','spleen cancer',113.2);
INSERT INTO Task VALUES ('TA0020','surgery','skin lacerations',439);
INSERT INTO Task VALUES ('TA0021','surgery','bladder stones',1011);
INSERT INTO Task VALUES ('TA0022','surgery','internal bleeding',728.5);
INSERT INTO Task VALUES ('TA0023','surgery','ophthalmic',580.7);
INSERT INTO Task VALUES ('TA0024','surgery','dental extractions',379.4);
INSERT INTO Task VALUES ('TA0025','surgery','fracture repair',1075);
INSERT INTO Task VALUES ('TA0026','surgery','orthopedic',1127.8);
INSERT INTO Task VALUES ('TA0027','surgery','torn cruciate',1188.9);
INSERT INTO Task VALUES ('TA0028','surgery','cardiology',275.1);
INSERT INTO Task VALUES ('TA0029','surgery','spay',1175.2);
INSERT INTO Task VALUES ('TA0030','surgery','neuter',668.8);
INSERT INTO Task VALUES ('TA0031','cleaning','lodge cleaning',10);
INSERT INTO Task VALUES ('TA0032','cleaning','clean floor',0);
INSERT INTO Task VALUES ('TA0036','cashier','totaling customers'' purchases',0);
INSERT INTO Task VALUES ('TA0037','cashier','arrange stock',0);
INSERT INTO Task VALUES ('TA0038','cashier','receive supply',0);
INSERT INTO Task VALUES ('TA0039','cashier','order supply',0);
INSERT INTO Task VALUES ('TA0040','assistant','prepare the operating room',0);
INSERT INTO Task VALUES ('TA0041','assistant','disinfection',0);

select count(*) as TotalTaskRecords from Task;
