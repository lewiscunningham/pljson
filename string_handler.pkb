CREATE OR REPLACE PACKAGE BODY string_helper AS

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
       p_delimiter IN VARCHAR2 := ' ') RETURN VARCHAR2
  AS
    p_str_length PLS_INTEGER;
    p_spaces VARCHAR2(4000);
  BEGIN
    p_str_length := length(p_string);
    
    p_spaces := string_helper.spaces(p_length - p_str_length, p_delimiter);
    
    RETURN insertstr(
               p_spaces, 
               p_string,
               (p_length/2) - ROUND((p_str_length/2),0)+ 1);
  END;
       
  --return a string prefilled with a defined number of spaces 
  -- spaces can be replaced with a delimeter
  FUNCTION spaces( 
       p_length IN INTEGER,
       p_delimiter IN VARCHAR2 := ' ') RETURN VARCHAR2
  AS
  BEGIN
    RETURN lpad(p_delimiter, p_length, p_delimiter);
  END;
       
  -- insert a string in the middle of another string     
  FUNCTION insertstr(
       p_instring IN VARCHAR2,
       p_newstring IN VARCHAR2,
       p_location IN INTEGER ) RETURN VARCHAR2
  AS
  BEGIN
    RETURN 
      SUBSTR(p_instring, 1, (p_location - 1)) ||   
      p_newstring || 
      SUBSTR(p_instring, p_location );
  END;
       
  -- case insensitive comparison
  -- returns:
  --     -1 if string1 smaller than string2
  --      0 if string1 same as string2
  --     +1 if string1 larger than string1
  FUNCTION strcmp(
       p_string1 IN VARCHAR2,
       p_string2 IN VARCHAR2 ) RETURN INTEGER
  AS
  BEGIN
    IF UPPER(p_string1) = UPPER(p_string2) THEN
      RETURN 0;
    ELSIF UPPER(p_string1) < UPPER(p_string2) THEN
      RETURN -1;
    ELSIF UPPER(p_string1) > UPPER(p_string2) THEN
      RETURN 1;
    END IF;  
  END;
  
  FUNCTION str_parse( 
    p_string IN VARCHAR2,
    p_delimiter IN VARCHAR2,
    p_occurrence IN NUMBER DEFAULT 1 )
    RETURN VARCHAR2
  AS
    v_start PLS_INTEGER;
    v_length PLS_INTEGER;
    v_string LONG;
  BEGIN
    
    IF SUBSTR(p_string,1,1) != p_delimiter AND
       SUBSTR(p_string,length(p_string),1) != p_delimiter      
    THEN
      v_string := p_delimiter || p_string || p_delimiter;
    ELSIF SUBSTR(p_string,length(p_string),1) != p_delimiter      
    THEN
      v_string := p_string || p_delimiter;
    ELSIF SUBSTR(p_string,1,1) != p_delimiter
    THEN
      v_string := p_delimiter || p_string;
    ELSE
      v_string := p_string;
    END IF;
    
    v_start := INSTR(v_string, p_delimiter, 1, p_occurrence);
    v_length := (INSTR(v_string, p_delimiter, 1, p_occurrence + 1) - 1) - v_start;
    
    RETURN 
       SUBSTR(p_string, 
          v_start,
          v_length);
  END;
    
  FUNCTION str_count( 
    p_string IN VARCHAR2,
    p_object IN VARCHAR2 )
  RETURN PLS_INTEGER
  AS
    v_cnt PLS_INTEGER := 0;
  BEGIN
    IF p_string IS NULL
    THEN
      RETURN v_cnt;
    END IF;
    
    FOR i IN 1..LENGTH(p_string)
    LOOP
      IF SUBSTR(p_string, i, length(p_object)) = p_object
      THEN
        v_cnt := v_cnt + 1;
      END IF;
    END LOOP;
    
    RETURN v_cnt;
 END;
  
  FUNCTION printf(
    format IN VARCHAR2,
    arg1 IN VARCHAR2,
    arg2 IN VARCHAR2 DEFAULT NULL,
    arg3 IN VARCHAR2 DEFAULT NULL,
    arg4 IN VARCHAR2 DEFAULT NULL,
    arg5 IN VARCHAR2 DEFAULT NULL )
  RETURN VARCHAR2
  AS

    type a_args IS TABLE OF VARCHAR2(32000)
      INDEX BY BINARY_INTEGER;

    argv a_args;

    v_string VARCHAR2(32000);

    v_ret_string VARCHAR2(32000);

    argc PLS_INTEGER := 5;

    vStartLoc PLS_INTEGER;

    vEndLoc PLS_INTEGER;

    i PLS_INTEGER := 1;

  BEGIN

    argv(1) := arg1; 
    argv(2) := arg2; 
    argv(3) := arg3; 
    argv(4) := arg4; 
    argv(5) := arg5; 

    v_string := '%s' || format || '%s%s%s%s';

    FOR i IN 1..argc
    LOOP

      IF argv(i) IS NULL
      THEN

        exit;

      END IF;

      --DBMS_OUTPUT.PUT_LINE('V_string: ' || v_string);

      vStartLoc := INSTR(v_string, '%s', 1, i) ;

      vEndLoc := INSTR(v_string, '%s', 1, i + 1) - 1;

      v_ret_string := v_ret_string || SUBSTR(v_string, vStartLoc, vEndLoc);

      --DBMS_OUTPUT.PUT_LINE('i= ' || i || ', start: ' || vstartloc ||
      --  ', end: ' || vendloc || ', ' || v_ret_string);

      v_ret_string := v_ret_string || argv(i);

    END LOOP ;

    RETURN REPLACE(v_ret_string, '%s', '');

  END;

      
       
END string_helper;
/

sho err



