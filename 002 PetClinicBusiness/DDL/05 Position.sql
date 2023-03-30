ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
SET LINESIZE 120
SET PAGESIZE 100


CREATE TABLE Position(
   position_id    VARCHAR(7)   NOT NULL PRIMARY KEY,
   title          VARCHAR(27)  NOT NULL,
   type           VARCHAR(6)  NOT NULL,
   demand         NUMBER(2),
   position_desc  VARCHAR(365) NOT NULL,
   min_req	      VARCHAR(30) NOT NULL,
   CONSTRAINT position_chk_min_req CHECK (UPPER(min_req) IN ('BACHELOR DEGREE','MASTER DEGREE','DOCTORATE','SPM')),
   CONSTRAINT position_chk_position_id CHECK (REGEXP_LIKE(position_id, '^POS\d{4}$'))
);

INSERT INTO Position VALUES ('POS0001','Anesthesia and analgesia','doctor',10,'Veterinary anesthesiologists are highly skilled at managing pain and minimizing the risk of complications. They tailor a plan specifically to each animal, anticipate and address problems during surgery, and carefully monitor patients after the procedure.','MASTER DEGREE');
INSERT INTO Position VALUES ('POS0002','Behavioral medicine','doctor',15,'These professionals see patients with needs that go beyond basic obedience issues, so they must be able to take detailed histories and identify the most relevant facts. If necessary, a behaviorist will determine a medication protocol as part of the animal’s treatment plan.','MASTER DEGREE');
INSERT INTO Position VALUES ('POS0003','Clinical pharmacology','doctor',15,'They are educated in drug development, proper usage, and how medications interact. Veterinary clinical pharmacologists help ensure animals receive safe, effective treatment.','MASTER DEGREE');
INSERT INTO Position VALUES ('POS0004','Dentistry','doctor',5,'They qualified to clean, adjust, and extract teeth as well as perform any necessary oral surgery.','DOCTORATE');
INSERT INTO Position VALUES ('POS0005','Dermatology','doctor',7,'The skin diseases animals experience vary significantly by species, so veterinary dermatologists need to have experience in many different types of treatments. They also receive training in internal medicine, immunology, and allergy since some dermatological issues stem from a health problem within.','DOCTORATE');
INSERT INTO Position VALUES ('POS0006','Emergency and critical care','doctor',9,'Veterinarian Holding a RabbitWhen animals become injured or suddenly develop a life-threatening health problem, they need prompt medical attention. No matter the emergency, they’re equipped to act swiftly and ensure the animal in question gets the immediate attention it needs.','DOCTORATE');
INSERT INTO Position VALUES ('POS0007','Internal medicine','doctor',2,'They are highly trained veterinarians who treat uncommon or complicated diseases. They specialize in the assessment, diagnosis, and treatment of diseases of cats'' and dogs'' internal systems, such as such as liver, kidney, gastrointestinal tract, and lung/airway. To obtain an accurate diagnosis, specialized diagnostic testing is often required.','DOCTORATE');
INSERT INTO Position VALUES ('POS0008','Laboratory animal medicine','doctor', 6,'Even animals used in laboratory settings needs proper care and attention. So they are the one who ensure this is the case by working in a number of roles. They may direct animal resource programs, consult other science professionals on appropriate care and use of animals, conduct research, and more.','DOCTORATE');
INSERT INTO Position VALUES ('POS0009','Microbiology','doctor',5,'Veterinary microbiologists are often the driving force behind developing treatments for infectious animal diseases. They typically work in a lab setting to research bacteria, parasites, and other microorganisms that cause disease. Because some diseases can affect both animals and humans, veterinary microbiologists play a crucial role in protecting public health.','DOCTORATE');
INSERT INTO Position VALUES ('POS0010','Nutrition','doctor',3,'They receive education and training in manage animals diet. They may work with healthy patients, but they also develop nutrition plans for sick animals to help manage their ailments.','MASTER DEGREE');
INSERT INTO Position VALUES ('POS0011','Ophthalmology','doctor',2,'The eye specialists of the animal world, veterinary ophthalmologists treat eye diseases outside the scope of a regular veterinarian’s expertise. They conduct exams, perform surgeries, and consult with other veterinarians to help prevent issues before they begin.', 'BACHELOR DEGREE');
INSERT INTO Position VALUES ('POS0012','Pathology','doctor',7,'Not every medical issue can be identified through routine exams and tests. Sometimes, veterinary pathologists are called upon to make a diagnosis by examining tissue or fluid samples. Veterinary pathologists are also heavily involved in research and developing effective medications.', 'BACHELOR DEGREE');
INSERT INTO Position VALUES ('POS0013','Food Animal Veterinarians','doctor',9,'They are responsible for the care of animals that are raised for food production and human consumption. They provide medical care consisting of research, diagnoses, and prevention.','MASTER DEGREE');
INSERT INTO Position VALUES ('POS0014','Poultry Veterinarian','doctor',10,'They ensures the health and well-being of poultry — particularly domestic fowl such as chickens, ducks, and turkeys, which are raised and bred as livestock.','MASTER DEGREE');
INSERT INTO Position VALUES ('POS0015','Veterinary radiologists','doctor',4,'They specialize in the field of diagnostic imaging. They are experts at reviewing images or disease revealed on radiographic ultrasonographic, CT, MRI and nuclear medicine studies.','MASTER DEGREE');
INSERT INTO Position VALUES ('POS0016','Veterinary surgeons','doctor',6,'Routine surgeries like spays and neuters are part of any veterinarian’s repertoire especially difficult or complex surgeries. Other than that, veterinary surgeons also have access to equipment, facilities, and support staff that may not be available to general practice veterinarians.', 'BACHELOR DEGREE');
INSERT INTO Position VALUES ('POS0017','Theriogenology','doctor',5,'Theriogenologists are experts in animal reproductive health. They practice responsible breeding, performing everything from routine pregnancy checks to corrective surgical procedures. They are particularly important for managing agriculture and protected species populations.', 'BACHELOR DEGREE');
INSERT INTO Position VALUES ('POS0018','Toxicology','doctor',11,'Veterinary toxicologists are doing important work to identify harmful substances in our products and environment, determine effective treatments for poisoned animals, and educate other veterinary professionals about potential threats. They work in numerous settings and play a vital role in promoting public health.', 'BACHELOR DEGREE');
INSERT INTO Position VALUES ('POS0019','Cleaner','crew',40,'Ensure the clinic is clean, wash the lodge.', 'SPM');
INSERT INTO Position VALUES ('POS0020','Care taker','crew',50,'Take care of the pet in lodge, play with the pet, make the lodge report to track the health of the pet.', 'SPM');
INSERT INTO Position VALUES ('POS0021','Assistant','crew',50,'Assist doctor.', 'BACHELOR DEGREE');
INSERT INTO Position VALUES ('POS0022','Cashier','crew',30,'Manage the transaction for the product.', 'SPM');

select count(*) as TotalPositionRecords from Position;
