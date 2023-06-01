
-- 编写一存储过程，自动安排某个连续期间的大夜班的值班表:

CREATE OR REPLACE PROCEDURE sp_night_shift_arrange(IN start_date DATE, IN end_date DATE)
AS
DECLARE 
    zhuguan BOOLEAN := FALSE;
    CURSOR doctor_cursor FOR SELECT e_name FROM employee WHERE e_type IN (1, 2) ORDER BY e_id;
    CURSOR nurse_cursor FOR SELECT e_name FROM employee WHERE e_type = 3 ORDER BY e_id;
    currentdate DATE := start_date;
    doctor_name CHAR(30);
    nurse1_name CHAR(30);
    nurse2_name CHAR(30);
BEGIN
    OPEN doctor_cursor;
    OPEN nurse_cursor;
    WHILE currentdate <= end_date LOOP
        IF zhuguan = TRUE AND EXTRACT(DOW FROM currentdate) = 1 THEN
            zhuguan := FALSE;
            doctor_name := (SELECT e_name FROM employee WHERE e_type = 1);
        ELSE
            FETCH NEXT FROM doctor_cursor INTO doctor_name;
            IF NOT FOUND THEN 
                CLOSE doctor_cursor;
                OPEN doctor_cursor;
                FETCH NEXT FROM doctor_cursor INTO doctor_name;
            END IF;
        END IF; 
        
        FETCH NEXT FROM nurse_cursor INTO nurse1_name;
        IF NOT FOUND THEN
            CLOSE nurse_cursor;
            OPEN nurse_cursor;
            FETCH NEXT FROM nurse_cursor INTO nurse1_name;
        END IF;
        FETCH NEXT FROM nurse_cursor INTO nurse2_name;
        IF NOT FOUND THEN
            CLOSE nurse_cursor;
            OPEN nurse_cursor;
            FETCH NEXT FROM nurse_cursor INTO nurse2_name;
        END IF;
        IF doctor_name = (SELECT e_name FROM employee WHERE e_type = 1) AND EXTRACT(DOW FROM currentdate) IN (0,6) THEN
            zhuguan := TRUE;
            FETCH NEXT FROM doctor_cursor INTO doctor_name;
            IF NOT FOUND THEN 
                CLOSE doctor_cursor;
                OPEN doctor_cursor;
                FETCH NEXT FROM doctor_cursor INTO doctor_name;
            END IF;
        END IF;
        
        INSERT INTO night_shift_schedule(n_date,n_doctor_name,n_nurse1_name,n_nurse2_name) VALUES(currentdate,doctor_name,nurse1_name,nurse2_name);
        currentdate := currentdate + INTERVAL '1 day';
    END LOOP;
    CLOSE doctor_cursor;
    CLOSE nurse_cursor;
END;


/*  end  of  your code  */ 
