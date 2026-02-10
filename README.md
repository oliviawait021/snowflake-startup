# Hands On Lab: Snowflake Startup

In this assignment you'll activate your Snowflake account, familiarize yourself with the platform by setting up your first database in the Snowflake environment, and then dust off your SQL skills with some review/practice queries. Lastly we'll explore a handy SQL trick called the _common table expression_.

But before we dive in, a quick note on the use of ChatGPT or other GenAI tools. LLMs are very good at writing SQL queries, so you will get very little value out of this assignment if you simply outsource the query writing to ChatGPT. High performing data professionals are effective at their jobs because, among other things, they develop a certain intuition about how to work with data, and SQL is about the clearest demonstration of your data skills as you'll find. You won't give yourself the chance to develop that intuition if you don't work through data problems on your own. I won't explicitly forbid the use of ChatGPT for this assignment, but I recommend trying to do the problems on your own and instead using ChatGPT **as a tutor** to help you understand why something wasn't working, alternative ways of solving a problem, etc.

Importantly, **we won't allow the use of ChatGPT on any quizzes or exams**, so you'll want to be capable of solving these types of problems on your own anyway.

---

## Snowflake Setup and Tutorial

### Setup Part 1: Locate your Snowflake Materials and Activate your Snowflake Account

Each of the three sections of our course has its own Snowflake account, and within those accounts, individual user accounts have been created for you. Each username is an animal name in all caps (e.g., CAMEL or KOALA). Your assigned account credentials, together with a handful of custom lab materials, have been distributed to you via a shared Box folder. You should have received an invitation (via your BYU email address) to join a shared folder during the first week of the semester. If you haven't seen that email yet, please double-check your BYU email account (including archive/spam folders) first, then let your instructor or a TA know.

Using the Snowflake credentials in your box folder (found in `snowflake_credentials.csv` under the "Snowflake" folder), log in to your Snowflake account (the URL is included in your credentials file). You will be prompted to change your password. Please bookmark your Snowflake account page and **save your new password in a password manager**. We will use these Snowflake accounts throughout the semester.

### Setup Part 2: Step through the `introduction_to_snowflake.sql` File

After logging into Snowflake in the browser, click "+ Create" in the menu on the left side, and select "SQL worksheet". This will open a blank workspace where you can enter SQL commands. On your local disk in the GitHub assignment repository, locate the file called `introduction_to_snowflake.sql`. That file is an adapted set of standard training materials from Snowflake that should get you familiar with the platform, its interface, and some terminology. You can copy the contents of that file into the blank worksheet in the Snowflake browser interface, and then step through the many lines of comments and a few SQL commands.

### Setup Part 3: (Bonus) Install and Configure the Snowflake Extension for Visual Studio Code

We'll be working with Snowflake for the rest of the semester, often using starter files that I'll provide in your assignment repositories. You are welcome to just use Snowflake in the browser like you did during the tutorial above, but that will entail managing copies of some of the assignment files and might add some headaches. I find it very convenient to interact with Snowflake using the powerful Snowflake extension for VS Code. You can set it up in about 3 minutes, and Snowflake provides a nice video walkthrough of that process [here](https://www.youtube.com/watch?v=Ov-fluftuiw).

---

## Complete SQL Review Exercises

Okay, now that you're set up in Snowflake and are a bit familiar with its terminology, let's remind ourselves how to use SQL. We're going to work through a series of SQL queries that use the `IS566` database found in our classroom Snowflake account. We'll be using 8 tables found under the `SQL_PRACTICE` schema. The data in this database represent an order transaction system in which customers place orders for various parts from various suppliers. The schema is summarized in the diagram below: 

<img src="schema.png"  width="80%">

The `sql_exercises.sql` file contains a series of numbered query prompts of increasing complexity that will give you the chance to demonstrate some basic SQL skills as you write queries against the tables depicted above. The first two groups of exercises in that file _should_ largely be a review for you (assuming you've worked with databases in the past). 

The third section of the `sql_exercises.sql` file will give you some practice with Common Table Expressions (CTEs), which will likely be new for many of you. When CTEs were first introduced, they fundamentally changed the way I work with SQL, and I think they belong in any data professional's tool belt. If you've never used CTEs before, I recommend first watching these two excellent explanations: [Explanation 1](https://www.youtube.com/watch?v=LJC8277LONg) and [Explanation 2](https://www.youtube.com/watch?v=K1WeoKxLZ5o). After watching them, you'll be ready to dive into the third section of the exercises.

---

## Save, Commit, and Push Changes

Whether you choose to work through the exercises directly in the `sql_exercises.sql` file (via VS Code) or in Snowflake's browser interface, your SQL code should ultimately be saved to `sql_exercises.sql` file. Those changes should then be committed and pushed to GitHub.