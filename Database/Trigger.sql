-- VIEW ACTIVE CLIENTS --
CREATE VIEW V_ActiveClients AS
SELECT * FROM SF.Client WHERE client_active IS TRUE

-- VIEW ACTIVE ADMS --
CREATE VIEW V_ActiveAdm AS
SELECT * FROM SF.Adm WHERE adm_active IS TRUE

-- VIEW SORTED CLIENTS --
CREATE VIEW V_ClientOrder AS
SELECT * FROM SF.Client ORDER BY client_id ASC

-- VIEW SORTED ADMS --
CREATE VIEW V_AdmOrder AS
SELECT * FROM SF.Adm ORDER BY adm_id ASC

-- VIEW SORTED MUSCLES --
CREATE VIEW V_MuscleOrder AS
SELECT * FROM SF.Muscle ORDER BY muscle_name

-- VIEW SORTED EXERCISES --
CREATE VIEW V_ExerciseOrder AS
SELECT * FROM SF.Exercise ORDER BY exercise_name

-- VIEW SORTED TRAINING --
CREATE VIEW V_TrainingOrder AS
SELECT * FROM SF.Training ORDER BY training_id ASC

SELECT * FROM V_ActiveClients
SELECT * FROM V_ActiveAdm
SELECT * FROM V_ClientOrder
SELECT * FROM V_AdmOrder
SELECT * FROM V_MuscleOrder
SELECT * FROM V_ExerciseOrder
SELECT * FROM V_TrainingOrder