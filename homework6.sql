-- task 1
DELIMITER $$
CREATE FUNCTION format_seconds(seconds INT)
RETURNS VARCHAR(100)
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;

    SET days = seconds DIV (24 * 3600);
    SET seconds = seconds % (24 * 3600);
    SET hours = seconds DIV 3600;
    SET seconds = seconds % 3600;
    SET minutes = seconds DIV 60;
    SET seconds = seconds % 60;

    RETURN CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');
END$$
DELIMITER ;

SELECT format_seconds(123456);

-- task 2

CREATE TEMPORARY TABLE even_numbers (number INT);

INSERT INTO even_numbers (number)
SELECT number FROM
(
    SELECT 2 AS number
    UNION ALL SELECT 4
    UNION ALL SELECT 6
    UNION ALL SELECT 8
    UNION ALL SELECT 10
) AS temp;

SELECT * FROM even_numbers;

--

DELIMITER //
DROP PROCEDURE IF EXISTS print_even_numbers //
CREATE PROCEDURE print_even_numbers()
BEGIN
    DECLARE counter INT DEFAULT 2;
    DECLARE max_number INT DEFAULT 10;
    DECLARE result VARCHAR(100) DEFAULT '';

    WHILE counter <= max_number DO
        IF counter % 2 = 0 THEN
            SET result = CONCAT(result, counter, ' ');
        END IF;
        SET counter = counter + 1;
    END WHILE;

    SELECT TRIM(result) AS even_numbers;
END //
DELIMITER ;

CALL print_even_numbers();