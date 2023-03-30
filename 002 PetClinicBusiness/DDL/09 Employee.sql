ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
SET LINESIZE 120
SET PAGESIZE 100

--note: removed duplicate EMP30000 Cloris Benez

CREATE TABLE Employee(
   employee_id   VARCHAR(8)  NOT NULL PRIMARY KEY,
   name          VARCHAR(20) NOT NULL,
   date_of_birth DATE        NOT NULL,
   mobile        VARCHAR(12) NOT NULL,
   email         VARCHAR(31) NOT NULL,
   gender        VARCHAR(6)  NOT NULL CHECK (UPPER(gender) in ('MALE', 'FEMALE')),
   address       VARCHAR(57) NOT NULL,
   position_id   VARCHAR(7)  NOT NULL,
   salary        INTEGER     NOT NULL CHECK (salary >= 1000),
   CONSTRAINT employee_chk_employee_id   CHECK (REGEXP_LIKE(employee_id, '^EMP\d{5}$')),
   CONSTRAINT employee_chk_mobile        CHECK (REGEXP_LIKE(mobile, '^(01[(2-90)]-\d{7})$|^(011-\d{8})$')),
   CONSTRAINT employee_chk_email         CHECK (REGEXP_LIKE(email,'^[a-zA-Z]\w+@(\S+)$')),
   CONSTRAINT fk_employee_job_scope 	 FOREIGN KEY(position_id) REFERENCES Position(position_id)
);

