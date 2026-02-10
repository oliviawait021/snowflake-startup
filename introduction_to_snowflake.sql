
-- 1.0.0   Introduction to Snowflake and Snowflake Objects
--         The purpose of this file is to familiarize you with Snowflake’s
--         "Snowsight" user interface. Specifically, you will learn how to use
--         Snowsight worksheets to create and use Snowflake objects that you
--         will use to run queries and in your day-to-day work.
--         - How to navigate Snowsight to find the tools you’ll need
--         - How to create and manage folders and worksheets
--         - How to set the context
--         - How to create warehouses, databases, schemas, and tables
--         - How to run a simple query

--         HOW TO COMPLETE THIS LAB
--         This file contains instructions for completing the lab steps, as well
--         as the SQL you will need to run.

--         Let’s get started!

-- 1.1.0   Log In
--         The credentials from your instructor explain how to log in to Snowsight 
--         with your classroom account and individual username.

-- 1.2.0   Explore the Home Screen
--         When you first log in, you will be placed into the home screen.

-- 1.2.1   Locate the user menu.
--         This is located in the upper left corner. Here you will find your
--         username and the role that you currently have set. You will learn
--         more about roles later on. You can always tell when you are in the
--         Home Screen because the user menu will be in the upper left.

-- 1.2.2   Locate the left navigation bar.
--         This is located along the left side, beneath the user menu. You can
--         use the navigation bar to move through various areas of the user
--         interface.

-- 1.2.3   Locate the account selector.
--         This is at the very bottom, on the left side. If you have accessed
--         other Snowflake accounts, they will be listed here. You can click the
--         selector to log in to a different account.

-- 1.2.4   Locate the active panel.
--         This is the large area on the right. This will change based on which
--         menu you have activated from the navigation bar.

-- 1.3.0   Set Up Your User Profile

-- 1.3.1   Access the profile.
--         Click the down arrow to the right side of the user menu, then select
--         Profile.

-- 1.3.2   Enter your name.
--         In the screen that appears, enter your name.
--         Changing your name in the Profile area does not change the username
--         you enter to log into Snowsight. It simply changes your name in the
--         display.

-- 1.3.3   Optionally, enter your email address.
--         If you enter an email address, a verification link will be sent to
--         the address you specify.

-- 1.3.4   Set the Default Experience to Snowsight.
--         The default experience is probably already set to Snowsight, but
--         change it if it is not. This determines whether you will be directed
--         to the Classic UI or to Snowsight when you log in. In this course, we
--         will be exclusively using Snowsight.
--         The Classic UI is going to be removed at some point in the future.
--         Unless you need to access UI functionality that has not yet been
--         ported to Snowsight, we recommend that you use Snowsight, so you are
--         accustomed to it when the Classic UI is no longer available.

-- 1.3.5   Save your profile changes.
--         Click Save when you are finished.

-- 1.4.0   Create Folders and Worksheets
--         In this course, most of the work you do will be through worksheets.
--         Worksheets can be created inside a folder for additional
--         organization, but they do not NEED to be in folders. We will show you
--         how to create folders if you want to use them.

-- 1.4.1   Create a folder.
--         From the home screen, make sure you have Worksheets selected from the
--         left navigation bar. Then click the blue + button (in the upper right
--         corner of the screen).
--         From the menu that displays, select New Folder. Name your folder
--         Working with Snowsight and then click Create Folder. You will now be
--         positioned inside your empty folder.

-- 1.4.2   Load your SQL file for this lab into a worksheet.
--         Click the down arrow that is just to the right of your folder name.
--         Select Create Worksheet from SQL File. Then:
--         - Navigate to your GitHub assignment repository where this file is located.
--         - Open the file for this lab. A new worksheet will open with this SQL
--         file already loaded.
--         - Scroll to the top of the worksheet (when the file loads, your
--         cursor will be positioned at the bottom of the worksheet, not the
--         top).
--         - Follow the instructions. Lab instructions are shown as comments. 
--         Do not skip these - they are instructions you need to follow. When the
--         instructions indicate you need to run some SQL, we will provide the
--         necessary code.

-- 1.5.0   Explore Worksheets
--         Take a few minutes to familiarize yourself with the components of a
--         worksheet. Each worksheet is a session connected to Snowflake. You
--         can have many active worksheets (or sessions) at once. Each worksheet
--         has a context, which defines the default components you are working
--         on within this session.
--         Your context is an important concept to understand. It defines the
--         components that are being used by default in this session. It
--         consists of a database, a schema, a role, and a virtual warehouse
--         (you will learn more about all of these in the course of this class).
--         - The role that is active will impact what objects you can see and
--         what you can do with them.
--         - The virtual warehouse defines what virtual warehouse you will use
--         to run commands.
--         - The database and schema define the default location you are acting
--         in. For example, if you SELECT * FROM <table>, Snowflake will look
--         for that table in the database and schema that is set in your
--         context. If you want to select from a table that is outside your
--         current context, you would need to provide the full path to that
--         object, for example, SELECT * FROM <database>.<schema>.<table>.

