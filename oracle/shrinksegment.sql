--
-- Enable row movement.
ALTER TABLE reporter.reporter_status ENABLE ROW MOVEMENT
/

-- Recover space and amend the high water mark (HWM).
--ALTER TABLE reporter.reporter_status SHRINK SPACE

-- Recover space, but don't amend the high water mark (HWM).
--ALTER TABLE reporter.reporter_status SHRINK SPACE COMPACT

-- Recover space for the object and all dependant objects.
ALTER TABLE reporter.reporter_status SHRINK SPACE CASCADE
/
