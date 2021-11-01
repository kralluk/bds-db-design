-- -----------------------------------------------------
-- Table `mydb`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "building" (
  "building_id" BIGSERIAL NOT NULL,
  "building_name" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("building_id"))
  ;


-- -----------------------------------------------------
-- Table "mydb"."employee"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "employee" (
  "employee_id" BIGSERIAL NOT NULL,
  "first_name" VARCHAR(45) NOT NULL,
  "surname" VARCHAR(45) NOT NULL,
  "mail" VARCHAR(45) NOT NULL,
  "pswd" VARCHAR(45) NOT NULL,
  "building_id" BIGSERIAL NOT NULL,
  PRIMARY KEY ("employee_id", "building_id"),
	UNIQUE ("employee_id"),
  CONSTRAINT "building_id"
    FOREIGN KEY ("building_id")
    REFERENCES "building" ("building_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table "mydb"."address"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "address" (
  "address_id" BIGSERIAL NOT NULL,
  PRIMARY KEY ("address_id"),
  "city" VARCHAR(45) NOT NULL,
  "street" VARCHAR(45) NOT NULL,
  "street_number" VARCHAR(45),
  "zip_code" VARCHAR(45)
  );



-- -----------------------------------------------------
-- Table "mydb"."job"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "job" (
  "job_id" BIGSERIAL NOT NULL,
  "job_type" VARCHAR(45) NOT NULL,
  "salary" FLOAT NULL,
  PRIMARY KEY ("job_id"));



-- -----------------------------------------------------
-- Table "mydb"."employee_has_address"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "employee_has_address" (
  "employee_id" BIGSERIAL NOT NULL,
  "address_id" INT NOT NULL,
  "address_type" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("employee_id", "address_id"),
  CONSTRAINT "employee_id"
    FOREIGN KEY ("employee_id")
    REFERENCES "employee" ("employee_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "address_id"
    FOREIGN KEY ("address_id")
    REFERENCES "address" ("address_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table "mydb"."employee_has_contract"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "employee_has_contract" (
  "contract_expiration" DATE,
  "employee_id" BIGSERIAL NOT NULL,
  "job_id" BIGSERIAL NOT NULL,
  PRIMARY KEY ("employee_id", "job_id"),
  CONSTRAINT "employee_id"
    FOREIGN KEY ("employee_id")
    REFERENCES "employee" ("employee_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "job_id"
    FOREIGN KEY ("job_id")
    REFERENCES "job" ("job_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table "mydb"."customer"
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS "customer" (
  "customer_id" BIGSERIAL NOT NULL,
  "customer_f_name" VARCHAR(45) NOT NULL,
  "customer_s_name" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("customer_id"),
	UNIQUE("customer_id"));


-- -----------------------------------------------------
-- Table "mydb"."car"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "car" (
  "car_id" BIGSERIAL NOT NULL,
  "car_brand" VARCHAR(45) NOT NULL,
  "car_color" VARCHAR(45) NOT NULL, 
  "customer_id" INT,
  PRIMARY KEY ("car_id"),
  UNIQUE("car_id"),
  CONSTRAINT "customer_id"
    FOREIGN KEY ("customer_id")
    REFERENCES "customer" ("customer_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
	;


-- -----------------------------------------------------
-- Table "mydb"."contact"
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS "contact" (
  "contact_id" BIGSERIAL NOT NULL,
  "email" VARCHAR(45) NOT NULL,
  "phone_number" VARCHAR(13) NOT NULL,
  "customer_id" BIGSERIAL NOT NULL,
  PRIMARY KEY ("contact_id"),
	UNIQUE("contact_id"),
  CONSTRAINT "customer_id"
    FOREIGN KEY ("customer_id")
    REFERENCES "customer" ("customer_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
	;


-- -----------------------------------------------------
-- Table "mydb"."manager"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "manager" (
  "manager_id" BIGSERIAL NOT NULL,
  "manager_firstname" VARCHAR(45) NOT NULL,
  "manager_surname" VARCHAR(45) NOT NULL,
  "salary" FLOAT NOT NULL,
  "building_id" BIGSERIAL NOT NULL,
  PRIMARY KEY ("manager_id", "building_id"),
	UNIQUE("manager_id"),
  CONSTRAINT "building_id"
    FOREIGN KEY ("building_id")
    REFERENCES "building" ("building_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table "mydb"."car_has_workers"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "car_has_workers" (
  "car_id" BIGSERIAL NOT NULL,
  "employee_id" BIGSERIAL NOT NULL,
  "deadline" DATE,
  PRIMARY KEY ("car_id", "employee_id"),
  CONSTRAINT "employee_id"
    FOREIGN KEY ("employee_id")
    REFERENCES "employee" ("employee_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "car_id"
    FOREIGN KEY ("car_id")
    REFERENCES "car" ("car_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table "mydb"."car_in_builidng"
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "car_in_building" (
  "car_id" BIGSERIAL NOT NULL,
  "building_id" BIGSERIAL NOT NULL,
  "parts" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("car_id", "building_id"),
  CONSTRAINT "car_id"
    FOREIGN KEY ("car_id")
    REFERENCES "car" ("car_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "building_id"
    FOREIGN KEY ("building_id")
    REFERENCES "building" ("building_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table "mydb"."manager_has_address"
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS "manager_has_address" (
  "manager_id" BIGSERIAL NOT NULL,
  "address_id" INT NOT NULL,
  "address_type" VARCHAR(45) NOT NULL,
  PRIMARY KEY ("manager_id", "address_id"),
  CONSTRAINT "manager_id"
    FOREIGN KEY ("manager_id")
    REFERENCES "manager" ("manager_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT "address_id"
    FOREIGN KEY ("address_id")
    REFERENCES "address" ("address_id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

