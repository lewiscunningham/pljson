CREATE OR REPLACE PACKAGE string_helper 
AS


  /*
  Copyright (c) 2009 Lewis R Cunningham

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */

  -- return a string centered between delimiters
  -- delimiter defaults to spaces
  FUNCTION center(
       p_string IN VARCHAR2,
       p_length IN INTEGER,
       p_delimiter IN VARCHAR2 := ' ') RETURN VARCHAR2;
       
  --return a string prefilled with a defined number of spaces     
  -- spaces can be replaced with a delimeter
  FUNCTION spaces( 
       p_length IN INTEGER,
       p_delimiter IN VARCHAR2 := ' ' ) RETURN VARCHAR2;
       
  -- insert a string in the middle of another string     
  FUNCTION insertstr(
       p_instring IN VARCHAR2,
       p_newstring IN VARCHAR2,
       p_location IN INTEGER ) RETURN VARCHAR2;
       
  -- case insensitive comparison
  -- returns:
  --     -1 if string1 smaller than string2
  --      0 if string1 same as string2
  --     +1 if string1 larger than string1
  FUNCTION strcmp(
       p_string1 IN VARCHAR2,
       p_string2 IN VARCHAR2 ) RETURN INTEGER;
       
    
  FUNCTION str_parse( 
    p_string IN VARCHAR2,
    p_delimiter IN VARCHAR2,
    p_occurrence IN NUMBER DEFAULT 1 )
    RETURN VARCHAR2;
    
  FUNCTION str_count( 
    p_string IN VARCHAR2,
    p_object IN VARCHAR2 )
  RETURN PLS_INTEGER;
  
  FUNCTION printf(
    format IN VARCHAR2,
    arg1 IN VARCHAR2,
    arg2 IN VARCHAR2 DEFAULT NULL,
    arg3 IN VARCHAR2 DEFAULT NULL,
    arg4 IN VARCHAR2 DEFAULT NULL,
    arg5 IN VARCHAR2 DEFAULT NULL )
  RETURN VARCHAR2;  
  
END string_helper;
/

SHO ERR


