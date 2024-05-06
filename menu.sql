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
        DBMS_OUTPUT.PUT('Enter your choice: ');
        -- Accept user input
        ACCEPT choice NUMBER FORMAT '9' DEFAULT 3;
        
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

                
            ELSE
                DBMS_OUTPUT.PUT_LINE('Invalid choice! Please select again.');
        END CASE;
    END LOOP;
END;