INSERT INTO Employee VALUES ('EMP10000','Philippine Smickle','30/11/1999','019-9408735','psmickle0@imgur.com','Female','3 Debs Circle ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP20000','Carmen Perazzo','9/1/1975','016-6598607','cperazzo1@senate.gov','Male','068 Charing Cross Point ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP30000','Kristoforo Bengtson','12/6/1971','011-99205693','kbengtson2@squidoo.com','Female','062 Huxley Way ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP40000','Sandro Hadfield','2/3/1969','011-25584292','shadfield3@telegraph.co.uk','Female','78319 Beilfuss Park ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP50000','Isidro Gingles','22/11/1974','011-71568606','igingles4@ovh.net','Male','691 Bobwhite Way ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP60000','Shae Friel','28/2/1996','018-6299370','sfriel5@behance.net','Female','9693 Schmedeman Plaza ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP70000','Alfy Bentzen','8/4/1977','011-65490227','abentzen6@narod.ru','Male','182 Vidon Court ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP80000','Matteo Mc Pake','25/10/1976','018-3836655','mmc7@fotki.com','Female','99 Green Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP90000','Leonardo Wayne','22/9/1995','019-6640018','lwayne8@friendfeed.com','Female','375 Surrey Alley ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP11000','Munmro Shoemark','4/3/1986','011-28256154','mshoemarka@com.com','Female','18931 Brentwood Way ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP12000','Lee Mitkin','9/8/1984','019-9737483','lmitkinb@salon.com','Male','66 Morningstar Pass ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP13000','Sadella Jerratsch','16/7/1969','018-6323025','sjerratschc@ted.com','Male','92 Moland Place ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP14000','Sherwin Ege','2/4/1983','011-17509442','seged@comcast.net','Female','83849 Evergreen Court ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP15000','Aubine Suett','11/4/1995','011-99239643','asuette@multiply.com','Male','2 Hoepker Alley ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP16000','Byrann Domney','8/2/1968','019-7519527','bdomneyf@mediafire.com','Male','726 Almo Hill ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP17000','Nanette Pace','7/11/1972','019-2322378','npaceg@e-recht24.de','Male','70 Kingsford Junction ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP18000','Wilow Chatelot','1/4/1983','011-35792100','wchateloth@newsvine.com','Female','7 Clemons Drive ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP19000','Lurline Doman','2/4/1981','016-6068510','ldomani@yahoo.com','Female','5 Lyons Park ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP21000','Petr Lindsey','26/7/1990','011-90656710','plindseyk@instagram.com','Female','48032 David Park ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP22000','Chiquita Avramow','25/5/1970','010-1539214','cavramowl@163.com','Male','2 Rowland Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP23000','Tildi O''Farrell','9/9/1989','011-84877194','tofarrellm@nhs.uk','Female','060 Brentwood Way ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP24000','Diarmid Sturm','19/8/1985','019-4410101','dsturmn@cafepress.com','Male','5272 Wayridge Way ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP25000','Audy Jeffree','28/10/1970','019-7865748','ajeffreeo@qq.com','Male','14464 Waywood Junction ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP26000','Huntlee Reditt','5/8/1983','019-7077263','hredittp@redcross.org','Male','6561 Melrose Place ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP27000','Munroe Buzine','11/4/1981','011-66335453','mbuzineq@cdbaby.com','Female','63184 Lerdahl Alley ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP28000','Benedetto Noar','1/3/1972','019-5725411','bnoarr@umn.edu','Female','55487 Fulton Circle ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP29000','Pepe Andrag','3/10/1995','016-7749350','pandrags@csmonitor.com','Female','30 Gateway Junction ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP31000','Sheff Sonier','31/3/1976','011-01851567','ssonieru@yahoo.com','Female','292 Sutteridge Plaza ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP32000','Sayre Cloney','15/5/1976','011-14316449','scloneyv@wsj.com','Female','034 Anniversary Hill ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP33000','Butch Pillinger','10/5/1981','019-9833073','bpillingerw@blogspot.com','Male','4 Golf Course Parkway ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP34000','Licha Tarbatt','29/1/1981','019-4392655','ltarbattx@ifeng.com','Male','968 Hanson Lane ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP35000','Antonia Flott','20/6/1974','019-5378903','aflotty@de.vu','Female','5 Burrows Parkway ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP36000','Gerty O''Flannery','15/11/1983','011-34951813','goflanneryz@friendfeed.com','Female','510 Mifflin Avenue ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP37000','Donovan Bisacre','30/11/1989','011-48172801','dbisacre10@sciencedaily.com','Female','53266 Mallard Lane ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP38000','Yuri Attard','29/11/1989','011-11087058','yattard11@skyrock.com','Female','882 Grim Pass ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP39000','Corri Alsop','15/7/1968','018-7583534','calsop12@wikipedia.org','Male','828 Evergreen Terrace ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP41000','Sandra Cluatt','17/4/1975','011-59642573','scluatt14@wordpress.org','Female','45991 Veith Way ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP42000','Babette Mackro','10/3/1985','019-2514269','bmackro15@posterous.com','Male','9710 Dapin Street ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP43000','Toddie Arnow','19/8/1985','011-30240747','tarnow16@nba.com','Female','32 Trailsway Court ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP44000','Bondy Comins','3/2/1996','014-9531845','bcomins17@mapy.cz','Female','91 Corscot Terrace ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP45000','Samson Sheldrick','13/12/1968','018-1859214','ssheldrick18@bloglovin.com','Female','0 Mifflin Way ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP46000','Alida Arundel','4/6/1968','011-92940244','aarundel19@google.it','Male','10165 Grim Terrace ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP47000','Cari Pelcheur','24/2/1982','011-30795486','cpelcheur1a@oaic.gov.au','Female','25 Continental Road ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP48000','Pepi Hastewell','12/9/1985','017-6673037','phastewell1b@so-net.ne.jp','Male','45 Vernon Avenue ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP49000','Cassey Castan','2/6/1993','011-10402032','ccastan1c@stumbleupon.com','Male','60 Vermont Place ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00001','Nonah Hasney','7/2/1985','011-54439115','nhasney1d@tumblr.com','Male','03 Dennis Crossing ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00002','Cristabel MacAne','23/11/1994','019-7006927','cmacane1e@ucoz.com','Male','5867 Sutteridge Junction ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00003','Elianora Kingsman','21/2/1978','019-9156866','ekingsman1f@timesonline.co.uk','Male','260 Browning Circle ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00004','Lizabeth People','25/7/1982','019-5091135','lpeople1g@addthis.com','Male','01510 Forster Drive ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00005','Billy Warrilow','12/10/1967','011-81241086','bwarrilow1h@yahoo.com','Male','23 Birchwood Pass ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00006','Koo Goble','31/1/1979','019-3304560','kgoble1i@wikia.com','Female','8 Saint Paul Avenue ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00007','Darren Langfat','14/2/1980','019-8700489','dlangfat1j@smh.com.au','Male','6649 Debs Pass ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00008','Waldon Birtonshaw','26/6/1971','011-00791908','wbirtonshaw1k@senate.gov','Male','9052 American Ash Street ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00009','Frank Hurkett','11/2/1979','011-24323553','fhurkett1l@ebay.co.uk','Male','1477 Emmet Avenue ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00010','Suzette Winspire','27/5/1976','019-2872175','swinspire1m@shutterfly.com','Male','33452 5th Hill ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00011','Pierson Bruce','8/4/1979','016-4403211','pbruce1n@slate.com','Female','89849 Susan Center ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00012','Sam Hainey','13/11/1983','019-4552742','shainey1o@dion.ne.jp','Female','4522 Texas Circle ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00013','Gussi Bierman','16/9/1969','017-9095482','gbierman1p@phoca.cz','Female','7 Kensington Drive ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00014','Benjamin Scouler','13/3/1993','011-36557812','bscouler1q@macromedia.com','Female','64 Lotheville Center ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00015','Adara Triggel','27/10/1991','019-0295003','atriggel1r@freewebs.com','Male','8 Dakota Lane ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00016','Neville Reef','2/9/1967','011-50222237','nreef1s@oaic.gov.au','Male','022 Loeprich Plaza ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00017','Raquel Lagne','30/4/1989','017-5660384','rlagne1t@unc.edu','Female','28492 Springview Parkway ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00018','Carita Trewhitt','11/10/1986','011-05909756','ctrewhitt1u@bandcamp.com','Male','96840 Artisan Lane ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00019','Jackie Whitmore','22/10/1968','019-1134750','jwhitmore1v@51.la','Female','299 Lunder Crossing ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00020','Anthia Ivic','28/6/1994','011-62976870','aivic1w@shop-pro.jp','Female','7 Morningstar Center ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00021','Kenyon De Dantesie','20/2/1967','019-0485475','kde1x@moonfruit.com','Female','747 Eastwood Court ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00022','Harlen Pockett','16/5/1982','011-21442006','hpockett1y@rambler.ru','Female','0 Coleman Drive ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00023','Cindee Ebbins','2/2/1989','011-49386862','cebbins1z@miibeian.gov.cn','Male','3 Dryden Drive ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00024','Lola Hallewell','9/3/1968','011-00399556','lhallewell20@telegraph.co.uk','Female','9 Vahlen Alley ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00025','Ugo Chang','25/7/1970','018-4511409','uchang21@goo.ne.jp','Female','6352 Stang Place ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00026','Redford McCrossan','28/3/1973','011-10842002','rmccrossan22@biblegateway.com','Female','0 Superior Parkway ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00027','Ronni Barizeret','9/1/1994','011-65345923','rbarizeret23@hao123.com','Male','5 Utah Drive ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00028','Brinna Sherlock','19/6/1968','011-32553350','bsherlock24@thetimes.co.uk','Female','2 Debs Circle ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00029','Carol Gibb','17/11/1984','018-5938507','cgibb25@hc360.com','Female','66231 Rigney Court ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00030','Olenka Johnke','4/1/1996','018-1133470','ojohnke26@wikipedia.org','Male','09 Sutherland Road ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00031','Langsdon Ternott','2/4/1967','011-64171949','lternott27@twitpic.com','Female','4 Eastlawn Avenue ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00032','Terry Smolan','8/11/1993','019-8521309','tsmolan28@si.edu','Male','8782 Schurz Pass ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00033','Isabel Morillas','3/10/1987','011-20117888','imorillas29@cocolog-nifty.com','Female','44977 Steensland Trail ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00034','Hildagard Hitchens','4/1/1971','018-2388331','hhitchens2a@altervista.org','Male','6436 Elka Point ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00035','Toby Greenlies','11/10/1971','011-93466822','tgreenlies2b@com.com','Male','97 Little Fleur Street ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00036','Winfred Roblin','19/1/1977','011-20293637','wroblin2c@sphinn.com','Male','0 Marcy Pass ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00037','Ahmed Bricham','6/9/1994','011-93825668','abricham2d@irs.gov','Male','0 Parkside Pass ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00038','Vincenty Varker','21/8/1974','011-63429050','vvarker2e@storify.com','Female','1180 Eagan Terrace ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00039','Michail Priscott','2/7/1977','011-02628685','mpriscott2f@sohu.com','Female','397 Moose Terrace ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00040','Wynn Ludford','26/4/1982','011-11470367','wludford2g@icio.us','Female','1 Karstens Drive ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00041','Lissie Sussans','20/12/1984','019-8361397','lsussans2h@g.co','Female','12521 Banding Drive ,50000 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00042','Verge Moseby','9/4/1973','011-90750424','vmoseby2i@aol.com','Male','07 Utah Circle ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00043','Alejandro Allmark','10/3/1975','019-7993683','aallmark2j@bravesites.com','Female','9 Stang Alley ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00044','Babb Shank','7/12/1995','018-2652068','bshank2k@cocolog-nifty.com','Male','51 Stephen Trail ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00045','Cad Gration','22/1/1978','011-98172756','cgration2l@pbs.org','Male','94811 Kipling Junction ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00046','Blondy Fairlem','1/9/1988','011-44641453','bfairlem2m@flickr.com','Female','585 Dixon Road ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00047','Dena Ekkel','27/5/1980','019-7672767','dekkel2n@yellowbook.com','Female','33 Cody Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00048','Romy Volette','30/6/1994','019-6977209','rvolette2o@freewebs.com','Female','837 Colorado Hill ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00049','Ruttger Breckenridge','21/6/1973','019-6786504','rbreckenridge2p@4shared.com','Male','01538 Havey Court ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00050','Harlan Bowdrey','22/12/1984','018-1905465','hbowdrey2q@hibu.com','Female','14 Debra Alley ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00051','Devlen Bernhardi','2/5/1971','011-04223873','dbernhardi2r@skyrock.com','Male','7 Laurel Park ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00052','Angela Couvet','13/2/1968','019-4145758','acouvet2s@jimdo.com','Male','02 Alpine Plaza ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00053','Marie Pach','4/12/1985','011-52827842','mpach2t@edublogs.org','Female','9 Clemons Terrace ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00054','Doug Satchel','14/4/1980','019-3998002','dsatchel2u@instagram.com','Female','31 Hollow Ridge Place ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00055','Webb Chatel','19/12/1982','017-6076439','wchatel2v@cnbc.com','Female','6471 Buena Vista Terrace ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00056','Felita Godrich','12/8/1968','011-17293760','fgodrich2w@telegraph.co.uk','Male','839 Mockingbird Place ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00057','Clarita Lynde','15/6/1979','018-2728671','clynde2x@un.org','Male','63 Dakota Hill ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00058','Igor Whyard','5/5/1986','017-3422214','iwhyard2y@upenn.edu','Male','808 Homewood Alley ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00059','Dur Macari','13/10/1984','014-3603624','dmacari2z@phpbb.com','Female','171 Ohio Lane ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00060','Malinde Tinwell','21/7/1993','011-30984958','mtinwell30@blog.com','Female','53 Oak Valley Place ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00061','Alex Maskill','18/2/1977','011-43764013','amaskill31@adobe.com','Male','318 Messerschmidt Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00062','Roch Dellenbrok','26/12/1995','017-0701173','rdellenbrok32@nymag.com','Male','36 Arrowood Terrace ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00063','Jasmine Molloy','19/9/1969','017-0114704','jmolloy33@cmu.edu','Male','356 Buhler Lane ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00064','Shanda Handrahan','2/1/1993','019-8526777','shandrahan34@prweb.com','Female','4374 Barby Point ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00065','Giacopo Cressey','9/4/1972','016-6596482','gcressey35@statcounter.com','Male','876 Hooker Pass ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00066','Melinda Macilhench','9/12/1995','011-92821814','mmacilhench36@smugmug.com','Male','158 Vahlen Court ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00067','Kym Glison','27/9/1969','011-29101479','kglison37@cisco.com','Male','27614 Loeprich Circle ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00068','Hanny Pozzi','4/8/1979','011-78945730','hpozzi38@slashdot.org','Female','2 Anniversary Drive ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00069','Rosa McCurdy','21/3/1969','016-8049068','rmccurdy39@cpanel.net','Male','165 Randy Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00070','Rosalinda Mourant','9/10/1968','011-96845139','rmourant3a@infoseek.co.jp','Male','7 Schmedeman Road ,50050 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00071','Berkie Sacco','9/4/1995','019-2359996','bsacco3b@dyndns.org','Male','4 Cambridge Drive ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00072','Casar Coverlyn','27/7/1987','011-34362608','ccoverlyn3c@mayoclinic.com','Male','5 Rutledge Circle ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00073','Phebe Hirche','11/1/1987','019-5247848','phirche3d@wordpress.com','Male','2 Morningstar Court ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00074','Charlton Warrell','21/5/1970','018-0077662','cwarrell3e@unicef.org','Female','21655 Bluestem Plaza ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00075','Aylmer Huggill','16/4/1981','011-71892699','ahuggill3f@state.tx.us','Female','6167 Eagan Crossing ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00076','Raynard Allflatt','27/2/1980','019-1840929','rallflatt3g@nhs.uk','Male','030 Marcy Hill ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00077','Goober Fleckney','4/12/1980','011-30237765','gfleckney3h@altervista.org','Female','7 Center Drive ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00078','Stacee Haselup','2/11/1976','018-1340550','shaselup3i@facebook.com','Female','6 North Park ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00079','Babette Hazley','26/5/1975','014-3658309','bhazley3j@aol.com','Female','03784 Di Loreto Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00080','Anny Liddall','4/4/1970','011-65811015','aliddall3k@mozilla.org','Male','6143 Granby Lane ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00081','Gunar Aikman','11/9/1983','011-08050352','gaikman3l@live.com','Male','775 Gina Way ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00082','Reeva Burland','9/11/1995','019-1316702','rburland3m@google.fr','Female','70 Cordelia Place ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00083','Rik Parsonage','29/3/1982','016-0086620','rparsonage3n@bandcamp.com','Male','6551 Hudson Plaza ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00084','Meggi Axup','18/4/1968','018-9799885','maxup3o@hostgator.com','Male','46 Pond Trail ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00085','Barbara-anne McCane','25/10/1971','011-98469590','bmccane3p@bizjournals.com','Female','53289 Texas Junction ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00086','Mitchel Aishford','30/1/1984','011-86486234','maishford3q@cisco.com','Male','9 Artisan Way ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00087','Reinald Nafzger','16/9/1990','011-87035909','rnafzger3r@sphinn.com','Female','59910 Haas Street ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00088','Prescott Vigours','6/9/1983','011-41288777','pvigours3s@topsy.com','Male','4 Transport Plaza ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00089','Letti Goretti','20/2/1967','017-1233057','lgoretti3t@infoseek.co.jp','Female','08683 Evergreen Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00090','Cissy Barrar','20/6/1991','019-1065820','cbarrar3u@icio.us','Male','68721 4th Parkway ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00091','Pepi Chaudret','22/8/1996','011-25392928','pchaudret3v@weebly.com','Female','4 Lawn Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00092','Viviyan Gersam','7/3/1996','018-1044230','vgersam3w@google.pl','Male','2563 Buhler Street ,50000 ,Kuala Lumpur ,Selangor','POS0020',2400);
INSERT INTO Employee VALUES ('EMP00093','Saw Burgise','13/1/1989','011-56742820','sburgise3x@nydailynews.com','Female','23 Roth Lane ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00094','Othilia Polino','8/8/1992','011-66640017','opolino3y@ca.gov','Female','604 Acker Plaza ,50050 ,Kuala Lumpur ,Selangor','POS0022',2400);
INSERT INTO Employee VALUES ('EMP00095','Lorena Petyanin','28/1/1978','019-5108878','lpetyanin3z@studiopress.com','Female','6 Eagan Parkway ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00096','Nevins Durn','8/1/1980','011-44419637','ndurn40@webeden.co.uk','Female','77 Straubel Crossing ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00097','Alister Hessay','25/9/1973','019-0545959','ahessay41@jimdo.com','Male','7 Golf View Plaza ,50000 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00098','Evanne McLachlan','11/1/1990','018-3173851','emclachlan42@arstechnica.com','Female','3 Cherokee Avenue ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00099','Fabien Hawkeridge','24/1/1991','017-7108696','fhawkeridge43@weebly.com','Male','9008 Messerschmidt Plaza ,50050 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00100','Rebekah Abilowitz','24/1/1984','011-33405846','rabilowitz44@bloglovin.com','Male','570 Hayes Street ,50000 ,Kuala Lumpur ,Selangor','POS0019',2400);
INSERT INTO Employee VALUES ('EMP00101','Adriana Van den Oord','23/5/1995','018-9919197','avan45@squidoo.com','Female','0 6th Alley ,50050 ,Kuala Lumpur ,Selangor','POS0021',2400);
INSERT INTO Employee VALUES ('EMP00102','Rozele Buckthorpe','22/10/1992','019-1843165','rbuckthorpe0@ca.gov','Female','8964 Fallview Place ,50000 ,Kuala Lumpur ,Selangor','POS0013',7000);
INSERT INTO Employee VALUES ('EMP00103','Olive Acreman','30/9/1985','011-92147794','oacreman1@hibu.com','Male','6 Kensington Hill ,50000 ,Kuala Lumpur ,Selangor','POS0014',7000);
INSERT INTO Employee VALUES ('EMP00104','Kat Peperell','30/10/1971','019-7094429','kpeperell2@studiopress.com','Male','52 Melvin Plaza ,50050 ,Kuala Lumpur ,Selangor','POS0013',9000);
INSERT INTO Employee VALUES ('EMP00105','Chanda Guilloton','23/4/1981','014-4968182','cguilloton3@acquirethisname.com','Female','78 Shopko Trail ,50000 ,Kuala Lumpur ,Selangor','POS0008',7000);
INSERT INTO Employee VALUES ('EMP00106','Ranice Rickaby','1/6/1993','016-7043184','rrickaby4@virginia.edu','Male','61095 3rd Lane ,50000 ,Kuala Lumpur ,Selangor','POS0001',8000);
INSERT INTO Employee VALUES ('EMP00107','Jessey Lohmeyer','9/6/1967','018-7007618','jlohmeyer5@purevolume.com','Female','016 Vernon Place ,50050 ,Kuala Lumpur ,Selangor','POS0015',7000);
INSERT INTO Employee VALUES ('EMP00108','Hedda Dumberell','4/4/1979','018-1312894','hdumberell6@wordpress.org','Male','06 Forest Run Road ,50050 ,Kuala Lumpur ,Selangor','POS0008',7000);
INSERT INTO Employee VALUES ('EMP00109','Prince Excell','5/11/1994','019-3528661','pexcell7@oracle.com','Female','89 Vermont Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0010',7000);
INSERT INTO Employee VALUES ('EMP00110','Matty Atheis','24/4/1970','011-85452960','matheis8@sfgate.com','Male','94641 Nelson Trail ,50050 ,Kuala Lumpur ,Selangor','POS0009',8000);
INSERT INTO Employee VALUES ('EMP00111','Dyane Kinghorne','10/4/1976','013-4668022','dkinghorne9@youtu.be','Female','61216 7th Point ,50000 ,Kuala Lumpur ,Selangor','POS0013',8000);
INSERT INTO Employee VALUES ('EMP00112','Ava Klaves','21/9/1988','011-71018651','aklavesa@opera.com','Male','384 Granby Court ,50050 ,Kuala Lumpur ,Selangor','POS0005',8000);
INSERT INTO Employee VALUES ('EMP00113','Stanford Coard','12/10/1987','011-52461797','scoardb@wikia.com','Female','614 Everett Pass ,50050 ,Kuala Lumpur ,Selangor','POS0003',9000);
INSERT INTO Employee VALUES ('EMP00114','Slade McTiernan','2/8/1992','011-04797275','smctiernanc@bluehost.com','Male','91267 Havey Center ,50000 ,Kuala Lumpur ,Selangor','POS0016',9000);
INSERT INTO Employee VALUES ('EMP00115','Carree Marden','20/1/1972','019-6886326','cmardend@wikispaces.com','Male','487 Corben Trail ,50050 ,Kuala Lumpur ,Selangor','POS0001',9000);
INSERT INTO Employee VALUES ('EMP00116','Hannis Dornan','15/10/1981','010-1052448','hdornane@flickr.com','Male','82009 Mayer Court ,50050 ,Kuala Lumpur ,Selangor','POS0014',9000);
INSERT INTO Employee VALUES ('EMP00117','Jenni Hatfield','23/8/1973','019-1146140','jhatfieldf@army.mil','Female','7050 Cherokee Alley ,50050 ,Kuala Lumpur ,Selangor','POS0010',9000);
INSERT INTO Employee VALUES ('EMP00118','Elfrida Burds','26/12/1991','019-9944949','eburdsg@statcounter.com','Female','9058 Mayer Place ,50000 ,Kuala Lumpur ,Selangor','POS0012',8000);
INSERT INTO Employee VALUES ('EMP00119','Johnathon Chappell','26/10/1990','019-9665022','jchappellh@ycombinator.com','Male','3 Loftsgordon Circle ,50000 ,Kuala Lumpur ,Selangor','POS0012',7000);
INSERT INTO Employee VALUES ('EMP00120','Arlene Peracco','31/10/1991','011-88411067','aperaccoi@reverbnation.com','Female','156 Morningstar Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0007',9000);
INSERT INTO Employee VALUES ('EMP00121','Westleigh Mazzia','8/8/1982','011-46351306','wmazziaj@elegantthemes.com','Female','8 Lukken Drive ,50050 ,Kuala Lumpur ,Selangor','POS0011',8000);
INSERT INTO Employee VALUES ('EMP00122','Corny Tyrie','18/9/1985','019-2065981','ctyriek@wikipedia.org','Male','808 Sommers Pass ,50000 ,Kuala Lumpur ,Selangor','POS0002',8000);
INSERT INTO Employee VALUES ('EMP00123','Rolph Quinsee','26/3/1980','011-08382274','rquinseel@myspace.com','Male','65856 Mcbride Road ,50000 ,Kuala Lumpur ,Selangor','POS0016',9000);
INSERT INTO Employee VALUES ('EMP00124','Maris Coathup','24/7/1981','018-1725515','mcoathupm@berkeley.edu','Male','564 Autumn Leaf Avenue ,50000 ,Kuala Lumpur ,Selangor','POS0017',8000);
INSERT INTO Employee VALUES ('EMP00125','Paloma Chastey','19/5/1981','011-57761024','pchasteyn@nba.com','Female','67253 Farmco Drive ,50000 ,Kuala Lumpur ,Selangor','POS0018',8000);
INSERT INTO Employee VALUES ('EMP00126','Jenna Adamolli','4/1/1996','016-1124238','jadamollio@theatlantic.com','Male','7 Rowland Point ,50000 ,Kuala Lumpur ,Selangor','POS0006',8000);
INSERT INTO Employee VALUES ('EMP00127','Mariann Follit','22/1/1992','019-1598270','mfollitp@example.com','Female','3 Russell Way ,50000 ,Kuala Lumpur ,Selangor','POS0003',9000);
INSERT INTO Employee VALUES ('EMP00128','Annabella Coatts','24/6/1986','019-4888337','acoattsq@ask.com','Female','62162 Northwestern Circle ,50000 ,Kuala Lumpur ,Selangor','POS0014',9000);
INSERT INTO Employee VALUES ('EMP00129','Mirna Dammarell','18/2/1997','018-8235011','mdammarellr@lycos.com','Male','0304 Granby Circle ,50000 ,Kuala Lumpur ,Selangor','POS0005',7000);
INSERT INTO Employee VALUES ('EMP00130','Adriano Sowrah','13/8/1970','011-78546942','asowrahs@drupal.org','Male','58 Judy Court ,50050 ,Kuala Lumpur ,Selangor','POS0015',9000);
INSERT INTO Employee VALUES ('EMP00131','Horace Marzelle','20/3/1975','011-07942159','hmarzellet@phpbb.com','Female','366 Warrior Center ,50000 ,Kuala Lumpur ,Selangor','POS0006',8000);
INSERT INTO Employee VALUES ('EMP00132','Brigit Carp','30/8/1980','011-22342434','bcarpu@g.co','Male','03862 Monterey Center ,50000 ,Kuala Lumpur ,Selangor','POS0016',7000);
INSERT INTO Employee VALUES ('EMP00133','Daile Brothwood','7/12/1980','019-2750720','dbrothwoodv@si.edu','Female','514 Artisan Lane ,50000 ,Kuala Lumpur ,Selangor','POS0006',7000);
INSERT INTO Employee VALUES ('EMP00134','Jaymee Cauldwell','3/1/1975','018-1221106','jcauldwellw@51.la','Male','8 Meadow Vale Park ,50050 ,Kuala Lumpur ,Selangor','POS0011',9000);
INSERT INTO Employee VALUES ('EMP00135','Abigale Trahear','21/1/1997','019-1674137','atrahearx@blinklist.com','Male','9 Packers Trail ,50050 ,Kuala Lumpur ,Selangor','POS0009',9000);
INSERT INTO Employee VALUES ('EMP00136','Stacie Christensen','3/9/1972','011-81962129','schristenseny@netlog.com','Female','31237 Morning Way ,50000 ,Kuala Lumpur ,Selangor','POS0012',9000);
INSERT INTO Employee VALUES ('EMP00137','Meggi Edelmann','12/3/1985','011-83353397','medelmannz@amazon.com','Female','39 Lindbergh Alley ,50050 ,Kuala Lumpur ,Selangor','POS0017',8000);
INSERT INTO Employee VALUES ('EMP00138','Rawley Jochen','2/1/1985','017-3485546','rjochen10@sourceforge.net','Male','12 Lindbergh Place ,50050 ,Kuala Lumpur ,Selangor','POS0005',9000);
INSERT INTO Employee VALUES ('EMP00139','Anestassia Jaszczak','18/12/1969','018-8428892','ajaszczak11@si.edu','Male','628 Sunbrook Circle ,50000 ,Kuala Lumpur ,Selangor','POS0008',7000);
INSERT INTO Employee VALUES ('EMP00140','Annabela Axup','19/2/1974','011-18002359','aaxup12@woothemes.com','Male','62 Nobel Circle ,50000 ,Kuala Lumpur ,Selangor','POS0001',9000);
INSERT INTO Employee VALUES ('EMP00141','Cosme Fysh','14/6/1980','017-7083823','cfysh13@xinhuanet.com','Male','9717 Cordelia Pass ,50050 ,Kuala Lumpur ,Selangor','POS0013',9000);
INSERT INTO Employee VALUES ('EMP00142','Shelbi Peddie','26/5/1980','019-5899025','speddie14@wunderground.com','Female','05 Arrowood Park ,50050 ,Kuala Lumpur ,Selangor','POS0013',8000);
INSERT INTO Employee VALUES ('EMP00143','Gene Tanti','9/10/1974','011-51687523','gtanti15@si.edu','Female','400 Washington Alley ,50050 ,Kuala Lumpur ,Selangor','POS0015',7000);
INSERT INTO Employee VALUES ('EMP00144','Eb Plummer','21/10/1987','019-9800922','eplummer16@cbslocal.com','Female','46633 Morning Alley ,50000 ,Kuala Lumpur ,Selangor','POS0014',7000);
INSERT INTO Employee VALUES ('EMP00145','Mikel Duffy','30/8/1993','017-3101582','mduffy17@china.com.cn','Female','13849 La Follette Place ,50000 ,Kuala Lumpur ,Selangor','POS0002',9000);
INSERT INTO Employee VALUES ('EMP00146','Broderick Prichard','3/12/1982','011-20871951','bprichard18@msu.edu','Male','01 Rigney Alley ,50050 ,Kuala Lumpur ,Selangor','POS0010',9000);
INSERT INTO Employee VALUES ('EMP00147','Persis Cristofaro','7/10/1992','011-61454703','pcristofaro19@nytimes.com','Male','9 5th Point ,50000 ,Kuala Lumpur ,Selangor','POS0011',9000);
INSERT INTO Employee VALUES ('EMP00148','Tildy Yurasov','7/11/1973','011-05775779','tyurasov1a@blog.com','Male','7 Karstens Park ,50050 ,Kuala Lumpur ,Selangor','POS0012',9000);
INSERT INTO Employee VALUES ('EMP00149','Gladys Kidman','9/5/1980','018-0115677','gkidman1b@techcrunch.com','Male','616 Drewry Crossing ,50000 ,Kuala Lumpur ,Selangor','POS0005',9000);
INSERT INTO Employee VALUES ('EMP00150','Orsa Cosely','28/1/1978','017-8072095','ocosely1c@admin.ch','Male','893 Lighthouse Bay Circle ,50050 ,Kuala Lumpur ,Selangor','POS0017',7000);
INSERT INTO Employee VALUES ('EMP00151','Bond Cunnow','8/10/1970','011-72523035','bcunnow1d@washingtonpost.com','Male','0315 Towne Crossing ,50050 ,Kuala Lumpur ,Selangor','POS0014',9000);

select count(*) as TotalEmployeeRecords from Employee;