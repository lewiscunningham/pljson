# pljson
PL/JSON is a generic JSON object written in PL/SQL. Using PL/SQL object syntax, users instantiate a JSON objects and then add members, arrays and additional JSON objects. This object type can store JSON data, in Oracle, persistently.

This repo includes the code as I originally wrote and released it. There is another project with the same name that started from this code. They removed my name from the code after a few releases but I was the original author. I had stopped doing any maintenance or anything on it but I don't think they should have removed my name. Not worth pursuing at this piont though.

You can see the original code evolution at sourceforge at https://sourceforge.net/projects/pljson/

Installation:

1.  To install, extract the files to a directory
2.  change to the directory where the files exist
3.  run the install.sql file 
4.  To Test:
     4a) to test creating JSON mamnually, run the call_json.sql file
     4b) to test creating JSON from text input, run sqlplus_run.sql
     
     
