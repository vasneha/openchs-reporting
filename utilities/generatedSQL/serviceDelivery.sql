SELECT 'Total adolescents enrolled',
 count(*) FILTER (WHERE gender.name = 'Male' and address_level.type = 'Village') AS "Village - Male", 
 count(*) FILTER (WHERE gender.name = 'Female' and address_level.type = 'Village') AS "Village - Female", 
 count(*) FILTER (WHERE address_level.type = 'Village') AS "Village - Total", 
 count(*) FILTER (WHERE gender.name = 'Male' and address_level.type = 'School') AS "School - Male", 
 count(*) FILTER (WHERE gender.name = 'Female' and address_level.type = 'School') AS "School - Female", 
 count(*) FILTER (WHERE address_level.type = 'School') AS "School - Total", 
 count(*) FILTER (WHERE gender.name = 'Male' and address_level.type = 'Boarding School') AS "Village - Male", 
 count(*) FILTER (WHERE gender.name = 'Female' and address_level.type = 'Boarding School') AS "Village - Female", 
 count(*) FILTER (WHERE address_level.type = 'Boarding School') AS "Boarding School - Total"
 from program_enrolment INNER JOIN program ON program_enrolment.program_id = program.id
INNER JOIN individual ON program_enrolment.individual_id = individual.id
INNER JOIN gender ON individual.gender_id = gender.id
INNER JOIN address_level ON address_level.id = individual.address_id
WHERE program.name = 'Adolescent' UNION 
SELECT 'Total adolescents having problem',
 count(CASE WHEN has_problem THEN 1 END) FILTER (WHERE gender_name = 'Male' and address_level_type = 'Village') AS "Village - Male", 
 count(CASE WHEN has_problem THEN 1 END) FILTER (WHERE gender_name = 'Female' and address_level_type = 'Village') AS "Village - Female", 
 count(CASE WHEN has_problem THEN 1 END) FILTER (WHERE address_level_type = 'Village') AS "Village - Total", 
 count(CASE WHEN has_problem THEN 1 END) FILTER (WHERE gender_name = 'Male' and address_level_type = 'School') AS "School - Male", 
 count(CASE WHEN has_problem THEN 1 END) FILTER (WHERE gender_name = 'Female' and address_level_type = 'School') AS "School - Female", 
 count(CASE WHEN has_problem THEN 1 END) FILTER (WHERE address_level_type = 'School') AS "School - Total", 
 count(CASE WHEN has_problem THEN 1 END) FILTER (WHERE gender_name = 'Male' and address_level_type = 'Boarding School') AS "Village - Male", 
 count(CASE WHEN has_problem THEN 1 END) FILTER (WHERE gender_name = 'Female' and address_level_type = 'Boarding School') AS "Village - Female", 
 count(CASE WHEN has_problem THEN 1 END) FILTER (WHERE address_level_type = 'Boarding School') AS "Boarding School - Total"
 from (SELECT bool_and(has_problem(program_encounter.observations)) AS has_problem, gender.name gender_name, address_level.type address_level_type from program_encounter
INNER JOIN program_enrolment ON program_encounter.program_enrolment_id = program_enrolment.id
INNER JOIN encounter_type ON program_encounter.encounter_type_id = encounter_type.id INNER JOIN program ON program_enrolment.program_id = program.id
INNER JOIN individual ON program_enrolment.individual_id = individual.id
INNER JOIN gender ON individual.gender_id = gender.id
INNER JOIN address_level ON address_level.id = individual.address_id
WHERE program.name = 'Adolescent' GROUP BY program_encounter.program_enrolment_id, gender.name, address_level.type) AS encounter_function_output 