DECLARE 
    choice NUMBER := 1;
BEGIN 
    LOOP -- Display the menu 
        DBMS_OUTPUT.PUT_LINE('MENU'); 
        DBMS_OUTPUT.PUT_LINE('1. Donors available for a particular patient'); 
        DBMS_OUTPUT.PUT_LINE('2. Blood Bank Available for a particular patient'); 
        DBMS_OUTPUT.PUT_LINE('3. Blood Bank Available for a particular patient’s place'); 
        DBMS_OUTPUT.PUT_LINE('4. Blood Bag’s quantity in different Blood Bank of a particular blood group'); 
        DBMS_OUTPUT.PUT_LINE('5. Quantity of Blood Group in a particular Blood Bank'); 
        DBMS_OUTPUT.PUT_LINE('6. Blood Banks with a desired blood group with quantity'); 
        DBMS_OUTPUT.PUT_LINE('7. Option 7'); 
        DBMS_OUTPUT.PUT_LINE('8. Option 8'); 
        DBMS_OUTPUT.PUT_LINE('9. Option 9'); 
        DBMS_OUTPUT.PUT_LINE('10. Exit'); 
        DBMS_OUTPUT.PUT('Enter your choice: '); 
        -- Accept user input 
        -- ACCEPT choice NUMBER FORMAT '9' DEFAULT 10; 
        -- Perform actions based on user choice 
        CASE choice 
            WHEN 1 THEN -- Action for Option 1 
                DBMS_OUTPUT.PUT_LINE('You selected Option 1'); 
                -- SET SERVEROUTPUT ON 
                -- Call the procedure with a specific patient ID 
                donars_for_particular_patient(1001); -- Replace 1 with the patient ID you want to query 

            WHEN 2 THEN -- Action for Option 2 
                DBMS_OUTPUT.PUT_LINE('You selected Option 2'); 
                -- SET SERVEROUTPUT ON 
                -- Call the procedure with a specific patient ID 
                banks_available_for_patient(1001); -- Replace 1001 with the patient ID you want to query 

            WHEN 3 THEN 
                DBMS_OUTPUT.PUT_LINE('You selected Option 3'); 
                -- SET SERVEROUTPUT ON 
                -- Call the procedure with a specific patient ID 
                bank_in_patients_place(1001); -- Replace 1001 with the patient ID you want to query 

            WHEN 4 THEN -- Action for Option 4 
                DECLARE 
                    blood_group_param VARCHAR2(5) := 'A+'; 
                    bags_quantity_cursor SYS_REFCURSOR; 
                    bank_name BloodBank.blood_bank_name % TYPE; 
                    total_bags INTEGER; 
                BEGIN 
                    DBMS_OUTPUT.PUT_LINE('You selected Option 4'); 
                    GetBloodBagsQuantity(blood_group_param => blood_group_param, bags_quantity => bags_quantity_cursor); 
                    LOOP 
                        FETCH bags_quantity_cursor INTO bank_name, total_bags; 
                        EXIT WHEN bags_quantity_cursor % NOTFOUND; 
                        DBMS_OUTPUT.PUT_LINE('Blood Bank: ' || bank_name || ', Total Bags: ' || total_bags); 
                    END LOOP; 
                    CLOSE bags_quantity_cursor; 
                END;

            WHEN 5 THEN -- Action for Option 5 
                DECLARE 
                    blood_group_param VARCHAR2(5) := 'A+'; 
                    blood_bank_id_param INTEGER := 1; 
                    group_quantity INTEGER; 
                BEGIN 
                    DBMS_OUTPUT.PUT_LINE('You selected Option 5'); 
                    GetBloodGroupQuantity(blood_bank_id_param => blood_bank_id_param, blood_group_param => blood_group_param, group_quantity => group_quantity); 
                    DBMS_OUTPUT.PUT_LINE('Quantity of Blood Group ' || blood_group_param || ' in Blood Bank ' || blood_bank_id_param || ': ' || group_quantity); 
                END;

            WHEN 6 THEN -- Action for Option 6 
                DECLARE 
                    blood_group_param VARCHAR2(5) := 'A+'; 
                    blood_banks_cursor SYS_REFCURSOR; 
                    bank_id BloodBank.blood_bank_id % TYPE; 
                    bank_name BloodBank.blood_bank_name % TYPE; 
                    total_quantity INTEGER; 
                BEGIN 
                    DBMS_OUTPUT.PUT_LINE('You selected Option 6'); 
                    GetBloodBanksWithQuantity(blood_group_param => blood_group_param, blood_banks_cursor => blood_banks_cursor); 
                    LOOP 
                        FETCH blood_banks_cursor INTO bank_id, bank_name, total_quantity; 
                        EXIT WHEN blood_banks_cursor % NOTFOUND; 
                        DBMS_OUTPUT.PUT_LINE('Blood Bank ID: ' || bank_id || ', Name: ' || bank_name || ', Total Quantity: ' || total_quantity); 
                    END LOOP; 
                    CLOSE blood_banks_cursor; 
                END;

            WHEN 7 THEN -- Action for Option 7 
                DBMS_OUTPUT.PUT_LINE('You selected Option 7');

            WHEN 8 THEN -- Action for Option 8 
                DBMS_OUTPUT.PUT_LINE('You selected Option 8');

            WHEN 9 THEN -- Action for Option 9 
                DBMS_OUTPUT.PUT_LINE('You selected Option 9');

            WHEN 10 THEN -- Exit the program 
                DBMS_OUTPUT.PUT_LINE('Exiting...'); 
                EXIT;

            ELSE 
                DBMS_OUTPUT.PUT_LINE('Invalid choice! Please select again.'); 
        END CASE; 
    END LOOP; 
END;
/
