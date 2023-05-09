
CREATE TABLE physical_metrics (
	id_no INT NOT NULL,
	age INT NOT NULL,
	gender VARCHAR NOT NULL,
	height_cm DECIMAL NOT NULL,
	weight_kg DECIMAL NOT NULL,
	body_fat_pct DECIMAL NOT NULL,
	diastolic DECIMAL NOT NULL,
	systolic DECIMAL NOT NULL, 
	PRIMARY KEY (id_no)
);

CREATE TABLE activity_metrics (
	id_no INT NOT NULL,
	gripForce DECIMAL NOT NULL,
	sit_and_bend_forward_cm DECIMAL NOT NULL,
	sit_ups_counts DECIMAL NOT NULL,
	broad_jump_cm DECIMAL NOT NUll, 
	ranking VARCHAR NOT NULL,
	PRIMARY KEY (id_no)
);


SELECT p.age,
	p.gender,
    p.height_cm,
    p.weight_kg,
    p.body_fat_pct,
    p.diastolic,
    p.systolic,
    a.gripForce,
    a.sit_and_bend_forward_cm,
    a.sit_ups_counts,
    a.broad_jump_cm,
    a.ranking
INTO body_performance
FROM physical_metrics AS p
LEFT JOIN activity_metrics AS a
ON p.ID_no = a.ID_no;

SELECT * 
FROM body_performance
LIMIT 10;