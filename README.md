# **Restore Database Task**

## **Step 1: Drop the Current Database (Simulate System Failure)**
```sql
DROP DATABASE TrainingDB; 
```


## **Step 2: Restore from Your Backups**

Use the same file names and paths you used earlier. Replace them accordingly.
```sql 
-- 1. Restore FULL backup 
RESTORE DATABASE TrainingDB  
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Full.bak' 
WITH NORECOVERY; 

-- 2. Restore DIFFERENTIAL backup (if you created one) 
RESTORE DATABASE TrainingDB  
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Diff.bak' 
WITH NORECOVERY; 

-- 3. Restore TRANSACTION LOG backup (if you created one) 
RESTORE LOG TrainingDB  
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\TrainingDB_Log.trn' 
WITH RECOVERY; 
```
~~NOTE:~~
- Use WITH NORECOVERY until the final step. 
- Use WITH RECOVERY only at the last step. 

## **Step 3: Verify the Restored Data**
```sql
USE TrainingDB; 
SELECT * FROM Students; 
```

Check if all the records (including the last one you added before the transaction log backup) are 
there. 

## **Reflection Questions:**

1. What would happen if you skipped the differential backup step? 

If we do not do differential backups it will not stop the restore process but will make it longer and more complex.

2. What’s the difference between restoring a full vs. copy-only backup? 

|Backup Type |Description                                                          |
|------------|---------------------------------------------------------------------|
|Full Backup |Becomes the base for differential/log backups. Affects backup chain. |
|Copy-Only   |Independent backup. Doesn’t affect differential/log backup chain.    |

~~NOTE:~~
Use copy-only backups when you need a backup but don't want to interrupt your regular backup plan.

3. What happens if you use WITH RECOVERY in the middle of a restore chain? 
   - The database is brought online immediately
   - You can't restore any more backups after that
   - The restore sequence is broken

4. Which backup types are optional and which are mandatory for full recovery? 
   - Mandatory:
     - Full backup
     - All subsequent transaction log backups
   - Optional:
     - Differential backup 
     - Copy-only backup 
     - File/Filegroup backups 