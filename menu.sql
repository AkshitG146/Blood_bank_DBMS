SET SERVEROUTPUT ON

DECLARE
    choice NUMBER;

BEGIN
    LOOP
        -- Display the menu
        DBMS_OUTPUT.PUT_LINE('MENU');
        DBMS_OUTPUT.PUT_LINE('1. Donors available for a particular patient');
        DBMS_OUTPUT.PUT_LINE('2. Blood Bank Available for a particular patient');
        DBMS_OUTPUT.PUT_LINE('3. Blood Bank Available for a particular patient’s place');
        DBMS_OUTPUT.PUT_LINE('4. Blood Bag’s quantity in different Blood Bank of a particular blood group');
        DBMS_OUTPUT.PUT_LINE('5. Quantity of Blood Group in a particular Blood Bank');
        DBMS_OUTPUT.PUT_LINE('6. Blood Banks with a desired blood group with quantity');
        DBMS_OUTPUT.PUT_LINE('7. Quantity of a desired blood group in a desired blood bank');
        DBMS_OUTPUT.PUT_LINE('8. Donors available donated before a particular date of a desired blood group');
        DBMS_OUTPUT.PUT_LINE('9. Donors with blood banks available donated before a particular date of a desired blood
group');
        DBMS_OUTPUT.PUT_LINE('10. Exit');
        DBMS_OUTPUT.PUT('Enter your choice: ');
        -- Accept user input
        ACCEPT choice NUMBER FORMAT '9' DEFAULT 10;
        
        -- Perform actions based on user choice
        CASE choice
            WHEN 1 THEN
                -- Action for Option 1
                DBMS_OUTPUT.PUT_LINE('You selected Option 1');
                                   SET SERVEROUTPUT ON
                                    
                                    DECLARE
                                        PROCEDURE donars_for_particular_patient (pid IN Patient.patient_id%type) IS 
                                        BEGIN 
                                            DBMS_OUTPUT.PUT_LINE('List of donors for patient id no. ' || pid);
                                            DBMS_OUTPUT.PUT_LINE('----------------------------------------');
                                            
                                             FOR cursor1 IN (select donar_id,donar_name,blood_group,donar_contact_no from Donar where donar_id in (select donar_id from Donate where donar_id in (select donar_id from Donar where blood_group in (select blood_group from Patient where patient_id=pid)) )) 
                                            LOOP
                                                DBMS_OUTPUT.PUT_LINE('Donor name: ' || cursor1.donar_name ||
                                                                       ', blood group: ' || cursor1.blood_group ||
                                                                       ', contact no: ' || cursor1.donar_contact_no);
                                            END LOOP;
                                            
                                            DBMS_OUTPUT.PUT_LINE('_________________________________________');
                                        END donars_for_particular_patient;
                                    BEGIN
                                        -- Call the procedure with a specific patient ID
                                        donars_for_particular_patient(1001); -- Replace 1 with the patient ID you want to query
                                    END;
            WHEN 2 THEN
                -- Action for Option 2
                DBMS_OUTPUT.PUT_LINE('You selected Option 2');
                            SET SERVEROUTPUT ON

                            DECLARE
                                PROCEDURE banks_available_for_patient (pid IN Patient.patient_id%type) IS 
                                BEGIN 
                                    DBMS_OUTPUT.PUT_LINE('List of blood banks for patient id no. '||pid);
                                    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
                                    
                                    FOR cursor1 IN (SELECT blood_bank_id, blood_bank_name, blood_bank_contact_no FROM BloodBank WHERE blood_bank_id IN (SELECT blood_bank_id FROM Donate WHERE donar_id IN (SELECT donar_id FROM Donar WHERE blood_group IN (SELECT blood_group FROM Patient WHERE patient_id = pid))))
                                    LOOP
                                        DBMS_OUTPUT.PUT_LINE('ID: ' || cursor1.blood_bank_id ||
                                                        ', Blood Bank Name: ' || cursor1.blood_bank_name||
                                                        ', Contact No: ' || cursor1.blood_bank_contact_no);
                                    END LOOP;
                                    
                                    DBMS_OUTPUT.PUT_LINE('_________________________________________');    
                                END banks_available_for_patient;
                            BEGIN
                                -- Call the procedure with a specific patient ID
                                banks_available_for_patient(1001); -- Replace 1001 with the patient ID you want to query
                            END;
                            /
            WHEN 3 THEN
               
                DBMS_OUTPUT.PUT_LINE('You selected Option 3');
                                    SET SERVEROUTPUT ON

                                    DECLARE
                                        PROCEDURE bank_in_patients_place (pid IN Patient.patient_id%type) IS
                                        BEGIN
                                            DBMS_OUTPUT.PUT_LINE('List of blood banks for patient id no.' || pid || ' in his/her place');
                                            DBMS_OUTPUT.PUT_LINE('----------------------------------------');
                                            
                                            FOR cursor1 IN (SELECT bb.blood_bank_id, bb.blood_bank_name, bb.blood_bank_contact_no
                                                            FROM BloodBank bb
                                                            JOIN Donate d ON bb.blood_bank_id = d.blood_bank_id
                                                            JOIN Donar dn ON d.donar_id = dn.donar_id
                                                            WHERE dn.blood_group = (SELECT blood_group FROM Patient WHERE patient_id = pid)
                                                            AND bb.blood_bank_address = (SELECT patient_address FROM Patient WHERE patient_id = pid))
                                            LOOP
                                                DBMS_OUTPUT.PUT_LINE('ID: ' || cursor1.blood_bank_id ||
                                                                ', Blood Bank Name: ' || cursor1.blood_bank_name ||
                                                                ', Contact No: ' || cursor1.blood_bank_contact_no);
                                            END LOOP;
                                            
                                            DBMS_OUTPUT.PUT_LINE('_________________________________________');
                                        END bank_in_patients_place;
                                    BEGIN
                                        -- Call the procedure with a specific patient ID
                                        bank_in_patients_place(1001); -- Replace 1001 with the patient ID you want to query
                                    END;
                                    /

                
            WHEN 4 THEN
                    -- Action for Option 4
                    DBMS_OUTPUT.PUT_LINE('You selected Option 4');
                                        CREATE OR REPLACE PROCEDURE GetBloodBagsQuantity (
                                            blood_group_param IN VARCHAR2,
                                            bags_quantity OUT SYS_REFCURSOR
                                        ) AS
                                        BEGIN
                                            OPEN bags_quantity FOR
                                            SELECT BloodBank.blood_bank_name, SUM(Blood.packets) AS total_bags_quantity
                                            FROM Blood
                                            INNER JOIN BloodBank ON Blood.blood_bank_id = BloodBank.blood_bank_id
                                            WHERE Blood.b_group = blood_group_param
                                            GROUP BY BloodBank.blood_bank_name;
                                        END;
                                        /

                                        DECLARE
                                            blood_group_param VARCHAR2(5) := 'A+';
                                            bags_quantity_cursor SYS_REFCURSOR;
                                            bank_name BloodBank.blood_bank_name%TYPE;
                                            total_bags INTEGER;
                                        BEGIN
                                            GetBloodBagsQuantity(blood_group_param => blood_group_param, bags_quantity => bags_quantity_cursor);
                                            LOOP
                                                FETCH bags_quantity_cursor INTO bank_name, total_bags;
                                                EXIT WHEN bags_quantity_cursor%NOTFOUND;
                                                DBMS_OUTPUT.PUT_LINE('Blood Bank: ' || bank_name || ', Total Bags: ' || total_bags);
                                            END LOOP;
                                            CLOSE bags_quantity_cursor;
                                        END;
                                        /
                WHEN 5 THEN
                    -- Action for Option 5
                    DBMS_OUTPUT.PUT_LINE('You selected Option 5');
                                        CREATE OR REPLACE PROCEDURE GetBloodGroupQuantity (
                                            blood_bank_id_param IN INTEGER,
                                            blood_group_param IN VARCHAR2,
                                            group_quantity OUT INTEGER
                                        ) AS
                                        BEGIN
                                            SELECT SUM(packets) INTO group_quantity
                                            FROM Blood
                                            WHERE blood_bank_id = blood_bank_id_param
                                            AND b_group = blood_group_param;
                                        END;
                                        /

                                        DECLARE
                                            blood_bank_id_param INTEGER := 1; -- Specify the blood bank ID
                                            blood_group_param VARCHAR2(5) := 'A+'; -- Specify the blood group
                                            group_quantity INTEGER;
                                        BEGIN
                                            -- Call the procedure
                                            GetBloodGroupQuantity(blood_bank_id_param => blood_bank_id_param, blood_group_param => blood_group_param, group_quantity => group_quantity);
                                            
                                            -- Display the result
                                            DBMS_OUTPUT.PUT_LINE('Quantity of Blood Group ' || blood_group_param || ' in Blood Bank ' || blood_bank_id_param || ': ' || group_quantity);
                                        END;
                                        /
                WHEN 6 THEN
                    -- Action for Option 6
                    DBMS_OUTPUT.PUT_LINE('You selected Option 6');
                                                    CREATE OR REPLACE PROCEDURE GetBloodBanksWithQuantity (
                                                        blood_group_param IN VARCHAR2,
                                                        blood_banks_cursor OUT SYS_REFCURSOR
                                                    ) AS
                                                    BEGIN
                                                        OPEN blood_banks_cursor FOR
                                                        SELECT bb.blood_bank_id, bb.blood_bank_name, SUM(b.packets) AS total_quantity
                                                        FROM Blood b
                                                        JOIN BloodBank bb ON b.blood_bank_id = bb.blood_bank_id
                                                        WHERE b.b_group = blood_group_param
                                                        GROUP BY bb.blood_bank_id, bb.blood_bank_name;
                                                    END;
                                                    /
                                                    DECLARE
                                                        blood_group_param VARCHAR2(5) := 'A+'; -- Specify the desired blood group
                                                        blood_banks_cursor SYS_REFCURSOR;
                                                        bank_id BloodBank.blood_bank_id%TYPE;
                                                        bank_name BloodBank.blood_bank_name%TYPE;
                                                        total_quantity INTEGER;
                                                    BEGIN
                                                        -- Call the procedure
                                                        GetBloodBanksWithQuantity(blood_group_param => blood_group_param, blood_banks_cursor => blood_banks_cursor);
                                                        
                                                        -- Fetch and display the results
                                                        LOOP
                                                            FETCH blood_banks_cursor INTO bank_id, bank_name, total_quantity;
                                                            EXIT WHEN blood_banks_cursor%NOTFOUND;
                                                            DBMS_OUTPUT.PUT_LINE('Blood Bank ID: ' || bank_id || ', Name: ' || bank_name || ', Total Quantity: ' || total_quantity);
                                                        END LOOP;
                                                        
                                                        -- Close the cursor
                                                        CLOSE blood_banks_cursor;
                                                    END;
                                                    /
                WHEN 7 THEN
                    -- Action for Option 7
                    DBMS_OUTPUT.PUT_LINE('You selected Option 7');
                                        CREATE OR REPLACE PROCEDURE GetBloodGroupQuantityInBank (
                                            blood_bank_id_param IN INTEGER,
                                            blood_group_param IN VARCHAR2,
                                            group_quantity OUT INTEGER
                                        ) AS
                                        BEGIN
                                            SELECT SUM(packets) INTO group_quantity
                                            FROM Blood
                                            WHERE blood_bank_id = blood_bank_id_param
                                            AND b_group = blood_group_param;
                                        END;
                                        /
                                        DECLARE
                                            blood_bank_id_param INTEGER := 1; -- Specify the blood bank ID
                                            blood_group_param VARCHAR2(5) := 'A+'; -- Specify the desired blood group
                                            group_quantity INTEGER;
                                        BEGIN
                                            -- Call the procedure
                                            GetBloodGroupQuantityInBank(blood_bank_id_param => blood_bank_id_param, blood_group_param => blood_group_param, group_quantity => group_quantity);
                                            
                                            -- Display the result
                                            DBMS_OUTPUT.PUT_LINE('Quantity of Blood Group ' || blood_group_param || ' in Blood Bank ' || blood_bank_id_param || ': ' || group_quantity);
                                        END;
                                        /

                    
                WHEN 8 THEN
                    -- Action for Option 8
                    DBMS_OUTPUT.PUT_LINE('You selected Option 8');
                                    CREATE OR REPLACE PROCEDURE GetDonorsByBloodGroupAndDate (
                                        blood_group_param IN VARCHAR2,
                                        donation_date_param IN DATE,
                                        donors_cursor OUT SYS_REFCURSOR
                                    ) AS
                                    BEGIN
                                        OPEN donors_cursor FOR
                                        SELECT d.*
                                        FROM Donar d
                                        INNER JOIN Donate dt ON d.donar_id = dt.donar_id
                                        WHERE d.blood_group = blood_group_param
                                        AND dt.date_of_donation < donation_date_param;
                                    END;
                                    /
                                    DECLARE
                                        blood_group_param VARCHAR2(5) := 'A+'; -- Specify the desired blood group
                                        donation_date_param DATE := TO_DATE('2022-01-01', 'YYYY-MM-DD'); -- Specify the particular date
                                        donors_cursor SYS_REFCURSOR;
                                        donor_id Donar.donar_id%TYPE;
                                        donor_name Donar.donar_name%TYPE;
                                        donor_blood_group Donar.blood_group%TYPE;
                                    BEGIN
                                        -- Call the procedure
                                        GetDonorsByBloodGroupAndDate(blood_group_param => blood_group_param, donation_date_param => donation_date_param, donors_cursor => donors_cursor);
                                        
                                        -- Fetch and display the results
                                        LOOP
                                            FETCH donors_cursor INTO donor_id, donor_name, donor_blood_group;
                                            EXIT WHEN donors_cursor%NOTFOUND;
                                            DBMS_OUTPUT.PUT_LINE('Donor ID: ' || donor_id || ', Name: ' || donor_name || ', Blood Group: ' || donor_blood_group);
                                        END LOOP;
                                        
                                        -- Close the cursor
                                        CLOSE donors_cursor;
                                    END;
                                    /

                WHEN 9 THEN
                    -- Action for Option 9
                    DBMS_OUTPUT.PUT_LINE('You selected Option 9');
                                        CREATE OR REPLACE PROCEDURE GetDonorsWithBloodBanks (
                                            blood_group_param IN VARCHAR2,
                                            donation_date_param IN DATE,
                                            donors_cursor OUT SYS_REFCURSOR
                                        ) AS
                                        BEGIN
                                            OPEN donors_cursor FOR
                                            SELECT d.donar_id, d.donar_name, d.blood_group, bb.blood_bank_name
                                            FROM Donar d
                                            JOIN Donate dt ON d.donar_id = dt.donar_id
                                            JOIN BloodBank bb ON dt.blood_bank_id = bb.blood_bank_id
                                            WHERE d.blood_group = blood_group_param
                                            AND dt.date_of_donation < donation_date_param;
                                        END;
                                        /
                                        DECLARE
                                            blood_group_param VARCHAR2(5) := 'A+'; -- Specify the desired blood group
                                            donation_date_param DATE := TO_DATE('2022-01-01', 'YYYY-MM-DD'); -- Specify the particular date
                                            donors_cursor SYS_REFCURSOR;
                                            donor_id Donar.donar_id%TYPE;
                                            donor_name Donar.donar_name%TYPE;
                                            donor_blood_group Donar.blood_group%TYPE;
                                            blood_bank_name BloodBank.blood_bank_name%TYPE;
                                        BEGIN
                                            -- Call the procedure
                                            GetDonorsWithBloodBanks(blood_group_param => blood_group_param, donation_date_param => donation_date_param, donors_cursor => donors_cursor);
                                            
                                            -- Fetch and display the results
                                            LOOP
                                                FETCH donors_cursor INTO donor_id, donor_name, donor_blood_group, blood_bank_name;
                                                EXIT WHEN donors_cursor%NOTFOUND;
                                                DBMS_OUTPUT.PUT_LINE('Donor ID: ' || donor_id || ', Name: ' || donor_name || ', Blood Group: ' || donor_blood_group || ', Blood Bank: ' || blood_bank_name);
                                            END LOOP;
                                            
                                            -- Close the cursor
                                            CLOSE donors_cursor;
                                        END;
                                        /

                WHEN 10 THEN
                    -- Exit the program
                    DBMS_OUTPUT.PUT_LINE('Exiting...');
                    EXIT;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Invalid choice! Please select again.');
        END CASE;
    END LOOP;
END;
/
END;