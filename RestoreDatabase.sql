CREATE DATABASE TrainingDB1; 
GO 
USE TrainingDB1; 
GO 
CREATE TABLE Students ( 
StudentID INT PRIMARY KEY, 
FullName NVARCHAR(100), 
EnrollmentDate DATE 
); 
INSERT INTO Students VALUES  
(1, 'Sara Ali', '2023-09-01'), 
(2, 'Mohammed Nasser', '2023-10-15'); 

--Full BackUp
BACKUP DATABASE TrainingDB1 TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB1_Full.bak'; 

INSERT INTO Students VALUES (3, 'Fatma Said', '2024-01-10'); 

--Differential Backup
BACKUP DATABASE TrainingDB1 TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB1_Diff.bak' WITH DIFFERENTIAL; 

--Transaction Log Backup
-- First make sure Recovery Model is FULL 
ALTER DATABASE TrainingDB1 SET RECOVERY FULL; 
-- Now backup the log 
BACKUP LOG TrainingDB1 TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB1_Log.trn'; 

--Copy-Only Backup
BACKUP DATABASE TrainingDB1 TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB1_CopyOnly.bak' WITH 
COPY_ONLY; 

--Step 1: Drop the Current Database (Simulate System Failure) 
DROP DATABASE TrainingDB1; 
 -------
USE master;

ALTER DATABASE TrainingDB1
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;

DROP DATABASE TrainingDB1;

----
-- 1. Restore FULL backup 
RESTORE DATABASE TrainingDB1  
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB1_Full.bak' 
WITH NORECOVERY; 

-- 2. Restore DIFFERENTIAL backup (if you created one) 
RESTORE DATABASE TrainingDB  
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Diff.bak' 
WITH NORECOVERY; 

-- 3. Restore TRANSACTION LOG backup (if you created one) 
RESTORE LOG TrainingDB  
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Log.trn' 
WITH RECOVERY; 
