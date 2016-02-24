CREATE TABLE IF NOT EXISTS run_screenshots
(
  run_id          INTEGER     NOT NULL REFERENCES run ON DELETE CASCADE,
  screenshot_id   INTEGER     NOT NULL REFERENCES screenshot ON DELETE CASCADE,
  UNIQUE (run_id, screenshot_id)
);

INSERT INTO run_screenshots (run_id, screenshot_id) SELECT run_id, id FROM screenshot;

CALL execute('ALTER TABLE run DROP CONSTRAINT ' ||
             (SELECT DISTINCT CONSTRAINT_NAME FROM INFORMATION_SCHEMA.CONSTRAINTS WHERE TABLE_NAME = 'SCREENSHOT' AND COLUMN_LIST='RUN_ID,SCREENSHOT_NAME,PROPERTIES'));


ALTER TABLE SCREENSHOT DROP COLUMN run_id;