-- 1.5.1   Orient yourself to the worksheet components.
--         Spend a few minutes to orient yourself to the worksheet before
--         beginning. Locate the following components:
--         - In the upper left corner, you will find a home icon. This will take
--         you back to the home screen.
--         - To the right of the home icon is the name of your folder and your
--         worksheet. Note that if you created the worksheet by loading a SQL
--         file, the worksheet’s name will match the name of the file you
--         loaded. If you just created an empty worksheet, the name will be the
--         current date and time.
--         - Directly below that is a filter button - just ignore this for now.
--         - Along the left side is the object browser. There are two tabs - one
--         labeled Worksheets and the other labeled Databases. This identifies
--         whether a list of your worksheets is displayed or if a list of
--         database objects is displayed. You can switch between them to change
--         what is displayed in the object browser.
--         - The large area on the right is the SQL editor pane. This is where
--         you will type SQL commands. You should see this text loaded in the
--         SQL editor panel.
--         - Just above the SQL pane, you will see a database name and a schema
--         name. This sets the database and schema portion of your context.
--         - In the upper right corner, you will see a place where your role and
--         virtual warehouse for this session are set. This sets the remainder
--         of your context.
--         - To the right of that is a Share button - ignore that for now.
--         - On the far right is a circle with an arrow in it. This is the Run
--         button.

-- 1.5.2   Set your context.
--         Click on the arrow to the right of your No Database Selected in the
--         SQL pane (part of your context). A list of current databases appears.
--         Select IS566 as your database and SQL_PRACTICE as your schema.
--         Click outside the box to close it.

-- 1.5.3   Select a virtual warehouse.
--         Before you can run any SQL commands, you need a virtual warehouse.
--         Your user account already has a dedicated virtual warehouse assigned
--         (named according to your username, e.g., `<Username>_WH`). Note that
--         your instructor has disabled the ability to add more virtual warehouses
--         in order to protect the limited credits allocated to your classroom 
--         account.
--
--         You can, however, inform snowflake which virtual warehouse you'd like
--         to use with a command like the one below:

USE WAREHOUSE ZEBRA_WH;

-- 1.5.4   Show the tables that are in your current context.

SHOW TABLES;

--         Note that a SHOW command is a metadata operation - so you did not use
--         your virtual warehouse. You can tell that the warehouse is suspended
--         (not running) because the small dot to the left of the virtual
--         warehouse name is gray.

-- 1.5.5   Query some tables.
--         During this course, many of our exercises will use data from a sample
--         database already in your environment: IS566. Take a look at some of that data:

SELECT TOP 5
    c.c_lastname,
    c.c_firstname,
    c.c_acctbal
FROM customer c
ORDER BY c.c_acctbal DESC;

SELECT 
  c_firstname,
  c_lastname,
  o_orderkey,
  o_totalprice
FROM
  orders
JOIN
  customer
ON
  o_custkey = c_custkey
ORDER BY o_totalprice DESC
LIMIT 10;

SELECT 
  *
FROM 
  SNOWFLAKE_SAMPLE_DATA.TPCH_SF10.SUPPLIER
LIMIT 10;

--         The last query in that series shows how you can select from tables
--         that are not in the database and schema that are currently set in
--         your context.
--         Also, notice that these queries did require a virtual warehouse, so
--         yours automatically started up - the dot next to the virtual
--         warehouse name is now green. It will auto-suspend itself after some
--         amount of idle time.

-- 1.6.0   Create Objects
--         One of the things you may do during the course of your work is create
--         objects, such as databases, schemas, and tables. Let’s create a few
--         objects that you will use during this course.
              

-- 1.6.1   Create a database associated with your username (e.g., ZEBRA_db) and 
--         set it in your context.

--         NOTE: Just to be clear, you WILL need to edit the two lines below.

CREATE DATABASE <Username>_db;

USE DATABASE <Username>_db;


-- 1.6.2   Create a schema called my_schema in the database you just created.

CREATE SCHEMA my_schema;

USE SCHEMA my_schema;


-- 1.6.4   Create a temporary table.

CREATE TEMPORARY TABLE my_favorite_actors (name VARCHAR);

--         Now put a few rows in your table, substituting the placeholder names
--         for the names of your actual favorite actors.

INSERT INTO my_favorite_actors
VALUES
  ('Heath Ledger'),
  ('Michelle Pfeiffer'),
  ('Meryl Street'),
  ('Anthony Hopkins'),
  ('Bruce Lee');

SELECT * FROM my_favorite_actors;


-- 1.7.0   Key Takeaways
--         - You can create database objects both via the Snowsight UI and by
--         executing SQL code in a worksheet. We did this exercise using SQL
--         code.
--         - You can browse database objects and view their details by using the
--         object browser in the worksheet.
--         - The context of a worksheet session consists of a role, schema,
--         database, and virtual warehouse.
--         - The context of a worksheet can be set via the Snowsight UI or via
--         SQL statements.
--         - You can create folders in which to save and organize worksheets.
