ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
SET LINESIZE 120
SET PAGESIZE 100

CREATE TABLE Disease(
   disease_id  VARCHAR(5)   NOT NULL PRIMARY KEY,
   title       VARCHAR(20)  NOT NULL,
   description VARCHAR(341) NOT NULL,
   species     VARCHAR(34)  NOT NULL,
   CONSTRAINT chk_disease_id CHECK (REGEXP_LIKE(disease_id, '^D\d{4}$'))
);
INSERT INTO Disease VALUES ('D0001','Kennel Cough','It is caused by a combination of viruses and bacteria, with common symptoms such as snotty nose and dry, hacking cough.','Canine');
INSERT INTO Disease VALUES ('D0002','Canine Influenza','A relatively new disease in dogs, it is caused by the canine influenza virus. Symptoms include coughing, fever and snotty nose, which are the same signs as kennel cough.','Canine');
INSERT INTO Disease VALUES ('D0003','Heartworms','It is spread by mosquitoes and can cause coughing, lethargy, difficulty breathiing, heart disease and death.','Canine, Feline');
INSERT INTO Disease VALUES ('D0004','Intestinal Parasites','Examples such as roundworms, hookworms, whipworms and tapeworms spread when dogs consume contaminated substances such as water and stool from other dogs. These parasites can cause malnutrition, diarrhea such as blood loss.','Canine, Feline');
INSERT INTO Disease VALUES ('D0005','Rabies','It is a virus infection which is spread by saliva, either by a bite from an infected animal or by saliva contaminating a skin wound.','Canine, Feline');
INSERT INTO Disease VALUES ('D0006','Ringworm','A skin infection caused by several types of fungi found in the soil and on the skin of humans and pets. It is usually a dry, scaly round area with a raised red bumpy border and a clear center.','Canine, Feline');
INSERT INTO Disease VALUES ('D0007','Tickborne Diseases','Examples include Lyme disease, tularemia, ehrlichiosis, and babesiosis, spread through the bite of an infected tick. It can lead to anaemia (blood loss), lameness, weakness, lethargy, organ failure and even death.','Canine, Feline');
INSERT INTO Disease VALUES ('D0008','Psittacosis','Better known as parrot fever, it is a bacterial illness that can happen from contact with infected bird faeces or with dust-buildup in bird cages. Symptoms include coughing, high fever and headache.','Bird');
INSERT INTO Disease VALUES ('D0009','Cryptococcosis','A fungal disease contracted when an individual inhales organisms found in bird droppings, especially from pigeons, that can cause pneumonia. It can lead to serious complications such as meningitis, espeically in people with weakened immune systems.','Bird');
INSERT INTO Disease VALUES ('D0010','Fin Rot','It is the result of a bacterial or fungal infection. Fin rot starts at the edge of the fins, and destroys more and more tissue until it reaches the fin base, which if it does, means the fish will enver be able to regenerate it''s fin. Symptoms include fin edges turning black or bown, fins fraying, and entire fin falling off in large chunks.','Fish');
INSERT INTO Disease VALUES ('D0011','Swim Bladder Disease','The disease maybe caused by intestinal parasites or by constipation induced by high nitrate levels from over feeding.','Fish');
INSERT INTO Disease VALUES ('D0012','Salmonellosis','Infection of this diseaseis caused by contact with surfaces contaminated with faeces. Symptoms include pain, diarrhea, vomiting and fever, with young children being at risk of more serious complications, including dehydration, meningitis, and sepsis (blood infection).','Canine, Feline, Reptile, Amphibian');

select count(*) as TotalDiseaseRecords from Disease;