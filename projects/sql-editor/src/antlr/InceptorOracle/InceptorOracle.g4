/**
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at
       http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
grammar InceptorOracle;

@members {
/*  @Override
  public Object recoverFromMismatchedSet(IntStream input,
      RecognitionException re, BitSet follow) throws RecognitionException {
    throw re;
  }

  @Override
  public void displayRecognitionError(String[] tokenNames,
      RecognitionException e) {
    gParent.displayRecognitionError(tokenNames, e);
  }

  public void pushMsg(String msg, RecognizerSharedState state) {
    gParent.pushMsg(msg, state);
  }

  public void popMsg(RecognizerSharedState state) {
    gParent.popMsg(state);
  }

  public static String trimQuotes (String input) {
    if (input.length () > 1) {
      if ((input.charAt (0) == '"' && input.charAt (input.length () - 1) == '"')
        || (input.charAt (0) == '\'' && input.charAt (input.length () - 1) == '\'')) {
        return input.substring (1, input.length () - 1);
      }
    }
    return input;
  }
*/
  trimQuotes(input) {
    if (input.length > 1) {
      if ((input.charAt(0) == '"' && input.charAt(input.length - 1) == '"')
        || (input.charAt(0) == '\'' && input.charAt(input.length - 1) == '\'')) {
        return input.substring(1, input.length - 1);
      }
    }
    return input;
  }
}

@rulecatch {
catch (RecognitionException e) {
  throw e;
}
}
// Keywords
KW_TRUE : 'TRUE';
KW_FALSE : 'FALSE';
KW_ALL : 'ALL';
KW_AND : 'AND';
KW_OR : 'OR';
KW_NOT : 'NOT';
KW_LIKE : 'LIKE';
KW_NO: 'NO';
KW_ANY : 'ANY';
KW_IF : 'IF';
KW_EXISTS : 'EXISTS';
KW_ASC : 'ASC';
KW_DESC : 'DESC';
KW_ORDER : 'ORDER';
KW_GROUP : 'GROUP';
KW_INCREMENT: 'INCREMENT';
KW_BY : 'BY';
KW_HAVING : 'HAVING';
KW_HASH: 'HASH';
KW_WHERE : 'WHERE';
KW_FROM : 'FROM';
KW_AS : 'AS';
KW_SELECT : 'SELECT';
KW_DISTINCT : 'DISTINCT';
KW_INSERT : 'INSERT';
KW_BATCH_INSERT : 'BATCHINSERT';
KW_BATCH_VALUES : 'BATCHVALUES';
KW_OVERWRITE : 'OVERWRITE';
KW_OUTER : 'OUTER';
KW_UNIQUEJOIN : 'UNIQUEJOIN';
KW_PRESERVE : 'PRESERVE';
KW_JOIN : 'JOIN';
KW_STREAMJOB : 'STREAMJOB';
KW_STREAMJOBS : 'STREAMJOBS';
KW_AT : 'AT';
KW_LEFT : 'LEFT';
KW_RIGHT : 'RIGHT';
KW_FULL : 'FULL';
KW_ON : 'ON';
KW_OFF : 'OFF';
KW_PARTITION : 'PARTITION';
KW_PARTITIONS : 'PARTITIONS';
KW_PATTERN: 'PATTERN';
KW_TABLE: 'TABLE';
KW_TABLES: 'TABLES';
KW_SEQUENCE: 'SEQUENCE';
KW_SEQUENCES: 'SEQUENCES';
KW_COLUMNS: 'COLUMNS';
KW_INDEX: 'INDEX';
KW_INDEXES: 'INDEXES';
KW_REBUILD: 'REBUILD';
KW_FUNCTIONS: 'FUNCTIONS';
KW_PLSQL: 'PLSQL';
KW_SHOW: 'SHOW';
KW_MSCK: 'MSCK';
KW_REPAIR: 'REPAIR';
KW_DIRECTORY: 'DIRECTORY';
KW_LOCAL: 'LOCAL';
KW_GLOBAL: 'GLOBAL';
KW_TRANSFORM : 'TRANSFORM';
KW_USING: 'USING';
KW_CLUSTER: 'CLUSTER';
KW_DISTRIBUTE: 'DISTRIBUTE';
KW_SORT: 'SORT';
KW_UNION: 'UNION';
KW_LOAD: 'LOAD';
KW_EXPORT: 'EXPORT';
KW_IMPORT: 'IMPORT';
KW_DATA: 'DATA';
KW_INPATH: 'INPATH';
KW_IS: 'IS';
KW_NULL: 'NULL';
KW_NULLS: 'NULLS';
KW_CREATE: 'CREATE';
KW_EXTERNAL: 'EXTERNAL';
KW_ALTER: 'ALTER';
KW_CHANGE: 'CHANGE';
KW_COLUMN: 'COLUMN';
KW_FIRST: 'FIRST';
KW_LAST: 'LAST';
KW_AFTER: 'AFTER';
KW_DESCRIBE: 'DESCRIBE';
KW_DROP: 'DROP';
KW_RENAME: 'RENAME';
KW_IGNORE: 'IGNORE';
KW_RESPECT: 'RESPECT';
KW_PROTECTION: 'PROTECTION';
KW_TO: 'TO';
KW_COMMENT: 'COMMENT';
KW_PROMPT: 'PROMPT';
KW_SPOOL: 'SPOOL';
KW_BOOLEAN: 'BOOLEAN';
KW_TINYINT: 'TINYINT';
KW_BYTE: 'BYTE';
KW_SMALLINT: 'SMALLINT';
KW_INT: 'INT';
KW_BIGINT: 'BIGINT';
KW_FLOAT: 'FLOAT';
KW_DOUBLE: 'DOUBLE';
KW_DATE: 'DATE';
KW_DATETIME: 'DATETIME';
KW_TIMESTAMP: 'TIMESTAMP';
KW_TIME: 'TIME';
KW_DECIMAL: 'DECIMAL';
KW_NUMERIC: 'NUMERIC';
KW_DEC: 'DEC';
KW_STRING: 'STRING';
KW_CHAR: 'CHAR';
KW_VARCHAR: 'VARCHAR';
KW_GEO: 'GEO';
KW_VARCHAR2: 'VARCHAR2';
KW_NVARCHAR: 'NVARCHAR';
KW_ARRAY: 'ARRAY';
KW_STRUCT: 'STRUCT';
KW_MAP: 'MAP';
KW_UNIONTYPE: 'UNIONTYPE';
KW_REDUCE: 'REDUCE';
KW_PARTITIONED: 'PARTITIONED';
KW_ROUTED: 'ROUTED';
KW_CLUSTERED: 'CLUSTERED';
KW_SORTED: 'SORTED';
KW_TABLESPACE : 'TABLESPACE';
KW_PCTFREE : 'PCTFREE';
KW_PCTUSED : 'PCTUSED';
KW_INITRANS : 'INITRANS';
KW_MAXTRANS : 'MAXTRANS';
KW_STORAGE : 'STORAGE';
KW_INITIAL : 'INITIAL';
KW_NEXT : 'NEXT';
KW_NEXTVALUE: 'NEXTVAL';
KW_MINEXTENTS : 'MINEXTENTS';
KW_MAXEXTENTS : 'MAXEXTENTS';
KW_UNLIMITED : 'UNLIMITED';
KW_WIDCARD : 'WIDCARD';
KW_INTO: 'INTO';
KW_BUCKETS: 'BUCKETS';
KW_ROW: 'ROW';
KW_ROWS: 'ROWS';
KW_FORMAT: 'FORMAT';
KW_DELIMITED: 'DELIMITED';
KW_FIELDS: 'FIELDS';
KW_TERMINATED: 'TERMINATED';
KW_ESCAPED: 'ESCAPED';
KW_COLLECTION: 'COLLECTION';
KW_ITEMS: 'ITEMS';
KW_KEYS: 'KEYS';
KW_KEY_TYPE: '$KEY$';
KW_LINES: 'LINES';
KW_STORED: 'STORED';
KW_FILEFORMAT: 'FILEFORMAT';
KW_SEQUENCEFILE: 'SEQUENCEFILE';
KW_TEXTFILE: 'TEXTFILE';
KW_CSVFILE: 'CSVFILE';
KW_FWCFILE: 'FWCFILE';
KW_RCFILE: 'RCFILE';
KW_ORCFILE: 'ORC';
KW_HOLODESK: 'HOLODESK';
KW_STELLARDB: 'STELLARDB';
KW_ORCTRANSACTIONFILE: 'ORC_TRANSACTION';
KW_PARQUET: 'PARQUET';
KW_HYPERDRIVE: 'HYPERDRIVE';
KW_ESDRIVE: 'ES';
KW_INPUTFORMAT: 'INPUTFORMAT';
KW_OUTPUTFORMAT: 'OUTPUTFORMAT';
KW_INPUTDRIVER: 'INPUTDRIVER';
KW_OUTPUTDRIVER: 'OUTPUTDRIVER';
KW_OFFLINE: 'OFFLINE';
KW_ENABLE: 'ENABLE';
KW_DISABLE: 'DISABLE';
KW_READONLY: 'READONLY';
KW_NO_DROP: 'NO_DROP';
KW_LOCATION: 'LOCATION';
KW_TABLESAMPLE: 'TABLESAMPLE';
KW_BUCKET: 'BUCKET';
KW_OUT: 'OUT';
KW_OF: 'OF';
KW_PERCENT: 'PERCENT';
KW_CAST: 'CAST';
KW_ADD: 'ADD';
KW_REPLACE: 'REPLACE';
KW_RLIKE: 'RLIKE';
KW_REGEXP: 'REGEXP';
KW_TEMPORARY: 'TEMPORARY';
KW_FUNCTION: 'FUNCTION';
KW_RESOURCE: 'RESOURCE';
KW_RELOAD: 'RELOAD';
KW_MACRO: 'MACRO';
KW_EXPLAIN: 'EXPLAIN';
KW_EXTENDED: 'EXTENDED';
KW_FORMATTED: 'FORMATTED';
KW_PRETTY: 'PRETTY';
KW_DEPENDENCY: 'DEPENDENCY';
KW_LOGICAL: 'LOGICAL';
KW_COST: 'COST';
KW_SERDE: 'SERDE';
KW_WITH: 'WITH';
KW_WITHIN: 'WITHIN';
KW_DEFERRED: 'DEFERRED';
KW_SERDEPROPERTIES: 'SERDEPROPERTIES';
KW_DBPROPERTIES: 'DBPROPERTIES';
KW_LIMIT: 'LIMIT';
KW_SET: 'SET';
KW_UNSET: 'UNSET';
KW_TBLPROPERTIES: 'TBLPROPERTIES';
KW_IDXPROPERTIES: 'IDXPROPERTIES';
KW_VALUE_TYPE: '$VALUE$';
KW_ELEM_TYPE: '$ELEM$';
KW_CASE: 'CASE';
KW_WHEN: 'WHEN';
KW_THEN: 'THEN';
KW_ELSE: 'ELSE';
KW_ELSIF: 'ELSIF' | 'ELSEIF';
KW_END: 'END';
KW_GOTO: 'GOTO';
KW_EXIT: 'EXIT';
KW_OPEN: 'OPEN';
KW_CLOSE: 'CLOSE';
KW_PRIOR: 'PRIOR';
KW_NOCYCLE: 'NOCYCLE';
KW_MAPJOIN: 'MAPJOIN';
KW_COMBINE: 'COMBINE';
KW_COMBINE_STRUCT_INDEX: 'STRUCT_INDEX';
KW_GLKJOIN: 'GLKJOIN';
KW_USE_INDEX: 'USE_INDEX';
KW_STARGATE: 'STARGATE';
KW_USE_BULKLOAD: 'USE_BULKLOAD';
KW_ADHOC: 'ADHOC';
KW_PRECOMPILE: 'PRECOMPILE';
KW_STREAMTABLE: 'STREAMTABLE';
KW_STREAM: 'STREAM';
KW_STREAMS: 'STREAMS';
KW_METRIC: 'METRIC';
KW_METRICS: 'METRICS';
KW_RULEBASE: 'RULEBASE';
KW_RULEBASES: 'RULEBASES';
KW_RULE: 'RULE';
KW_RULES: 'RULES';
KW_RULEPROPERTIES: 'RULEPROPERTIES';
KW_MEET: 'MEET';
KW_MUST: 'MUST';
KW_MUSTNOT: 'MUSTNOT';
KW_NONE: 'NONE';
KW_POLICY: 'POLICY';
KW_POLICIES: 'POLICIES';
KW_REMOVE: 'REMOVE';
KW_POLICYKEY: 'POLICYKEY';
KW_POLICY_RULE: 'POLICYRULE';
KW_LOOKUP: 'LOOKUP';
KW_POLICYPROPERTIES: 'POLICYPROPERTIES';
KW_RULE_FUNCTION: 'RULEFUNCTION';
KW_RULE_FUNCTIONS: 'RULEFUNCTIONS';
KW_APPPROPERTIES: 'APPPROPERTIES';
KW_JOBPROPERTIES: 'JOBPROPERTIES';
KW_RULE_FUNCTION_PROPERTIES: 'RULEFUNCTIONPROPERTIES';
KW_HOLD_DDLTIME: 'HOLD_DDLTIME';
KW_CLUSTERSTATUS: 'CLUSTERSTATUS';
KW_UTC: 'UTC';
KW_UTCTIMESTAMP: 'UTC_TMESSTAMP';
KW_LONG: 'LONG';
KW_DELETE: 'DELETE';
KW_PLUS: 'PLUS';
KW_MINUS: 'MINUS';
KW_OP_CONCAT: 'OP_CONCAT';
KW_FETCH: 'FETCH';
KW_INTERSECT: 'INTERSECT';
KW_EXCEPT: 'EXCEPT';
KW_VIEW: 'VIEW';
KW_VIEWS: 'VIEWS';
KW_IN: 'IN';
KW_DATABASE: 'DATABASE';
KW_DATABASES: 'DATABASES';
KW_MATERIALIZED: 'MATERIALIZED';
KW_SCHEMA: 'SCHEMA';
KW_SCHEMAS: 'SCHEMAS';
KW_GRANT: 'GRANT';
KW_REVOKE: 'REVOKE';
KW_SSL: 'SSL';
KW_UNDO: 'UNDO';
KW_LOCK: 'LOCK';
KW_LOCKS: 'LOCKS';
KW_UNLOCK: 'UNLOCK';
KW_SHARED: 'SHARED';
KW_EXCLUSIVE: 'EXCLUSIVE';
KW_PROCEDURE: 'PROCEDURE';
KW_UNSIGNED: 'UNSIGNED';
KW_WHILE: 'WHILE';
KW_READ: 'READ';
KW_READS: 'READS';
KW_PURGE: 'PURGE';
KW_RANGE: 'RANGE';
KW_ANALYZE: 'ANALYZE';
KW_BEFORE: 'BEFORE';
KW_BETWEEN: 'BETWEEN';
KW_BOTH: 'BOTH';
KW_BINARY: 'BINARY';
KW_CROSS: 'CROSS';
KW_CURSOR: 'CURSOR';
KW_DEFAULT : 'DEFAULT';
KW_ROWTYPE: 'ROWTYPE';
KW_TYPE: 'TYPE';
KW_TRIGGER: 'TRIGGER';
KW_RECORDREADER: 'RECORDREADER';
KW_RECORDWRITER: 'RECORDWRITER';
KW_SEMI: 'SEMI';
KW_ANTISEMI: 'ANTISEMI';
KW_LATERAL: 'LATERAL';
KW_TOUCH: 'TOUCH';
KW_ARCHIVE: 'ARCHIVE';
KW_UNARCHIVE: 'UNARCHIVE';
KW_COMPUTE: 'COMPUTE';
KW_STATISTICS: 'STATISTICS';
KW_USE: 'USE';
KW_OPTION: 'OPTION';
KW_CONCATENATE: 'CONCATENATE';
KW_SHOW_DATABASE: 'SHOW_DATABASE';
KW_UPDATE: 'UPDATE';
KW_BATCHUPDATE: 'BATCHUPDATE';
KW_RESTRICT: 'RESTRICT';
KW_CASCADE: 'CASCADE';
KW_SKEWED: 'SKEWED';
KW_ROLLUP: 'ROLLUP';
KW_CUBE: 'CUBE';
KW_DIRECTORIES: 'DIRECTORIES';
KW_FOR: 'FOR';
KW_LOOP: 'LOOP';
KW_WINDOW: 'WINDOW';
KW_WINDOWRESET: 'RESET';
KW_SESSIONWINDOW: 'SESSIONWINDOW';
KW_SESSIONSTART: 'INIT';
KW_SESSIONSTOP: 'SESSIONEND';
KW_SESSIONEXPIRE: 'EXPIRE';
KW_SESSIONEXPIRE_DISCARD: 'DISCARD';
KW_SESSIONEXPIRE_COMPLETE: 'COMPLETE';
KW_SESSIONPARTITION: 'KEYEDBY';
KW_STREAMWINDOW: 'STREAMWINDOW';
KW_STREAMWINDOWSLIDELENGTH: 'SLIDE';
KW_STREAMWINDOWSEPARATED: 'SEPARATED';
KW_SESSIONWINDOW_INCLUDE: 'INCLUDE';
KW_SESSIONWINDOW_EXCLUDE: 'EXCLUDE';
KW_UNBOUNDED: 'UNBOUNDED';
KW_PRECEDING: 'PRECEDING';
KW_FOLLOWING: 'FOLLOWING';
KW_FOLLOWEDBY: 'FOLLOWEDBY';
KW_NOTFOLLOWEDBY: 'NOTFOLLOWEDBY';
KW_NOTNEXT: 'NOTNEXT';
KW_PATTERN_TIMES: 'TIMES';
KW_CURRENT: 'CURRENT';
KW_CURRVALUE: 'CURRVAL';
KW_LESS: 'LESS';
KW_MORE: 'MORE';
KW_THAN: 'THAN';
KW_OVER: 'OVER';
KW_GROUPING: 'GROUPING';
KW_SETS: 'SETS';
KW_TRUNCATE: 'TRUNCATE';
KW_NOSCAN: 'NOSCAN';
KW_PARTIALSCAN: 'PARTIALSCAN';
KW_USER: 'USER';
KW_QUOTA: 'QUOTA';
KW_PERMISSION: 'PERMISSION';
KW_ROLE: 'ROLE';
KW_ROLES: 'ROLES';
KW_INNER: 'INNER';
KW_EXCHANGE: 'EXCHANGE';
KW_ADMIN: 'ADMIN';
KW_OWNER: 'OWNER';
KW_PRINCIPALS: 'PRINCIPALS';
KW_NATURAL: 'NATURAL';
KW_RETURN: 'RETURN';
KW_BREAK: 'BREAK';
KW_CONTINUE: 'CONTINUE';
KW_BEGIN: 'BEGIN';
KW_NUMBER: 'NUMBER';
KW_BLOB: 'BLOB';
KW_CLOB: 'CLOB';
KW_BFILE: 'BFILE';
KW_DECLARE: 'DECLARE';
KW_CONSTANT: 'CONSTANT';
KW_CONSTRAINT: 'CONSTRAINT';
KW_INOUT: 'INOUT';
KW_VALUES: 'VALUES';
// for INTERVAL variable
KW_YEAR: 'YEAR';
KW_MONTH: 'MONTH';
KW_DAY: 'DAY';
KW_MINUTE: 'MINUTE';
KW_HOUR: 'HOUR';
KW_SECOND: 'SECOND';
KW_INTERVAL: 'INTERVAL';
KW_EXTRACT: 'EXTRACT';
KW_SUBSTRING: 'SUBSTRING';
KW_SYSDATE: 'SYSDATE';
KW_SYSTIMESTAMP: 'SYSTIMESTAMP';
KW_SYSTIME: 'SYSTIME';
KW_CALL: 'CALL';
KW_EXEC: 'EXECUTE';
KW_MAXVALUE: 'MAXVALUE';
KW_NOMAXVALUE: 'NOMAXVALUE';
KW_MINVALUE: 'MINVALUE';
KW_NOMINVALUE: 'NOMINVALUE';
KW_CYCLE: 'CYCLE';
KW_CACHE: 'CACHE';
KW_CACHEDMETRIC: 'CACHEDMETRIC';
KW_CACHEDMETRICS: 'CACHEDMETRICS';
KW_NOCACHE: 'NOCACHE';
KW_NOORDER: 'NOORDER';
KW_BULK: 'BULK';
KW_COLLECT: 'COLLECT';
KW_VARYING: 'VARYING';
KW_EXCEPTION: 'EXCEPTION';
KW_MERGE: 'MERGE';
KW_MATCHED: 'MATCHED';
KW_PLANT: 'PLANT';
KW_IMMEDIATE: 'IMMEDIATE';
KW_COMPACT: 'COMPACT';
KW_COMPACTIONS: 'COMPACTIONS';
KW_START: 'START';
KW_STOP: 'STOP';
KW_LIST: 'LIST';
KW_TRANSACTION: 'TRANSACTION';
KW_COMMIT: 'COMMIT';
KW_ROLLBACK: 'ROLLBACK';
KW_WORK: 'WORK';
KW_SPACE: 'SPACE';
KW_ISOLATION: 'ISOLATION';
KW_COMMITTED: 'COMMITTED';
KW_SERIALIZABLE: 'SERIALIZABLE';
KW_UNIQUE: 'UNIQUE';
KW_CONF: 'CONF';
KW_DEFINED: 'DEFINED';
KW_INTEGER: 'INTEGER';
KW_ONLY: 'ONLY';
KW_SERVER: 'SERVER';
KW_TRANSACTIONS: 'TRANSACTIONS';
KW_URI: 'URI';
KW_WRITE: 'WRITE';
KW_FACL: 'FACL';
KW_FOUND: 'FOUND';
KW_LEVEL: 'LEVEL';
KW_PUBLIC: 'PUBLIC';
KW_LINK: 'LINK';
KW_LINKS: 'LINKS';
KW_CONNECT: 'CONNECT';
KW_IDENTIFIED: 'IDENTIFIED';
KW_APPLICATION: 'APPLICATION';
KW_APPLICATIONS: 'APPLICATIONS';
KW_APP: 'APP';
KW_APPS: 'APPS';
KW_INFINITE: 'INFINITE';
KW_REWRITE: 'REWRITE';
KW_NO_REWRITE: 'NO_REWRITE';
KW_WAIT: 'WAIT';
KW_PRIMARY: 'PRIMARY';
KW_FOREIGN: 'FOREIGN';
KW_REFERENCES: 'REFERENCES';
KW_VALIDATE: 'VALIDATE';
KW_NOVALIDATE: 'NOVALIDATE';
KW_RELY: 'RELY';
KW_NORELY: 'NORELY';
KW_KEY: 'KEY';
//for hyperbase index
KW_SEGMENT: 'SEGMENT';
KW_LENGTH: 'LENGTH';
KW_ATTACH: 'ATTACH';
KW_DETTACH: 'DETTACH';
KW_SHARD: 'SHARD';
KW_NUM: 'NUM';
KW_FULLTEXT: 'FULLTEXT';
KW_DOCVALUES: 'DOCVALUES';
//for holodesk on shiva
KW_TABLESIZE: 'TABLESIZE';
KW_TABLET: 'TABLET';
KW_CAPACITY: 'CAPACITY';
//esdrive
KW_REPLICATION : 'REPLICATION';
KW_APPEND : 'APPEND';
KW_ANALYZER : 'ANALYZER';
KW_SYNC : 'SYNC';
KW_NO_INDEX: 'NO_INDEX';
KW_LOG: 'LOG';
KW_ERRORS: 'ERRORS';
KW_REJECT: 'REJECT';
KW_OFFSET: 'OFFSET';
KW_FILE: 'FILE';
KW_JAR: 'JAR';
KW_PERMANENT: 'PERMANENT';
KW_GRAPH_PATH: 'GRAPH_PATH';
KW_BLACKLIST: 'BLACKLIST';
KW_SCHEDULER: 'SCHEDULER';
KW_MODE: 'MODE';
//***Added by xingyu
KW_POLICYBASES:'POLICYBASES';
KW_QUALIFY:'QUALIFY';

//***End of Added by xingyu
RARROW : '->';
DOT : '.'; // generated as a part of Number rule
COLON : ':' ;
COMMA : ',' ;
SEMICOLON : ';' ;
LPAREN : '(' ;
RPAREN : ')' ;
LSQUARE : '[' ;
RSQUARE : ']' ;
LCURLY : '{';
RCURLY : '}';
EQUAL : '=' | '==';
EQUAL_NS : '<=>';
NOTEQUAL : '<>' | '!=';
LESSTHANOREQUALTO : '<=';
LESSTHAN : '<';
DOUBLELESSTHAN : '<<';
GREATERTHANOREQUALTO : '>=';
GREATERTHAN : '>';
DOUBLEGREATERTHAN : '>>';
DIVIDE : '/';
PLUS : '+';
MINUS : '-';
STAR : '*';
MOD : '%';
DIV : 'DIV';
OP_CONCAT : '||';
AMPERSAND : '&';
TILDE : '~';
BITWISEOR : '|';
BITWISEXOR : '^';
QUESTION : '?';
DOLLAR : '$';
ASSIGN_OP : ':=';
AT : '@';
NAMED_NOTATION : '=>';
RANGE_OP: '..';
OUTER_JOIN_SIGN: LPAREN PLUS RPAREN;
// LITERALS
fragment
Letter
    : 'a'..'z' | 'A'..'Z' | '\u0080'..'\u00FF' | '\u0400'..'\u04FF'
    | '\u0600'..'\u06FF' | '\u0900'..'\u09FF' | '\u4E00'..'\u9FFF' | '\u0A00'..'\u0A7F'
    ;
fragment
HexDigit
    : 'a'..'f' | 'A'..'F'
    ;
//fragment, comment out by xingyu
Digit
    :
    '0'..'9'
    ;
fragment
Exponent
    :
    ('e' | 'E') ( PLUS|MINUS )? (Digit)+
    ;
fragment
RegexComponent
    : 'a'..'z' | 'A'..'Z' | '0'..'9' | '_'
    | PLUS | STAR | QUESTION | MINUS | DOT
    | LPAREN | RPAREN | LSQUARE | RSQUARE | LCURLY | RCURLY
    | BITWISEXOR | BITWISEOR | DOLLAR | '\u0080'..'\u00FF' | '\u0400'..'\u04FF'
    | '\u0600'..'\u06FF' | '\u0900'..'\u09FF' | '\u4E00'..'\u9FFF' | '\u0A00'..'\u0A7F'
    ;
StringLiteral
    :
    ( '\'' ( ~('\''|'\\') | ('\\' .) )* '\''
    | '"' ( ~('"'|'\\') | ('\\' .) )* '"'
    )+
    ;
CharSetLiteral
    :
    StringLiteral
    | '0' 'X' (HexDigit|Digit)+
    ;
BigintLiteral
    :
    (Digit)+ 'L'
    ;
SmallintLiteral
    :
    (Digit)+ 'S'
    ;
TinyintLiteral
    :
    (Digit)+ 'Y'
    ;
DecimalLiteral
    :
    Number 'B' 'D'
    ;
ByteLengthLiteral
    :
    (Digit)+ ('b' | 'B' | 'k' | 'K' | 'm' | 'M' | 'g' | 'G' | 't' | 'T')
    ;
IntRangeMin
    :
    (Digit)+ RANGE_OP
    ;
Number
    :
    (Digit)+ ( DOT (Digit)* (Exponent)? | Exponent)?
    ;
Identifier
    :
    (Letter | Digit | '_') (Letter | Digit | '_' | '$')*
    | '`' RegexComponent+ '`'
    ;
CharSetName
    :
    '_' (Letter | Digit | '_' | '-' | '.' | ':' )+
    ;
C_COMMENT_LEFT
    :
    '/*'
    ;
C_COMMENT_RIGHT
    :
    '*/'
    ;
C_COMMENT
    :
    (C_COMMENT_LEFT (' '|'\r'|'\t'|'\n')* C_COMMENT_RIGHT
    |
    C_COMMENT_LEFT  ~[+] .*?  C_COMMENT_RIGHT) -> channel(HIDDEN)
    ;
HINT_LEFT
    :
    C_COMMENT_LEFT (' '|'\r'|'\t'|'\n')* PLUS
    ;
WS  :  (' '|'\r'|'\t'|'\n') -> channel(HIDDEN)
    ;
COMMENT
  : ('--' (~('\n'|'\r'))*) -> channel(HIDDEN)
  ;
CPP_COMMENT
  : ('//' (~('\n'|'\r'))*) -> channel(HIDDEN)
  ;
//*******************************IdentifiersParser.g*******************************//
aliasNonReserved
    : KW_AT
    ;
alias
    : Identifier
    | aliasNonReserved
    | value = StringLiteral
    // {value.setText(this.trimQuotes(value.getText()));}
    ;
identifier
    : Identifier
    | commonNonReserved
    | dialectNonReserved
    ;
columnAlias
    : identifier
    | value = StringLiteral
    // {value.setText(this.trimQuotes(value.getText()));}
    ;
commonNonReserved
    : KW_TRUE | KW_FALSE
    | KW_LIKE | KW_EXISTS
    | KW_ASC | KW_DESC
    | KW_ORDER | KW_GROUP | KW_BY
    | KW_INSERT | KW_OVERWRITE
    | KW_OUTER | KW_LEFT | KW_RIGHT | KW_FULL
    | KW_PARTITION | KW_PARTITIONS
    | KW_PATTERN | KW_FOLLOWEDBY | KW_NOTFOLLOWEDBY | KW_NOTNEXT | KW_PATTERN_TIMES | KW_WITHIN
    | KW_TABLE | KW_TABLES | KW_COLUMNS | KW_INDEXES | KW_INDEX
    | KW_REBUILD | KW_FUNCTIONS |KW_RESOURCE | KW_SHOW | KW_MSCK | KW_REPAIR
    | KW_DIRECTORY | KW_LOCAL | KW_USING | KW_GLOBAL | KW_FULLTEXT
    | KW_CLUSTER | KW_DISTRIBUTE | KW_SORT | KW_UNION
    | KW_LOAD | KW_EXPORT | KW_IMPORT | KW_DATA | KW_INPATH
    | KW_IS
    | KW_CREATE | KW_EXTERNAL
    | KW_ALTER | KW_CHANGE
    | KW_FIRST | KW_LAST | KW_AFTER
    | KW_DESCRIBE | KW_DROP | KW_RENAME | KW_IGNORE| KW_RESPECT |  KW_PROTECTION
    | KW_TO | KW_COMMENT | KW_PROMPT | KW_SPOOL
    | KW_BOOLEAN | KW_TINYINT | KW_BYTE | KW_SMALLINT | KW_INT | KW_BIGINT | KW_FLOAT | KW_DOUBLE
    | KW_DATE | KW_INTERVAL | KW_DATETIME | KW_TIMESTAMP | KW_TIME | KW_GEO
    | KW_DECIMAL| KW_STRING
    | KW_ARRAY | KW_STRUCT | KW_UNIONTYPE
    | KW_PARTITIONED | KW_CLUSTERED | KW_SORTED | KW_BUCKETS | KW_ROUTED | KW_HASH
    | KW_ROW | KW_ROWS | KW_FORMAT | KW_DELIMITED | KW_FIELDS | KW_TERMINATED | KW_ESCAPED | KW_COLLECTION | KW_ITEMS | KW_KEYS | KW_KEY_TYPE | KW_LINES | KW_STORED
    | KW_FILEFORMAT | KW_SEQUENCEFILE | KW_TEXTFILE | KW_CSVFILE | KW_FWCFILE | KW_RCFILE | KW_ORCFILE | KW_ORCTRANSACTIONFILE | KW_PARQUET | KW_HYPERDRIVE | KW_INPUTFORMAT | KW_OUTPUTFORMAT | KW_INPUTDRIVER | KW_OUTPUTDRIVER
    | KW_OFFLINE | KW_ENABLE | KW_DISABLE
    | KW_READONLY | KW_NO_DROP | KW_LOCATION | KW_BUCKET
    | KW_OUT | KW_OF | KW_PERCENT | KW_ADD | KW_REPLACE | KW_RLIKE | KW_REGEXP
    | KW_TEMPORARY | KW_EXPLAIN | KW_FORMATTED | KW_PRETTY | KW_DEPENDENCY | KW_LOGICAL | KW_COST
    | KW_SERDE | KW_WITH | KW_DEFERRED | KW_SERDEPROPERTIES | KW_DBPROPERTIES | KW_LIMIT
    | KW_UNSET | KW_TBLPROPERTIES | KW_IDXPROPERTIES | KW_VALUE_TYPE | KW_ELEM_TYPE
    | KW_MAPJOIN | KW_COMBINE | KW_COMBINE_STRUCT_INDEX | KW_GLKJOIN | KW_USE_INDEX | KW_ADHOC | KW_STARGATE | KW_ESDRIVE
    | KW_WINDOWRESET | KW_STREAMTABLE | KW_STREAM | KW_STREAMWINDOW | KW_STREAMWINDOWSLIDELENGTH | KW_STREAMWINDOWSEPARATED | KW_INFINITE | KW_SESSIONSTART | KW_SESSIONSTOP | KW_SESSIONEXPIRE | KW_SESSIONEXPIRE_DISCARD | KW_SESSIONEXPIRE_COMPLETE
    | KW_APPLICATION | KW_APPLICATIONS | KW_APP | KW_APPS | KW_STREAMJOB | KW_STREAMJOBS
    | KW_RULE | KW_RULES | KW_RULEBASE | KW_RULEBASES
    | KW_POLICY | KW_POLICIES | KW_POLICYKEY | KW_POLICY_RULE | KW_MEET | KW_LOOKUP | KW_MUST | KW_MUSTNOT | KW_REMOVE
    | KW_RULE_FUNCTION | KW_RULE_FUNCTIONS | KW_RULE_FUNCTION_PROPERTIES
    | KW_STOP | KW_AT
    | KW_LIST
    | KW_PRECOMPILE
    | KW_HOLD_DDLTIME | KW_CLUSTERSTATUS
    | KW_UTC | KW_UTCTIMESTAMP | KW_LONG
    | KW_DELETE
    | KW_PLUS | KW_MINUS
    | KW_OP_CONCAT | KW_FETCH | KW_INTERSECT
    | KW_VIEW | KW_IN | KW_DATABASES
    | KW_MATERIALIZED | KW_SCHEMA | KW_SCHEMAS
    | KW_GRANT | KW_REVOKE
    | KW_SSL | KW_UNDO | KW_LOCK | KW_LOCKS | KW_UNLOCK | KW_SHARED | KW_EXCLUSIVE
    | KW_PROCEDURE | KW_UNSIGNED | KW_WHILE
    | KW_READ | KW_READS | KW_PURGE | KW_RANGE | KW_RELOAD
    | KW_ANALYZE | KW_BEFORE | KW_BETWEEN | KW_BOTH | KW_BINARY
    | KW_TRIGGER | KW_RECORDREADER | KW_RECORDWRITER | KW_SEMI
    | KW_LATERAL | KW_TOUCH | KW_ARCHIVE | KW_UNARCHIVE | KW_COMPUTE | KW_STATISTICS
    | KW_USE | KW_OPTION | KW_CONCATENATE
    | KW_SHOW_DATABASE | KW_UPDATE | KW_RESTRICT | KW_CASCADE | KW_SKEWED | KW_DIRECTORIES
    | KW_GROUPING | KW_SETS | KW_TRUNCATE | KW_NOSCAN| KW_USER
    | KW_QUOTA | KW_ROLE | KW_ROLES
    | KW_INNER | KW_ADMIN | KW_OWNER | KW_PRINCIPALS | KW_ALL | KW_ANY
    | KW_YEAR | KW_MONTH | KW_DAY | KW_HOUR | KW_MINUTE | KW_SECOND
    | KW_DEFAULT | KW_TYPE
    | KW_NEXT
    | KW_MERGE | KW_PLANT
    | KW_CONSTANT | KW_CONSTRAINT | KW_IMMEDIATE
    | KW_TRANSACTION | KW_WORK
    | KW_USE_BULKLOAD | KW_COMPACT
    | KW_CONF | KW_DEFINED | KW_INTEGER | KW_ONLY | KW_SERVER | KW_TRANSACTIONS | KW_URI | KW_WRITE
    | KW_SPACE
    | KW_FACL | KW_NULLS
    | KW_PERMISSION
    | KW_LEVEL
    | KW_PUBLIC | KW_CONNECT | KW_LINKS
    | KW_SEGMENT | KW_LENGTH | KW_ATTACH | KW_DETTACH | KW_SHARD |  KW_TABLESIZE | KW_TABLET | KW_CAPACITY | KW_NUM | KW_NO | KW_LOG
    | KW_PRIOR | KW_NOCYCLE
    | KW_JAR | KW_FILE | KW_PERMANENT
    | KW_CACHE | KW_CACHEDMETRIC | KW_CACHEDMETRICS | KW_CYCLE | KW_INCREMENT | KW_SEQUENCE | KW_SEQUENCES | KW_MINVALUE | KW_NOCACHE | KW_NOMAXVALUE | KW_NOMINVALUE | KW_NOORDER | KW_CURRVALUE | KW_NEXTVALUE
    | KW_RELY | KW_NORELY | KW_VALIDATE | KW_NOVALIDATE | KW_KEY | KW_REFERENCES | KW_FOREIGN | KW_PRIMARY
    | KW_HOLODESK | KW_STELLARDB
    | KW_ANALYZER |KW_SYNC | KW_NO_INDEX | KW_SCHEDULER | KW_MODE
    | KW_WAIT
    ;
// TODO Keywords eleted from commonNonReserved, which is only defined in KeyWords.g and conflict with HiveLexer.g
// KW_NEXTEVENT

//*******************************CommonExpressionParser.g*******************************//
keyValueProperty
    :
      key=StringLiteral EQUAL value=StringLiteral
    ;
keyProperty
    :
      key=StringLiteral
    ;
tableName
    :
    db=identifier DOT tab=identifier (at=AT link=identifier)?
    |
    tab=identifier (at=AT link=identifier)?
    ;
valuesName
    :
    tab=identifier
    ;
viewName
    :
    tableName
    ;
tableAlias
    :
    identifier
    ;
sequenceName
    :
    db=identifier DOT seq=identifier
    |
    seq=identifier
    ;
partitionSpec
    :
    KW_PARTITION
     LPAREN partitionVal (COMMA  partitionVal )* RPAREN
    |
    KW_PARTITION
     identifierList
    ;
partitionVal
    :
    identifier (EQUAL constant)?
    ;
storedAsDirs
    : KW_STORED KW_AS KW_DIRECTORIES
    ;
orReplace
    : KW_OR KW_REPLACE
    ;
columnList
    : columnNameTypeList
    | columnNameList
    ;
columnNameTypeList
    : columnNameType (COMMA columnNameType)*
    ;
columnNameColonTypeList
    : columnNameColonType (COMMA columnNameColonType)*
    ;
columnNameOrderList
    : columnNameOrder (COMMA columnNameOrder)*
    ;
columnNameOrder
    : identifier (asc=KW_ASC | desc=KW_DESC)?
    ;
columnNameCommentList
    : columnNameComment (COMMA columnNameComment)*
    ;
columnNameComment
    : colName=identifier (comment=columnComment)?
    ;
nullsOrder
    : KW_NULLS
    (
      KW_FIRST
    | KW_LAST
    )
    ;
columnRefOrder
    : expression (asc=KW_ASC | desc=KW_DESC)? nullsOrder?
    ;
columnNameType
    : colName=identifier colType columnAnalyzer? defaultVauleOrColumnConstraint? columnComment?
    ;
columnAnalyzer
    :
    KW_WITH KW_ANALYZER p=StringLiteral analyzer=StringLiteral
    | KW_APPEND KW_ANALYZER p=StringLiteral analyzer=StringLiteral
    | KW_NO_INDEX
    ;
defaultValueNode
    : KW_DEFAULT defaultVal=constantOrNull
    ;
constantOrNull
    : defaultConstantValue
    | KW_NULL
    ;
columnComment
    : KW_COMMENT comment=StringLiteral
    ;
columnNameList
    : columnName (COMMA columnName)*
    ;
columnName
    :
      identifier
    ;
columnOrtableDotColumnNameList
    : columnOrtableDotColumnName (COMMA columnOrtableDotColumnName)*
    ;
columnOrtableDotColumnName
    : identifier DOT columnName
    | columnName
    ;
columnOrtableDotColumnWithDBNameList
    : columnOrtableDotColumnWithDBName (COMMA columnOrtableDotColumnWithDBName)*
    ;
columnOrtableDotColumnWithDBName
    : db=identifier DOT tab=identifier (secondDot=DOT column=identifier)?
    | columnName
    ;
tableOrPartition
   :
   tableName partitionSpec? (LPAREN columnNameList RPAREN)?
   ;
tableOrColumnAliasOfValues
   :
   valuesName (LPAREN columnNameList RPAREN)?
   ;
//-----------------------------------------------------------------------------------
//---------------------- Rules for parsing PTF clauses -----------------------------
partitionTableFunctionSource
   :
   subQuerySource |
   tableSource |
   partitionedTableFunction
   ;
partitionedTableFunction
   :
   name=Identifier
   LPAREN KW_ON ptfsrc=partitionTableFunctionSource partitioningSpec?
     (Identifier LPAREN expression RPAREN ( COMMA Identifier LPAREN expression RPAREN)*)?
   RPAREN alias?
   ;
//-----------------------------------------------------------------------------------
tableAllColumns
    : STAR
    | tableName DOT STAR
    ;
// (table|column)
tableOrColumn
    :
    identifier
    ;
aliasList
    :
    identifierList
    ;
capIdentifierList
    : Identifier (COMMA Identifier)*
    ;
identifierList
    : identifier (COMMA identifier)*
    ;
//*******************************AlterStatementParser.g*******************************//
alterStatement
    : KW_ALTER
        (
            KW_TABLE alterTableStatementSuffix
        |
            KW_STREAM alterTableStatementSuffix
        |
            KW_VIEW alterViewStatementSuffix[false]
        |
            KW_MATERIALIZED KW_VIEW alterViewStatementSuffix[true]
        |
            KW_INDEX alterIndexStatementSuffix
        |
            KW_DATABASE alterDatabaseStatementSuffix
        |
            (KW_APPLICATION|KW_APP) alterApplicationStatementSuffix
        |
            KW_STREAMJOB alterJobStatementSuffix
        |
            KW_POLICY alterPolicyStatementSuffix
        |
            KW_RULE KW_GROUP alterPolicyRuleGroupSuffix
        |
            KW_RULE alterRuleStatementSuffix
        |
            KW_SEQUENCE alterSequenceStatementSuffix
        |
            KW_BLACKLIST alterBlacklistStatementSuffix
        |
            KW_RULE_FUNCTION alterRuleFunctionStatementSuffix
        )
    ;
alterSequenceStatementSuffix
    : name=sequenceName sequenceOptionWithoutStart+
    ;
alterTableStatementSuffix
    : alterStatementSuffixRename
    | alterStatementSuffixAddCol
    | alterStatementSuffixRenameCol
    | alterStatementSuffixDropPartitions
    | alterStatementSuffixAddPartitions
    | alterStatementSuffixTouch
    | alterStatementSuffixArchive
    | alterStatementSuffixUnArchive
    | alterStatementSuffixProperties
    | alterTblPartitionStatement
    | alterStatementSuffixSkewedby
    | alterStatementSuffixExchangePartition
    | alterStatementPartitionKeyType
    | alterStatementErrorLogSetting
    | alterStatementSuffixDropConstraint
    | alterStatementSuffixAddConstraint
    | alterStatementIntervalValue
    ;
   /*catch [MismatchedTokenException ex] {
       throw new AllAltMismatchException(input, "alter table statement suffix");
   }*/
alterStatementPartitionKeyType
    : tableName KW_PARTITION KW_COLUMN LPAREN columnNameType RPAREN
    ;
alterViewStatementSuffix[boolean materialized]
    : alterViewSuffixProperties[materialized]
    | alterStatementSuffixRename
    | alterStatementSuffixRenameCol
    | alterStatementSuffixAddPartitions
    | alterStatementSuffixDropPartitions
    | name=tableName KW_AS selectStatement
    | name=tableName KW_ENABLE KW_REWRITE
    | name=tableName KW_DISABLE KW_REWRITE
    | name=tableName KW_REBUILD
    ;
   /*catch [MismatchedTokenException ex] {
       throw new AllAltMismatchException(input, "alter view statement");
   }*/
alterIndexStatementSuffix
    : indexName=identifier
      (KW_ON tableNameId=identifier)
      partitionSpec?
    (
      KW_REBUILD
    |
      KW_SET key=identifier EQUAL value=StringLiteral
    |
      KW_UPDATE key=identifier EQUAL value=StringLiteral
    |
      KW_ATTACH columnNameList
    |
      KW_DETTACH columnNameList
    )
    ;
alterApplicationStatementSuffix
    : alterApplicationSuffixProperties
    | alterApplicationSuffixSetOwner
    ;
alterJobStatementSuffix
    : alterJobSuffixProperties
    ;
alterJobSuffixProperties
    : name=identifier KW_SET KW_JOBPROPERTIES dbProperties
    ;
alterApplicationSuffixProperties
    : name=identifier KW_SET KW_APPPROPERTIES dbProperties
    ;
alterApplicationSuffixSetOwner
    : name=identifier KW_SET KW_OWNER principalName
    ;
alterPolicyStatementSuffix
    : alterPolicySuffixProperties
      | alterPolicySuffixRootGroupType
    ;
alterPolicySuffixProperties
    : name=identifier KW_SET KW_POLICYPROPERTIES dbProperties
    ;
alterPolicySuffixRootGroupType
    : name=identifier KW_WITH KW_RULES KW_MEET ruleGroupType
    ;
alterPolicyRuleGroupSuffix
    : name=identifier KW_WITH KW_RULES KW_MEET ruleGroupType
    ;
alterRuleStatementSuffix
    : alterRuleSuffixProperties
    ;
alterRuleSuffixProperties
    : name=identifier KW_SET KW_RULEPROPERTIES dbProperties
    ;
alterRuleFunctionStatementSuffix
    : alterRuleFunctionSuffixProperties
    ;
alterRuleFunctionSuffixProperties
    : name=identifier KW_SET KW_RULE_FUNCTION_PROPERTIES dbProperties
    ;
alterDatabaseStatementSuffix
    : alterDatabaseSuffixProperties
    | alterDatabaseSuffixSetOwner
    ;
alterDatabaseSuffixProperties
    : name=identifier KW_SET KW_DBPROPERTIES dbProperties
    ;
alterDatabaseSuffixSetOwner
    : dbName=identifier KW_SET KW_OWNER principalName
    ;
alterStatementSuffixRename
    : oldName=tableName KW_RENAME KW_TO newName=tableName
    ;
alterStatementErrorLogSetting
    : tableName KW_SET KW_ERRORS KW_LOG onOffOpt? errorIntoTableOpt? errorOverwriteOpt? errorRejectOpt? errorLimitOpt?
    ;
onOffOpt
   : KW_ON|KW_OFF
   ;
errorIntoTableOpt
   : KW_INTO tableName
   ;
errorOverwriteOpt
   : KW_OVERWRITE onOffOpt
   ;
errorRejectOpt
   : KW_REJECT onOffOpt
   ;
errorLimitOpt
   : KW_LIMIT Number (ways=KW_ROWS | ways=KW_PERCENT)
   ;
alterStatementSuffixAddCol
    : tableName (add=KW_ADD | replace=KW_REPLACE) KW_COLUMNS LPAREN columnNameTypeList RPAREN restrictOrCascade?
    | tableName KW_DELETE KW_COLUMNS LPAREN identifierList RPAREN restrictOrCascade?
    ;
alterStatementSuffixRenameCol
    : tableName KW_CHANGE KW_COLUMN? oldName=identifier newName=identifier colType defaultVauleOrColumnConstraint? (KW_COMMENT comment=StringLiteral)? alterStatementChangeColPosition? restrictOrCascade?
    ;
blocking
  : KW_AND KW_WAIT
  ;
alterStatementSuffixCompact
    : KW_COMPACT compactType=StringLiteral blocking?
    | KW_ENABLE KW_COMPACT
    | KW_DISABLE KW_COMPACT (KW_FOR reason=StringLiteral)?
    ;
alterStatementSuffixUpdateStatsCol
    : KW_UPDATE KW_STATISTICS KW_FOR KW_COLUMN? colName=identifier KW_SET tableProperties (KW_COMMENT comment=StringLiteral)?
;
alterStatementChangeColPosition
    : first=KW_FIRST|KW_AFTER afterCol=identifier
    ;
alterStatementSuffixAddPartitions
    : tableName KW_ADD ifNotExists?
      (
      alterStatementSuffixAddPartitionsElement+
      |
      alterStatementSuffixAddRangePartitionsElement+
      )
    ;
alterStatementSuffixAddPartitionsElement
    : partitionSpec partitionLocation?
    ;
alterStatementSuffixAddRangePartitionsElement
    : rangePartition partitionLocation?
    ;
alterStatementSuffixTouch
    : tableName KW_TOUCH (partitionSpec)*
    ;
alterStatementSuffixArchive
    : tableName KW_ARCHIVE (partitionSpec)*
    ;
alterStatementSuffixUnArchive
    : tableName KW_UNARCHIVE (partitionSpec)*
    ;
partitionLocation
    :
      KW_LOCATION locn=StringLiteral
    ;
alterStatementSuffixDropPartitions
    : tableName KW_DROP ifExists? dropPartitionSpec (COMMA dropPartitionSpec)* ignoreProtection? KW_PURGE?
    ;
alterStatementSuffixProperties
    : tableName KW_SET KW_TBLPROPERTIES tableProperties
    | tableName KW_UNSET KW_TBLPROPERTIES ifExists? tableProperties
    ;
alterViewSuffixProperties[boolean materialized]
    : tableName KW_SET KW_TBLPROPERTIES tableProperties
    | tableName KW_UNSET KW_TBLPROPERTIES ifExists? tableProperties
    ;
alterStatementSuffixSerdeProperties
    : KW_SET KW_SERDE serdeName=StringLiteral (KW_WITH KW_SERDEPROPERTIES tableProperties)?
    | KW_SET KW_SERDEPROPERTIES tableProperties
    ;
alterTblPartitionStatement
  : tablePartitionPrefix alterTblPartitionStatementSuffix
  ;
alterTblPartitionStatementSuffix
  : alterStatementSuffixFileFormat
  | alterStatementSuffixLocation
  | alterStatementSuffixProtectMode
  | alterStatementSuffixMergeFiles
  | alterStatementSuffixSerdeProperties
  | alterStatementSuffixRenamePart
  | alterStatementSuffixBucketNum
  | alterTblPartitionStatementSuffixSkewedLocation
  | alterStatementSuffixClusterbySortby
  | alterStatementSuffixCompact
  | alterStatementSuffixUpdateStatsCol
  | alterStatementSuffixRenameCol
  | alterStatementSuffixAddCol
  ;
alterStatementSuffixFileFormat
    : KW_SET KW_FILEFORMAT fileFormat
    ;
alterStatementSuffixClusterbySortby
  : KW_NOT KW_CLUSTERED
  | KW_NOT KW_SORTED
  | tableBuckets
  ;
alterTblPartitionStatementSuffixSkewedLocation
  : KW_SET KW_SKEWED KW_LOCATION skewedLocations
  ;
skewedLocations
    :
      LPAREN skewedLocationsList RPAREN
    ;
skewedLocationsList
    :
      skewedLocationMap (COMMA skewedLocationMap)*
    ;
skewedLocationMap
    :
      key=skewedValueLocationElement EQUAL value=StringLiteral
    ;
alterStatementSuffixLocation
  : KW_SET KW_LOCATION newLoc=StringLiteral
  ;
alterStatementSuffixSkewedby
    :tableName tableSkewed
    |
    tableName KW_NOT KW_SKEWED
    |
    tableName KW_NOT storedAsDirs
    ;
alterStatementSuffixExchangePartition
    : name=tableName KW_EXCHANGE partitionSpec KW_WITH KW_TABLE exchangename=tableName
    ;
alterStatementSuffixProtectMode
    : alterProtectMode
    ;
alterStatementSuffixRenamePart
    : KW_RENAME KW_TO partitionSpec
    ;
alterStatementSuffixMergeFiles
    : KW_CONCATENATE
    ;
alterProtectMode
    : KW_ENABLE alterProtectModeMode
    | KW_DISABLE alterProtectModeMode
    ;
alterProtectModeMode
    : KW_OFFLINE
    | KW_NO_DROP KW_CASCADE?
    | KW_READONLY
    ;
alterStatementSuffixBucketNum
    : KW_INTO num=Number KW_BUCKETS
    ;
fileFormat
    : KW_SEQUENCEFILE
    | KW_TEXTFILE
    | KW_RCFILE
    | KW_ORCFILE
    | KW_ORCTRANSACTIONFILE
    | KW_PARQUET
    | KW_HYPERDRIVE
    | KW_INPUTFORMAT inFmt=StringLiteral KW_OUTPUTFORMAT outFmt=StringLiteral (KW_INPUTDRIVER inDriver=StringLiteral KW_OUTPUTDRIVER outDriver=StringLiteral)?
    | genericSpec=identifier
    ;
ignoreProtection
        : KW_IGNORE KW_PROTECTION
        ;
dropPartitionSpec
    :
    KW_PARTITION
     LPAREN dropPartitionVal (COMMA  dropPartitionVal )* RPAREN
     | KW_PARTITION
     identifierList
    ;
dropPartitionVal
    :
    identifier dropPartitionOperator constant
    ;
dropPartitionOperator
    :
    EQUAL | NOTEQUAL | LESSTHANOREQUALTO | LESSTHAN | GREATERTHANOREQUALTO | GREATERTHAN
    ;
alterBlacklistStatementSuffix
    : KW_ADD KW_USER identifier
    | KW_DELETE KW_USER identifier
    | KW_DELETE KW_ALL
    ;
alterStatementSuffixDropConstraint
   : tableName KW_DROP KW_CONSTRAINT cName=identifier
   ;
alterStatementSuffixAddConstraint
   :  tableName KW_ADD (fk=alterForeignKeyWithName | alterConstraintWithName)
   ;
alterConstraintWithName
    : KW_CONSTRAINT constraintName=identifier tableConstraintType pkCols=parenColumnNameList constraintOpts?
    ;
alterForeignKeyWithName
    : KW_CONSTRAINT constraintName=identifier KW_FOREIGN KW_KEY fkCols=parenColumnNameList  KW_REFERENCES tabName=tableName parCols=parenColumnNameList constraintOpts?
    ;
alterStatementIntervalValue
    : tableName KW_SET KW_INTERVAL LPAREN (intervalConst=constant|intervalFunction=normfunction)? RPAREN
    ;
//*******************************AtomExpressionParser.g*******************************//
atomExpression
    :
    KW_NULL
    | constant
    | widcardExpression
    | existExpression
    | castExpression
    | caseExpression
    | whenExpression
    | extractExpression
    | substringExpression
    | tableOrColumn
    | expressionsInParenthesis
    | LPAREN selectStatement RPAREN
    ;
//*******************************CallStatementParser.g*******************************//
sqlCallStatement
    : KW_CALL leftValue
    ;
//*******************************ConstantParser.g*******************************//
constant
    : timeTypeLiteral
    | Number
    | StringLiteral
//    | stringLiteralSequence
    | BigintLiteral
    | SmallintLiteral
    | TinyintLiteral
    | DecimalLiteral
    | CharSetLiteral
    | charSetStringLiteral
    | booleanValue
    | KW_MAXVALUE
    | KW_UNLIMITED
    ;
defaultConstantValue
    : timeTypeLiteral
    | MINUS nonNegativeDigitValue
    | nonNegativeDigitValue
    | StringLiteral
    | CharSetLiteral
    | charSetStringLiteral
    | booleanValue
    | KW_MAXVALUE
    | KW_UNLIMITED
    ;
nonNegativeDigitValue
    : Number
    | BigintLiteral
    | SmallintLiteral
    | TinyintLiteral
    | DecimalLiteral
    ;
stringLiteralSequence
    :
    StringLiteral StringLiteral+
    ;
charSetStringLiteral
    :
    csName=CharSetName csLiteral=CharSetLiteral
    ;
booleanValue
    :
    KW_TRUE | KW_FALSE
    ;
//*******************************ConstraintParser.g*******************************//
columnNameTypeOrConstraintList
    : columnNameTypeOrConstraint (COMMA columnNameTypeOrConstraint)*
    ;
columnNameTypeOrConstraint
    : ( tableConstraint )
    | ( columnNameType )
    ;
tableConstraint
    : ( createForeignKey )
    | ( createConstraint )
    ;
createForeignKey
    : (KW_CONSTRAINT constraintName=identifier)? KW_FOREIGN KW_KEY fkCols=parenColumnNameList  KW_REFERENCES tabName=tableName parCols=parenColumnNameList constraintOpts?
    ;
createConstraint
    : (KW_CONSTRAINT constraintName=identifier)? tableConstraintType pkCols=parenColumnNameList constraintOpts?
    ;
tableConstraintType
    : KW_PRIMARY KW_KEY
    ;
constraintOpts
    : enableSpecification validateSpecification relySpecification
    | validateSpecification relySpecification
    | enableSpecification validateSpecification
    | enableSpecification relySpecification
    | relySpecification
    | validateSpecification
    | enableSpecification
    ;
enableSpecification
    : KW_ENABLE
    | KW_DISABLE
    ;
validateSpecification
    : KW_VALIDATE
    | KW_NOVALIDATE
    ;
relySpecification
    :  KW_RELY
    |  KW_NORELY
    ;
columnConstraint
    : colPKConstraint
    | colFKConstraint
    ;
colPKConstraint
    : (KW_CONSTRAINT constraintName=identifier)? KW_PRIMARY KW_KEY constraintOpts?
    ;
colFKConstraint
    : (KW_CONSTRAINT constraintName=identifier)? KW_REFERENCES tabName=tableName LPAREN colName=columnName RPAREN constraintOpts?
    ;
parenColumnNameList
    : LPAREN columnNameList RPAREN
    ;
defaultVauleOrColumnConstraint
    : columnAttribute+
    ;
columnAttribute
    : dialectcolumnConstraint
    | columnConstraint
    | columnComment
    | defaultValueNode
    ;
//*******************************CRUDParser.g*******************************//
crudStatement
    : updateStatement
    | batchUpdateStatement
    | deleteStatement
    | mergeStatement
    ;
mergeStatement
    :  KW_MERGE KW_INTO crudTargetStatement
       KW_USING fromSource KW_ON (LPAREN expression RPAREN | expression)
       mergeUpdateClause? mergeInsertClause?
    ;
mergeUpdateClause
    :  KW_WHEN KW_MATCHED KW_THEN KW_UPDATE KW_SET update_set_elements
       whereClause? mergeDeleteClause?
    ;
mergeDeleteClause
    :  KW_DELETE whereClause
    ;
mergeInsertClause
    :  KW_WHEN KW_NOT KW_MATCHED KW_THEN KW_INSERT (LPAREN columnOrtableDotColumnNameList RPAREN)?
       valuesClause whereClause?
    ;
implicitInsertStatement
    : selectClause  KW_INTO identifier fromClause
    ;
updateStatement
    :  KW_UPDATE crudTargetStatement KW_SET update_set_clause_suffix
    ;
batchUpdateStatement
    :  KW_BATCHUPDATE KW_TABLE? tableOrPartition alias? batchUpdate_set_clause
    ;
batchUpdate_set_clause
    : KW_SET LPAREN columnOrtableDotColumnNameList RPAREN EQUAL batchValuesClause
      KW_WHERE LPAREN columnOrtableDotColumnNameList RPAREN KW_IN batchValuesClause
    ;
update_set_clause_suffix
    :  LPAREN columnOrtableDotColumnNameList RPAREN EQUAL LPAREN selectStatement RPAREN whereClause?
    |  update_set_clause_elements whereClause?
    ;
update_set_clause_elements
    : update_set_clause_element (COMMA update_set_clause_element)*
    ;
update_set_clause_element
    : columnOrtableDotColumnName EQUAL part=update_set_clause_element_part
    ;
update_set_clause_element_part
    : LPAREN selectStatement RPAREN
    | srcValue=expression
    ;
update_set_elements
    :  update_set_element (COMMA update_set_element)*
    ;
update_set_element
    :   //KW_SET columnName ASSIGN_OP expression
     columnOrtableDotColumnName EQUAL (srcValue=expression)
    ;
deleteStatement
    :  KW_DELETE KW_FROM? crudTargetStatement whereClause?
    ;
crudTargetStatement
    : KW_TABLE? tableName partitionSpec? (KW_AS? alias)?
    | subQuerySource
    ;
//*******************************DCLStatementParser.g*******************************//
dclStatement
    :  beginTransactionStatement
    |  commitTransactionStatement
    |  rollbackTransactionStatement
    |  transactionSettingStatement
    ;
beginTransactionStatement
    :  (KW_BEGIN | KW_START) (KW_WORK | KW_TRANSACTION)
    ;
commitTransactionStatement
    :  KW_COMMIT KW_WORK?
    ;
rollbackTransactionStatement
    :  KW_ROLLBACK KW_WORK?
    ;
transactionSettingStatement
    : KW_SET KW_TRANSACTION KW_READ (readMode=KW_ONLY|readMode=KW_WRITE)
    | KW_SET KW_TRANSACTION KW_ISOLATION KW_LEVEL ((KW_READ KW_COMMITTED) | KW_SERIALIZABLE)
    ;
//*******************************DDLAStatementParser.g*******************************//
ddlAStatement
    : createDatabaseStatement
    | switchDatabaseStatement
    | switchApplicationStatement
    | dropDatabaseStatement
    | createDbLinkStatement
    | dropDbLinkStatement
    | createTableStatement
    | createTemporaryTableStatement
    | createStreamStatement
    | createMetricStatement
    | createApplicationStatement
    | createJobStatement
    | createRuleStatement
    | dropRuleStatement
    | createRuleBaseStatement
    | switchRuleBaseStatement
    | dropRuleBaseStatement
    | createPolicyStatement
    | switchPolicyStatement
    | createRuleGroupStatement
    | createPolicyRuleStatement
    | dropPolicyStatement
    | dropPolicyRuleStatement
    | dropTableStatement
    | dropStreamStatement
    | dropMetricStatement
    | dropApplicationStatement
    | dropJobStatement
    | dropCachedMetricStatement
    | truncateCachedMetricStatement
    | truncateTableStatement
    | createSequenceStatement
    | dropSequenceStatement
    | createRuleFunctionStatement
    | dropRuleFunctionStatement
    ;
createDatabaseStatement
    : KW_CREATE (KW_DATABASE|KW_SCHEMA)
        ifNotExists?
        name=identifier
        databaseComment?
        dbLocation?
        (KW_WITH KW_DBPROPERTIES dbprops=dbProperties)?
    ;
switchDatabaseStatement
    : KW_USE identifier
    ;
switchApplicationStatement
    : KW_USE (KW_APPLICATION|KW_APP) identifier
    ;
dropDatabaseStatement
    : KW_DROP (KW_DATABASE|KW_SCHEMA) ifExists? identifier restrictOrCascade?
    ;
createDbLinkStatement
    :  KW_CREATE KW_SHARED? KW_PUBLIC? KW_DATABASE KW_LINK dblink
       (KW_CONNECT KW_TO dblinkUser KW_IDENTIFIED KW_BY dblinkPwd)?
       KW_USING dblinkService
    ;
dropDbLinkStatement
    :  KW_DROP KW_PUBLIC? KW_DATABASE KW_LINK ifExists? dblink
    ;
dblink
    :  identifier
    ;
dblinkUser
    :  identifier
    ;
dblinkPwd
    :  StringLiteral
    ;
dblinkService
    :  StringLiteral
    ;
createTableStatement
    : dialectCreateTableStatement
    ;
createTemporaryTableStatement
    : dialectCreateTemporaryTableStatement
    ;
tableDefinitionClause
    : like=KW_LIKE likeName=tableName tableLocation? tablePropertiesPrefixed?
    | dialectTableDefinitionClause
    ;
noDataCopyQuery
    : dialectWithNoData
    ;
createStreamStatement
    : KW_CREATE (temp=KW_TEMPORARY)? (ext=KW_EXTERNAL)? KW_STREAM ifNotExists? name=tableName
      (  like=KW_LIKE likeName=tableName
         tableLocation?
         tablePropertiesPrefixed?
       | (LPAREN columnNameTypeList RPAREN)?
         tableComment?
         tablePartition?
         tableBuckets?
         tableSkewed?
         tableRowFormat?
         tableFileFormat?
         tableLocation?
         tablePropertiesPrefixed?
         (KW_AS ctasTargetStatement)?
	     erroLogTableSpec?
      )
    ;
createMetricStatement
    : KW_CREATE (temp=KW_TEMPORARY)? (ext=KW_EXTERNAL)? KW_METRIC ifNotExists? name=tableName
      (  like=KW_LIKE likeName=tableName
         tableLocation?
         tablePropertiesPrefixed?
       | (LPAREN columnNameTypeList RPAREN)?
         tableComment?
         tablePartition?
         tableBuckets?
         tableSkewed?
         tableRowFormat?
         tableFileFormat?
         tableLocation?
         tablePropertiesPrefixed?
         (KW_AS ctasTargetStatement)?
	     erroLogTableSpec?
      )
    ;
streamJob
    : LPAREN sql=StringLiteral RPAREN
    ;
createJobStatement
    : KW_CREATE KW_STREAMJOB ifNotExists? name=tableName
        KW_AS job=streamJob
        (KW_JOBPROPERTIES dbprops=dbProperties)?
    ;
streamRule
    : LPAREN sql=StringLiteral RPAREN
    ;
createRuleStatement
    : KW_RULE ifNotExists? name=tableName
        KW_AS streamRule
        (KW_RULEPROPERTIES dbprops=dbProperties)?
    ;
dropRuleStatement
    : KW_DROP KW_RULE ifExists? tableName
    ;
createRuleBaseStatement
    : KW_CREATE KW_RULEBASE
        ifNotExists?
        name=identifier
        databaseComment?
        (KW_WITH KW_DBPROPERTIES dbprops=dbProperties)?
    ;
switchRuleBaseStatement
    : KW_USE (KW_RULEBASE)identifier
    ;
dropRuleBaseStatement
    : KW_DROP KW_RULEBASE ifExists? identifier restrictOrCascade?
    ;
ruleGroupType
   : KW_ANY|KW_ALL
     | KW_PERCENT LPAREN percent=Number RPAREN
   ;
createPolicyStatement
    : KW_POLICY ifNotExists? name=tableName
        (KW_WITH KW_RULES KW_MEET ruleGroupType)?
        (KW_POLICYPROPERTIES dbprops=dbProperties)?
    ;
createRuleGroupStatement
    : KW_ADD KW_RULE KW_GROUP ifNotExists? name=tableName
        KW_WITH KW_RULES KW_MEET ruleGroupType
        intoRuleGroupStatement?
    ;
intoRuleGroupStatement
   : KW_INTO KW_GROUP ruleGroup=tableName
   ;
ruleConstraintType
   : KW_MUST|KW_MUSTNOT|KW_NONE
   ;
policyKey
   : KW_WITH KW_POLICYKEY key=StringLiteral
   ;
createPolicyRuleStatement
    : KW_ADD KW_RULE name=tableName
        (KW_WITH KW_CONSTRAINT ruleConstraintType)?
        policyKey ?
        intoRuleGroupStatement?
    ;
dropPolicyStatement
    : KW_DROP KW_POLICY ifExists? tableName
    ;
switchPolicyStatement
    : KW_USE KW_POLICY identifier
    ;
dropPolicyRuleStatement
    : KW_REMOVE KW_RULE KW_GROUP? ifExists? tableName
    ;
createApplicationStatement
    : KW_CREATE (KW_APPLICATION|KW_APP)
        ifNotExists?
        name=identifier
        (KW_WITH? KW_APPPROPERTIES dbprops=dbProperties)?
    ;
dropApplicationStatement
    : KW_DROP (KW_APPLICATION|KW_APP) ifExists? identifier restrictOrCascade?
    ;
dropTableStatement
    : KW_DROP KW_TABLE ifExists? tableName KW_PURGE?
    ;
dropStreamStatement
    : KW_DROP KW_STREAM ifExists? tableName
    ;
dropMetricStatement
    : KW_DROP KW_METRIC ifExists? tableName
    ;
dropJobStatement
    : KW_DROP KW_STREAMJOB ifExists? tableName
    ;
// create rule functions
createRuleFunctionStatement
    : KW_CREATE KW_RULE_FUNCTION
        ifNotExists?
        name=identifier
        (KW_WITH? KW_RULE_FUNCTION_PROPERTIES dbprops=dbProperties)?
        (KW_USING rList=resourceList)?
    ;
dropRuleFunctionStatement
    : KW_DROP KW_RULE_FUNCTION ifExists? metricName=identifier
    ;
dropCachedMetricStatement
    : KW_DROP KW_CACHEDMETRIC ifExists? metricName=identifier
    ;
truncateCachedMetricStatement
    : KW_TRUNCATE KW_CACHEDMETRIC metricName=identifier
    ;
truncateTableStatement
    : KW_TRUNCATE KW_TABLE tablePartitionPrefix (KW_COLUMNS LPAREN columnNameList RPAREN)? KW_IMMEDIATE? KW_PURGE?
    ;
tablePartitionPrefix
    :tableName partitionSpec?
    ;
ctasTargetStatement
    : LPAREN queryStatementExpression RPAREN
    | queryStatementExpression
    ;
tableRowNullFormat
    : KW_NULL KW_DEFINED KW_AS nullIdnt=StringLiteral
    ;
rowFormatSerde
    : KW_ROW KW_FORMAT KW_SERDE name=StringLiteral (KW_WITH KW_SERDEPROPERTIES serdeprops=tableProperties)?
    ;
rowFormatDelimited
    :
      KW_ROW KW_FORMAT KW_DELIMITED tableRowFormatFieldIdentifier? tableRowFormatCollItemsIdentifier? tableRowFormatMapKeysIdentifier? tableRowFormatLinesIdentifier? tableRowNullFormat?
    ;
tableRowFormat
    :
      rowFormatDelimited
    | rowFormatSerde
    ;
tableComment
    :
      KW_COMMENT comment=StringLiteral
    ;
tablePartition
    : KW_PARTITIONED KW_BY LPAREN columnNameTypeList RPAREN
    | tableRangePartition
    ;
tableRoute
    : KW_ROUTED KW_BY tableRouteSpec (COMMA tableRouteSpec)*
    ;
tableRouteSpec
    : tableRangeRoute
    | tableHashRoute;
tableRangeRoute
    : KW_RANGE LPAREN rangeRouteCol=columnName RPAREN LPAREN rangeRouteValues RPAREN
    ;
rangeRouteValues
    : constant (COMMA constant)*
    ;
tableHashRoute
    : KW_HASH LPAREN hashRouteCol=columnName RPAREN KW_BUCKET num=Number
    ;
tableBuckets
    :
      KW_CLUSTERED KW_BY LPAREN bucketCols=columnNameList RPAREN (KW_SORTED KW_BY LPAREN sortCols=columnNameOrderList RPAREN)? KW_INTO num=Number KW_BUCKETS
    ;
tableSkewed
    :
     KW_SKEWED KW_BY LPAREN skewedCols=columnNameList RPAREN KW_ON LPAREN (skewedValues=skewedValueElement) RPAREN (storedAsDirs)?
    ;
skewedValueElement
    :
      skewedColumnValues
     | skewedColumnValuePairList
    ;
skewedColumnValuePairList
    : skewedColumnValuePair (COMMA skewedColumnValuePair)*
    ;
skewedColumnValuePair
    :
      LPAREN colValues=skewedColumnValues RPAREN
    ;
skewedColumnValues
    : skewedColumnValue (COMMA skewedColumnValue)*
    ;
skewedColumnValue
    :
      constant
    ;
skewedValueLocationElement
    :
      skewedColumnValue
     | skewedColumnValuePair
    ;
tablePropertiesPrefixed
    :
        KW_TBLPROPERTIES tableProperties
    ;
erroLogTableSpec
    :  KW_LOG KW_ERRORS KW_INTO tableName (isoverwrite=KW_OVERWRITE)? errorRejectSpec?
    ;
errorRejectSpec
    :  KW_SEGMENT KW_REJECT KW_LIMIT Number (ways=KW_ROWS | ways=KW_PERCENT)
    ;
tableProperties
    :
      LPAREN tablePropertiesList RPAREN
    ;
tablePropertiesList
    :
      keyValueProperty (COMMA keyValueProperty)*
    |
      keyProperty (COMMA keyProperty)*
    ;
tableRowFormatFieldIdentifier
    :
      KW_FIELDS KW_TERMINATED KW_BY fldIdnt=StringLiteral (KW_ESCAPED KW_BY fldEscape=StringLiteral)?
    ;
tableRowFormatCollItemsIdentifier
    :
      KW_COLLECTION KW_ITEMS KW_TERMINATED KW_BY collIdnt=StringLiteral
    ;
tableRowFormatMapKeysIdentifier
    :
      KW_MAP KW_KEYS KW_TERMINATED KW_BY mapKeysIdnt=StringLiteral
    ;
tableRowFormatLinesIdentifier
    :
      KW_LINES KW_TERMINATED KW_BY linesIdnt=StringLiteral
    ;
esProps
    :
    KW_WITH KW_SHARD KW_NUMBER shard=Number KW_REPLICATION replica=Number ((KW_DISABLE|p=KW_ENABLE) KW_ALL)?
    ;
holoProps
    :
    KW_WITH KW_TABLET KW_NUMBER tablet=Number KW_CAPACITY KW_NUMBER capacity=Number KW_REPLICATION replica=Number
    ;
holoTableSize
    :
    KW_WITH KW_TABLESIZE value=identifier (KW_REPLICATION replica=Number)?
    ;
tableFileFormat
    :
      KW_STORED KW_AS KW_SEQUENCEFILE
      | KW_STORED KW_AS KW_TEXTFILE
      | KW_STORED KW_AS KW_CSVFILE
      | KW_STORED KW_AS KW_FWCFILE
      | KW_STORED KW_AS KW_RCFILE
      | KW_STORED KW_AS KW_ORCFILE
      | stargateIdentifier (LPAREN storeArgs RPAREN)?
      | KW_STORED KW_AS KW_HOLODESK
      | KW_STORED KW_AS KW_STELLARDB
      | KW_STORED KW_AS KW_ORCTRANSACTIONFILE
      | KW_STORED KW_AS KW_PARQUET
      | KW_STORED KW_AS KW_HYPERDRIVE
      | KW_STORED KW_AS KW_ESDRIVE
      | KW_STORED KW_AS KW_INPUTFORMAT inFmt=StringLiteral KW_OUTPUTFORMAT outFmt=StringLiteral (KW_INPUTDRIVER inDriver=StringLiteral KW_OUTPUTDRIVER outDriver=StringLiteral)?
      | KW_STORED KW_BY storageHandler=StringLiteral
         (KW_WITH KW_SERDEPROPERTIES serdeprops=tableProperties)?
      | KW_STORED KW_AS genericSpec=identifier
    ;
stargateIdentifier
    :
      KW_STORED KW_AS KW_STARGATE
    ;
storeArgs
    :
      storeArgName
    ;
storeArgName
    :
      identifier
    ;
tableLocation
    :
      KW_LOCATION locn=StringLiteral
    ;
restrictOrCascade
    : KW_RESTRICT
    | KW_CASCADE
    ;
databaseComment
    : KW_COMMENT comment=StringLiteral
    ;
dbLocation
    :
      KW_LOCATION locn=StringLiteral
    ;
dbProperties
    :
      LPAREN dbPropertiesList RPAREN
    ;
dbPropertiesList
    :
      keyValueProperty (COMMA keyValueProperty)*
    ;
ifExists
    : KW_IF KW_EXISTS
    ;
ifNotExists
    : KW_IF KW_NOT KW_EXISTS
    ;
createSequenceStatement
    : KW_CREATE KW_SEQUENCE name=sequenceName sequenceOption*
    ;
dropSequenceStatement
    : KW_DROP KW_SEQUENCE ifExists? sequenceName
    ;
//*******************************DDLBStatementParser.g*******************************//
ddlBStatement
    : descStatement
    | showStatement
    | metastoreCheck
    | dropViewStatement
    | dropMaterializedViewStatement
    | createMacroStatement
    | createIndexStatement
    | createHyperbaseIndexStatement
    | rebuildHolodeskGlobalIndexStatement
    | dropIndexStatement
    | dropFunctionStatement
    | reloadFunctionStatement
    | dropMacroStatement
    | analyzeStatement
    | lockStatement
    | unlockStatement
    | lockDatabase
    | unlockDatabase
    | createRoleStatement
    | dropRoleStatement
    | grantPrivileges
    | revokePrivileges
    | showQuota
    | showGrants
    | showFacl
    | showRoleGrants
    | showRolePrincipals
    | showRoles
    | showBlacklist
    | showSchedulerMode
    | grantQuota
    | revokeQuota
    | grantFacl
    | revokeFacl
    | grantRole
    | revokeRole
    | setRole
    | showCurrentRole
    | syncIndex
    | syncRule
    | syncPolicy
    ;
descStatement
    : (KW_DESCRIBE|KW_DESC) KW_INDEX (descOptions=KW_FORMATTED)? (indexName=identifier) KW_ON tableName
    | (KW_DESCRIBE|KW_DESC) (KW_APPLICATION|KW_APP) appName=identifier
    | (KW_DESCRIBE|KW_DESC) KW_STREAMJOB jobName=identifier
    | (KW_DESCRIBE|KW_DESC) KW_RULE ruleName=identifier
    | (KW_DESCRIBE|KW_DESC) KW_POLICY policyName=identifier
    | (KW_DESCRIBE|KW_DESC) KW_RULE_FUNCTION rulefunction=identifier
    | (KW_DESCRIBE|KW_DESC) KW_CACHEDMETRIC cachedMetric=identifier
    | (KW_DESCRIBE|KW_DESC) (descOptions=KW_EXTENDED|descOptions=KW_FORMATTED|descOptions=KW_PRETTY)? (parttype=descPartTypeExpr)
    | (KW_DESCRIBE|KW_DESC) KW_FUNCTION KW_EXTENDED? (name=descFuncNames)
    | (KW_DESCRIBE|KW_DESC) KW_PLSQL KW_FUNCTION KW_EXTENDED? (plname=plFuncProcName)
    | (KW_DESCRIBE|KW_DESC) KW_PLSQL KW_PACKAGE KW_EXTENDED? (plname=plFuncProcName)
    | (KW_DESCRIBE|KW_DESC) KW_DATABASE KW_EXTENDED? (dbName=identifier)
    | (KW_DESCRIBE|KW_DESC) KW_DATABASE KW_LINK dblink
    ;
//Divide show statement rule to three sub rules to fix the code too large of try block error
showStatement
    : KW_SHOW (showStatementPartA | showStatementPartB | showStatementPartC)
    ;
showStatementPartA
    : (KW_DATABASES|KW_SCHEMAS) (KW_LIKE showStmtIdentifier)?
    | KW_TABLES ((KW_FROM|KW_IN) db_name=identifier)? (KW_LIKE showStmtIdentifier|showStmtIdentifier)?
    | KW_MATERIALIZED KW_VIEWS ((KW_FROM|KW_IN) db_name=identifier)? (KW_LIKE showStmtIdentifier|showStmtIdentifier)?
    | KW_SEQUENCES ((KW_FROM|KW_IN) db_name=identifier)? (KW_LIKE showStmtIdentifier|showStmtIdentifier)?
    | KW_STREAMS ((KW_FROM|KW_IN) db_name=identifier)? (KW_LIKE showStmtIdentifier|showStmtIdentifier)?
    | KW_METRICS ((KW_FROM|KW_IN) db_name=identifier)? (KW_LIKE showStmtIdentifier|showStmtIdentifier)?
    | (KW_APPLICATIONS|KW_APPS) (KW_LIKE showStmtIdentifier)?
    | KW_CURRENT (KW_APPLICATION|KW_APP)
    | KW_CURRENT (KW_POLICY)
    | KW_CURRENT (KW_RULEBASE)
    | KW_STREAMJOBS (KW_LIKE showStmtIdentifier)?
    | KW_RULES (KW_LIKE showStmtIdentifier)?
    | KW_RULEBASES (KW_LIKE showStmtIdentifier)?
    | KW_POLICIES (KW_LIKE showStmtIdentifier)?
    | KW_POLICYBASES (KW_LIKE showStmtIdentifier)?
    | KW_RULE_FUNCTIONS (KW_LIKE showStmtIdentifier)?
    | KW_CACHEDMETRICS (KW_LIKE showStmtIdentifier)?
    | KW_COLUMNS (KW_FROM|KW_IN) tabname=tableName ((KW_FROM|KW_IN) db_name=identifier)?
    ;
showStatementPartB
    : KW_FUNCTIONS showStmtIdentifier?
    | KW_PLSQL KW_FUNCTIONS showStmtIdentifier?
    | KW_PLSQL KW_PACKAGES showStmtIdentifier?
    | KW_PARTITIONS tabTypeExpr partitionSpec?
    | KW_CREATE KW_TABLE tabName=tableName
    | KW_TABLE KW_EXTENDED ((KW_FROM|KW_IN) db_name=identifier)? KW_LIKE showStmtIdentifier partitionSpec?
    ;
showStatementPartC
    : KW_TBLPROPERTIES tblName=identifier (LPAREN prptyName=StringLiteral RPAREN)?
    | KW_LOCKS (parttype=partTypeExpr)? (isExtended=KW_EXTENDED)?
    | KW_LOCKS KW_DATABASE (dbName=Identifier) (isExtended=KW_EXTENDED)?
    | (showOptions=KW_FORMATTED)? (KW_INDEX|KW_INDEXES) KW_ON showStmtIdentifier ((KW_FROM|KW_IN) db_name=identifier)?
    | KW_COMPACTIONS
    | KW_TRANSACTIONS
    | KW_CONF StringLiteral
    | KW_DATABASE KW_LINKS
    | KW_COMPACT KW_BLACKLIST (dbName=Identifier)?
    ;
metastoreCheck
    : KW_MSCK (repair=KW_REPAIR)? (KW_TABLE table=identifier partitionSpec? (COMMA partitionSpec)*)?
    ;
dropViewStatement
    : KW_DROP KW_VIEW ifExists? viewName
    ;
dropMaterializedViewStatement
    : KW_DROP KW_MATERIALIZED KW_VIEW ifExists? viewName
    ;
createFunctionStatement
    : functionType KW_FUNCTION ifNotExists? identifier KW_AS StringLiteral
    (KW_USING rList=resourceList)?
    ;
createMacroStatement
    : KW_CREATE KW_TEMPORARY KW_MACRO Identifier
      LPAREN columnNameTypeList? RPAREN expression
    ;
createIndexStatement
    : KW_CREATE KW_INDEX indexName=identifier
      KW_ON KW_TABLE tab=tableName LPAREN indexedCols=columnNameList RPAREN
      KW_AS typeName=StringLiteral
      autoRebuild?
      indexPropertiesPrefixed?
      indexTblName?
      tableRowFormat?
      tableFileFormat?
      tableLocation?
      tablePropertiesPrefixed?
      indexComment?
    ;
dropIndexStatement
    : KW_DROP KW_INDEX ifExists? indexName=identifier KW_ON tab=tableName
    | KW_DROP KW_FULLTEXT KW_INDEX ifExists? KW_ON tab=tableName
    ;
dropFunctionStatement
    : KW_DROP functionType KW_FUNCTION ifExists? identifier cleanClassLoader?
    ;
reloadFunctionStatement
    : KW_RELOAD KW_FUNCTION
    ;
dropMacroStatement
    : KW_DROP KW_TEMPORARY KW_MACRO ifExists? Identifier
    ;
functionType
    : KW_TEMPORARY|KW_PERMANENT
    ;
cleanClassLoader
    : KW_WITH KW_RESOURCE
    ;
analyzeStatement
    : KW_ANALYZE KW_TABLE (parttype=tableOrPartition) KW_COMPUTE KW_STATISTICS ((noscan=KW_NOSCAN) | (partialscan=KW_PARTIALSCAN)
                                                      | (KW_FOR KW_COLUMNS (statsColumnName=columnNameList)?))?
    ;
lockStatement
    : KW_LOCK KW_TABLE tableName partitionSpec? lockMode
    ;
lockDatabase
    : KW_LOCK KW_DATABASE (dbName=Identifier) lockMode
    ;
unlockStatement
    : KW_UNLOCK KW_TABLE tableName partitionSpec?
    ;
unlockDatabase
    : KW_UNLOCK KW_DATABASE (dbName=Identifier)
    ;
createRoleStatement
    : KW_CREATE KW_ROLE roleName=identifier
    ;
dropRoleStatement
    : KW_DROP KW_ROLE roleName=identifier
    ;
grantPrivileges
    : KW_GRANT privList=privilegeList
      privilegeObject?
      KW_TO principalSpecification
      withGrantOption?
    ;
revokePrivileges
    : KW_REVOKE grantOptionFor? privilegeList privilegeObject? KW_FROM principalSpecification
    ;
showQuota
    : KW_SHOW KW_QUOTA quotaUser? (KW_ON quotaDb)?
    ;
showFacl
    : KW_SHOW KW_FACL userOrGroup? KW_ON KW_TABLE tableName
    ;
showGrants
    : KW_SHOW KW_GRANT principalName? (KW_ON privilegeIncludeColObject)?
    ;
showRoleGrants
    : KW_SHOW KW_ROLE KW_GRANT principalName
    ;
showRolePrincipals
    : KW_SHOW KW_PRINCIPALS roleName=identifier
    ;
showRoles
    : KW_SHOW KW_ROLES
    ;
showBlacklist
    : KW_SHOW KW_BLACKLIST (KW_LIKE showStmtIdentifier|showStmtIdentifier)?
    ;
showSchedulerMode
    : KW_SHOW KW_SCHEDULER KW_MODE
    ;
grantQuota
    :  KW_GRANT KW_QUOTA quotaSpec (KW_ON quotaDb)? (KW_TO quotaUser)?
    ;
revokeQuota
    :  KW_REVOKE KW_QUOTA (KW_ON quotaDb)? (KW_FROM quotaUser)?
    ;
faclSpec
    :  StringLiteral
    ;
grantFacl
    :  KW_GRANT KW_FACL faclSpec KW_ON KW_TABLE tableName KW_TO userOrGroup
    ;
revokeFacl
    : KW_REVOKE KW_FACL KW_ON KW_TABLE tableName (KW_FROM userOrGroup)?
    ;
grantRole
    : KW_GRANT KW_ROLE? identifier (COMMA identifier)* KW_TO principalSpecification withAdminOption?
    ;
revokeRole
    : KW_REVOKE adminOptionFor? KW_ROLE? identifier (COMMA identifier)* KW_FROM principalSpecification
    ;
showCurrentRole
    : KW_SHOW KW_CURRENT KW_ROLES
    ;
syncIndex
    : KW_EXEC KW_SYNC KW_TABLE tab=tableName
    ;
syncRule
    : KW_EXEC KW_SYNC KW_RULE tab=tableName
    ;
syncPolicy
    : KW_EXEC KW_SYNC KW_POLICY tab=tableName
    ;
setRole
    : KW_SET KW_ROLE roleName=identifier
    ;
quotaDb
    :  KW_DATABASE identifier
    |  KW_TEMPORARY KW_SPACE
    ;
quotaUser
    :  KW_USER identifier
    ;
userOrGroup
    : KW_USER identifier
    | KW_GROUP identifier
    ;
withGrantOption
    : KW_WITH KW_GRANT KW_OPTION
    ;
withAdminOption
    : KW_WITH KW_ADMIN KW_OPTION
    ;
adminOptionFor
    : KW_ADMIN KW_OPTION KW_FOR
;
quotaSpec
    :  ByteLengthLiteral
    |  KW_UNLIMITED
    ;
privilegeIncludeColObject
    : KW_ALL
    | KW_ALL KW_APP
    | privObjectCols
//    | privObjectType identifier (LPAREN cols=columnNameList RPAREN)? partitionSpec?
//
    ;
allTablesInDB
    : KW_TABLE? identifier DOT STAR
    ;
privObjectCols
    : (KW_DATABASE|KW_SCHEMA) identifier
    | (KW_APP|KW_APPLICATION) identifier
    | allTablesInDB
    | KW_TABLE? STAR
    | KW_TABLE? STAR DOT STAR
    | KW_TABLE? tableName (LPAREN cols=columnNameList RPAREN)? partitionSpec?
    | KW_URI (path=StringLiteral)
    | KW_SERVER identifier
    ;
grantOptionFor
    : KW_GRANT KW_OPTION KW_FOR
;
privilegeList
    : privlegeDef (COMMA privlegeDef)*
    ;
privlegeDef
    : privilegeType (LPAREN cols=columnNameList RPAREN)?
    ;
privilegeType
    : KW_ALL
    | KW_ALTER
    | KW_UPDATE
    | KW_CREATE
    | KW_CREATE (KW_APP|KW_APPLICATION)
    | KW_DROP
    | KW_INDEX
    | KW_LOCK
    | KW_SELECT
    | KW_SHOW_DATABASE
    | KW_INSERT
    | KW_DELETE
    | KW_START
    | KW_STOP
    | KW_LIST
    ;
privilegeObject
    : KW_ON privObject
//    : KW_ON privObjectType identifier partitionSpec?
//
    ;
// database or table type. Type is optional, default type is table
privObjectType
    : KW_DATABASE
    | KW_TABLE?
    ;
// database or table type. Type is optional, default type is table
privObject
    : (KW_DATABASE|KW_SCHEMA) identifier
    | allTablesInDB
    | KW_TABLE? STAR
    | KW_TABLE? STAR DOT STAR
    | KW_TABLE? tableName partitionSpec?
    | (KW_APP|KW_APPLICATION) identifier
    | KW_URI (path=StringLiteral)
    | KW_SERVER identifier
    ;
principalSpecification
    : principalName (COMMA principalName)*
    ;
principalName
    : KW_USER identifier
    | KW_GROUP identifier
    | KW_ROLE identifier
    ;
lockMode
    : KW_SHARED | KW_EXCLUSIVE
    ;
indexComment
    : KW_COMMENT comment=StringLiteral
    ;
autoRebuild
    : KW_WITH KW_DEFERRED KW_REBUILD
    ;
indexTblName
    : KW_IN KW_TABLE indexTbl=tableName
    ;
indexPropertiesPrefixed
    :
        KW_IDXPROPERTIES indexProperties
    ;
indexProperties
    :
      LPAREN indexPropertiesList RPAREN
    ;
indexPropertiesList
    :
      keyValueProperty (COMMA keyValueProperty)*
    ;
tabTypeExpr
   : identifier (DOT (KW_ELEM_TYPE | KW_KEY_TYPE | KW_VALUE_TYPE | identifier))*
   ;
descTabTypeExpr
   : identifier (DOT (KW_ELEM_TYPE | KW_KEY_TYPE | KW_VALUE_TYPE | identifier))* identifier?
   ;
partTypeExpr
    :  tabTypeExpr partitionSpec?
    ;
descPartTypeExpr
    :  descTabTypeExpr partitionSpec?
    ;
showStmtIdentifier
    : identifier
    | StringLiteral
    ;
sysFuncNames
    :
      KW_AND
    | KW_OR
    | KW_NOT
    | KW_LIKE
    | KW_IF
    | KW_CASE
    | KW_WHEN
    | KW_TINYINT
    | KW_SMALLINT
    | KW_INT
    | KW_BIGINT
    | KW_FLOAT
    | KW_DOUBLE
    | KW_BOOLEAN
    | KW_STRING
    | KW_BINARY
    | KW_ARRAY
    | KW_MAP
    | KW_STRUCT
    | KW_UNIONTYPE
    | EQUAL
    | EQUAL_NS
    | NOTEQUAL
    | LESSTHANOREQUALTO
    | LESSTHAN
    | GREATERTHANOREQUALTO
    | GREATERTHAN
    | DIVIDE
    | PLUS
    | MINUS
    | OP_CONCAT
    | STAR
    | MOD
    | DIV
    | AMPERSAND
    | TILDE
    | BITWISEOR
    | BITWISEXOR
    | KW_RLIKE
    | KW_REGEXP
    | KW_IN
    | KW_BETWEEN
    | KW_EXTRACT
    ;
descFuncNames
    :
      sysFuncNames
    | StringLiteral
    | identifier
    ;
//*******************************DDLCStatementParser.g*******************************//
ddlCStatement
    : createOrReplaceStatement
    | dialectDropStatement
    | grantPermission
    | revokePermission
    | showPermission
    ;
createOrReplaceStatement
    : KW_CREATE orReplace?
      (
      createViewStatement
      |
      createMaterializedViewStatement
      |
      createFunctionStatement
      |
      createRuleStatement
      |
      createPolicyStatement
      |
      dialectCreateOrReplaceStatement)
    ;
createViewStatement
    : KW_VIEW (ifNotExists)? name=tableName
        (LPAREN columnNameCommentList RPAREN)? tableComment? viewPartition?
        tablePropertiesPrefixed?
        KW_AS
	queryStatementExpression
    ;
rewriteEnabled
    : KW_ENABLE KW_REWRITE
    ;
rewriteDisabled
    : KW_DISABLE KW_REWRITE
    ;
createMaterializedViewStatement
    : KW_MATERIALIZED KW_VIEW (ifNotExists)? name=tableName
        (LPAREN columnNameCommentList RPAREN)? rewriteEnabled? tableComment? viewPartition?
        tablePropertiesPrefixed?
        KW_AS
	queryStatementExpression
    ;
viewPartition
    : KW_PARTITIONED KW_ON LPAREN columnNameList RPAREN
    ;
showPermission
    :  KW_SHOW KW_PERMISSION rclsObject
    ;
grantPermission
    :  KW_GRANT KW_PERMISSION rclsObject grantDefinition
    ;
revokePermission
    :  KW_REVOKE KW_PERMISSION rclsObject revokeDefinition
    ;
grantDefinition
    :  KW_FOR KW_ROWS whereClause
       |
       KW_FOR KW_COLUMN columnName whenExpression
    ;
revokeDefinition
    :  KW_FOR KW_ROWS
       |
       KW_FOR KW_COLUMNS
       |
       KW_FOR KW_COLUMN columnName
    ;
rclsObject
    : KW_ON (KW_TABLE|KW_VIEW)? tableName
    ;
//*******************************DDLStatementParser.g*******************************//
ddlStatement
    : alterStatement
    | ddlAStatement
    | ddlBStatement
    | ddlCStatement
    | compactStatement
    ;
compactStatement
    : KW_COMPACT KW_TABLE tablePartitionPrefix compactType=StringLiteral compactId=Number compactSubId=Number
    ;
//*******************************ExpressionAParser.g*******************************//
precedenceUnaryOperator
    :
    PLUS | MINUS | TILDE | KW_PRIOR
    ;
precedenceUnaryPrefixExpression
    :
    (precedenceUnaryOperator)* moleculeExpression
    ;
precedenceUnarySuffixExpression
    : precedenceUnaryPrefixExpression (a=KW_IS nullCondition)?
    ;
precedenceBitwiseXorOperator
    :
    BITWISEXOR
    ;
precedenceBitwiseXorExpression
    :
    precedenceUnarySuffixExpression (precedenceBitwiseXorOperator precedenceUnarySuffixExpression)*
    ;
precedenceStarOperator
    :
    STAR | DIVIDE | MOD | DIV
    ;
precedenceStarExpression
    :
    precedenceBitwiseXorExpression (precedenceStarOperator precedenceBitwiseXorExpression)*
    ;
precedencePlusOperator
    :
    PLUS | MINUS
    ;
precedencePlusExpression
    :
    precedenceStarExpression (precedencePlusOperator precedenceStarExpression)*
    ;
precedenceOPConcatOperator
	:
	OP_CONCAT
	;
precedenceOPConcatExpression
	:
	precedencePlusExpression (precedenceOPConcatOperator precedencePlusExpression)*
	;
precedenceAmpersandOperator
    :
    AMPERSAND
    ;
precedenceAmpersandExpression
    :
    precedenceOPConcatExpression (precedenceAmpersandOperator precedenceOPConcatExpression)*
    ;
precedenceBitwiseOrOperator
    :
    BITWISEOR
    ;
precedenceBitwiseOrExpression
    :
    precedenceAmpersandExpression (precedenceBitwiseOrOperator precedenceAmpersandExpression)* outer_join_sign?
    ;
precedenceRegexpOperator
    :
    KW_LIKE | KW_RLIKE | KW_REGEXP
    ;
precedenceEqualOperator
    :
    precedenceRegexpOperator
    | EQUAL | EQUAL_NS | NOTEQUAL
    | LESSTHANOREQUALTO | LESSTHAN | GREATERTHANOREQUALTO | GREATERTHAN
    ;
//*******************************ExpressionBParser.g*******************************//
expression
    :
    precedenceOrExpression
    ;
expressions
    :
    expressionsInParenthesis
    |
    LPAREN selectStatement RPAREN
    ;
expressionsInParenthesis
    :
    LPAREN expressionsNotInParenthesis RPAREN
    ;
expressionsNotInParenthesis
    :
    first=expression more=expressionPart?
    ;
expressionPart
    :
    (COMMA expression)+
    ;
expressionList
    :
    expression (COMMA expression)*
    ;
outer_join_sign
    :  OUTER_JOIN_SIGN
    ;
nullCondition
    :
    KW_NULL
    | KW_NOT KW_NULL
    ;
//*******************************ExpressionCParser.g*******************************//
precedenceSimilarExpression
    :
    a=precedenceBitwiseOrExpression part=precedenceSimilarExpressionPart?
    ;
precedenceSimilarExpressionPart
    :
    precedenceSimilarExpressionAtom
    |
    (KW_NOT precedenceSimilarExpressionPartNot)
    ;
precedenceSimilarExpressionAtom
    :
    likeanyRightOp
    |
    likeallRightOp
    |
    inRightOp
    |
    betweenRightOp
    ;
precedenceSimilarExpressionPartNot
    :
    precedenceSimilarExpressionAtom
    |
    precedenceRegexpOperator notExpr=precedenceBitwiseOrExpression
    ;
//*******************************ExpressionDParser.g*******************************//
precedenceNotOperator
    :
    KW_NOT
    ;
precedenceNotExpression
    :
    (precedenceNotOperator)* precedenceEqualExpression
    ;
precedenceAndOperator
    :
    KW_AND
    ;
precedenceAndExpression
    :
    precedenceNotExpression (precedenceAndOperator precedenceNotExpression)*
    ;
precedenceOrOperator
    :
    KW_OR
    ;
precedenceOrExpression
    :
    precedenceAndExpression (precedenceOrOperator precedenceAndExpression)*
    ;
precedenceEqualExpression
    :
    precedenceSimilarExpression (precedenceEqualOperator precedenceSimilarExpression)*
    ;
//*******************************FromClauseParser.g*******************************//
//----------------------- Rules for parsing fromClause ------------------------------
// from [col1, col2, col3] table1, [col4, col5] table2
fromClause
    :
    KW_FROM joinSource
    ;
joinSource
    : fromSource (joinToken fromSource | joinTokenRequireOn fromSource (KW_ON expression)?)*
    | uniqueJoinToken uniqueJoinSource (COMMA uniqueJoinSource)+
    ;
uniqueJoinSource
    : KW_PRESERVE? fromSource uniqueJoinExpr
    ;
uniqueJoinExpr
    : LPAREN e1+=expression (COMMA e1+=expression)* RPAREN
    ;
uniqueJoinToken
    : KW_UNIQUEJOIN
    ;
joinToken
    :
      KW_NATURAL KW_JOIN
    | KW_CROSS KW_JOIN
    | COMMA
    ;
joinTokenRequireOn
    :
      KW_JOIN
    | KW_INNER KW_JOIN
    | KW_LEFT  (KW_OUTER)? KW_JOIN
    | KW_RIGHT (KW_OUTER)? KW_JOIN
    | KW_FULL  (KW_OUTER)? KW_JOIN
    | KW_LEFT KW_SEMI KW_JOIN
    | KW_LEFT KW_ANTISEMI KW_JOIN
    ;
lateralView
	:
	KW_LATERAL KW_VIEW KW_OUTER normfunction tableAlias (KW_AS identifier (COMMA identifier)*)?
	|
	KW_LATERAL KW_VIEW normfunction tableAlias (KW_AS identifier (COMMA identifier)*)?
	;
fromSource
    :
    (patternSource | partitionedTableFunction | tableSource | subQuerySource | valuesSource) (lateralView)*
    ;
tableSource
    : tabname=tableName (props=tableProperties)? (ts=tableSample)? (sw=stream_window_clause)? (KW_AS? alias)?
    ;
subQuerySource
    : LPAREN queryStatementExpression RPAREN (KW_AS? alias)?
    ;
valuesSource
    :
    LPAREN valuesClause RPAREN (KW_AS? tableOrColumnAliasOfValues)?
    ;
// Syntax for CEP query
patternSource
    :
    KW_PATTERN LPAREN patternExpression (patternExpression)* RPAREN patternTimewindow?
    ;
patternEvent
    :
    Identifier EQUAL (stream = tableSource | subQuerySource ) LSQUARE expression RSQUARE timesExpr? oneOrMoreExpr?
    ;
timesExpr
    :
    LSQUARE KW_PATTERN_TIMES LPAREN numerator=Number RPAREN RSQUARE
    ;
oneOrMoreExpr
    :
    PLUS
    ;
patternExpression
    :
    (eventOp)* patternEvent
    ;
eventOp
    :
    COMMA | KW_FOLLOWEDBY | KW_NOTFOLLOWEDBY | KW_NOTNEXT
    ;
patternTimewindow
    :
    KW_WITHIN LPAREN cepIntervalLiteral RPAREN
    ;
cepIntervalLiteral
    :
    StringLiteral qualifiers=cepIntervalQualifiers
    // {adaptor.create(qualifiers.tree.token.getType(), $StringLiteral.text)}
    ;
cepIntervalQualifiers
    :
    KW_DAY
    | KW_HOUR
    | KW_MINUTE
    | KW_SECOND
    ;
tableBucketSample
    :
    KW_TABLESAMPLE LPAREN KW_BUCKET (numerator=Number) KW_OUT KW_OF (denominator=Number) (KW_ON expr+=expression (COMMA expr+=expression)*)? RPAREN
    ;
splitSample
    :
    KW_TABLESAMPLE LPAREN  (numerator=Number) (percent=KW_PERCENT|KW_ROWS) RPAREN
    |
    KW_TABLESAMPLE LPAREN  (numerator=ByteLengthLiteral) RPAREN
    ;
tableSample
    :
    tableBucketSample |
    splitSample
    ;
//*******************************FunctionParser.g*******************************//
//-----------------------------------------------------------------------------------
// fun(par1, par2, par3)
normfunction
    :
    functionName
    LPAREN(STAR | KW_DISTINCT? (paramExpression (COMMA paramExpression)*)?)
    RPAREN (KW_OVER window_specification)?
    ;
funcOp
    :  LPAREN STAR
    |  LPAREN KW_DISTINCT
    |  LPAREN
    ;
functionName
    : identifier | dialectFunctionName
    ;
windowFuncIgnoreNulls
    : (ignore=KW_IGNORE | respect=KW_RESPECT) KW_NULLS
    ;
paramExpression
    :
    (identifier (namedNotation = NAMED_NOTATION))? selectExpression windowFuncIgnoreNulls?
    ;
castExpression
    :
    KW_CAST
    LPAREN
          expression
          KW_AS
          primitiveType
    RPAREN
    ;
existExpression
    :
    KW_EXISTS
    LPAREN
          selectStatement
    RPAREN
    ;
widcardExpression
    : KW_WIDCARD LPAREN Number RPAREN
    ;
inRightOp
    :
    KW_IN
    (
    LPAREN
          queryStatementExpression
    RPAREN
    |
    expr=expressionsInParenthesis
    )
    ;
betweenRightOp
    :
    KW_BETWEEN (min=precedenceBitwiseOrExpression) KW_AND (max=precedenceBitwiseOrExpression)
    ;
likeanyRightOp
    :
    KW_LIKE KW_ANY (expr=expressionsInParenthesis)
    ;
likeallRightOp
    :
    KW_LIKE KW_ALL (expr=expressionsInParenthesis)
    ;
// SQL-99, extract()
extractExpression
    :   KW_EXTRACT LPAREN extractTarget KW_FROM expression RPAREN
    ;
// SQL-99, substring()
substringExpression
    :  KW_SUBSTRING LPAREN expression seperatorFrom startPos=expression (seperatorFor length=expression)? RPAREN
    ;
extractTarget
    :  identifier
    // {adaptor.create(StringLiteral, "'" + $identifier.text + "'")}
    ;
seperatorFrom
    : KW_FROM|COMMA
    ;
seperatorFor
    : KW_FOR|COMMA
    ;
yearFuncExpression
    :   KW_YEAR LPAREN tableOrColumn  RPAREN
    ;
monthFuncExpression
    :   KW_MONTH LPAREN tableOrColumn  RPAREN
    ;
dayFuncExpression
    :   KW_DAY LPAREN tableOrColumn  RPAREN
    ;
hourFuncExpression
    :   KW_HOUR LPAREN tableOrColumn  RPAREN
    ;
minuteFuncExpression
    :   KW_MINUTE LPAREN tableOrColumn  RPAREN
    ;
secondFuncExpression
    :   KW_SECOND LPAREN tableOrColumn  RPAREN
    ;
caseExpression
    :
    KW_CASE expression
    (KW_WHEN expression KW_THEN expression)+
    (KW_ELSE expression)?
    dialectEndCase
    ;
whenExpression
    :
    KW_CASE
     ( KW_WHEN expression KW_THEN expression)+
    (KW_ELSE expression)?
    dialectEndCase
    ;
condition
    :  expression
    ;
resourceList
   :
   resource (COMMA resource)*
   ;
resource
   :
   resType=resourceType resPath=StringLiteral
   ;
resourceType
   :
   KW_JAR
   |
   KW_FILE
   |
   KW_ARCHIVE
   ;
//*******************************GraphPathParser.g*******************************//
graphPathStatement
    : KW_SELECT graphSelectClause KW_FROM KW_GRAPH_PATH LPAREN
    vertex=graphReference COMMA
    edge=graphReference COMMA
    pattern=graphPattern COMMA
    vertexIdCol=identifier COMMA
    edgeSrcCol=identifier COMMA
    edgeDstCol=identifier
    RPAREN
    ;
graphReference
    : LPAREN selectStatement RPAREN
    | tableSource
    ;
graphPattern
    : LPAREN graphItem? RPAREN graphEdge+
    ;
graphEdge
    : MINUS LSQUARE edge=graphItem? RSQUARE RARROW LPAREN dst=graphItem? RPAREN
    ;
graphItem
    : identifier (LCURLY expression RCURLY)?
    ;
graphSelectClause
    : STAR
    | graphSelectTable (COMMA graphSelectTable)*
    ;
graphSelectTable
    : (identifier | identifier DOT STAR)
    | t=identifier DOT c=identifier
    ;
//*******************************GroupByParser.g*******************************//
//-----------------------------------------------------------------------------------
// a grouping set expression can still be a CUBE/Rollup/nested grouping sets, or just ()
groupingSetExpression
    :    rollupClause
    |    cubeClause
    |    groupingSetsClause
    |    groupByExpressionList
    |    groupByExpression
    |    LPAREN RPAREN
    ;
// rollup ( (a,b), c) is different from rollup (a,b,c), so we distinguish the first type as a new type TOK_ORDINARY_GROUPING_SET
ordinaryGroupingSet
    :    groupByExpressionList
    |    groupByExpression
    ;
groupByExpressionList
    :    LPAREN groupByExpression (COMMA groupByExpression)* RPAREN
    ;
groupByElements
    :    groupingSetsClause ( COMMA groupingSetsClause )*
    |    rollupClause   ( COMMA rollupClause )*
    |    cubeClause   ( COMMA cubeClause )*
    |    groupByExpression
    |    LPAREN RPAREN
    ;
rollupClause
    :    KW_ROLLUP LPAREN ordinaryGroupingSet (COMMA ordinaryGroupingSet)* RPAREN
    ;
cubeClause
    :    KW_CUBE LPAREN ordinaryGroupingSet (COMMA ordinaryGroupingSet)* RPAREN
    ;
groupingSetsClause
    :   KW_GROUPING KW_SETS LPAREN groupingSetExpression ( COMMA groupingSetExpression )*  RPAREN
    ;
// group by a,b
groupByClause
    :  KW_GROUP KW_BY groupByElements ( COMMA groupByElements )*
    ;
/*
    KW_GROUP KW_BY  groupByExpression  ( COMMA groupByExpression )*   ((rollup=KW_WITH KW_ROLLUP) | (cube=KW_WITH KW_CUBE)) ?
    (sets=KW_GROUPING KW_SETS LPAREN groupingSetExpression ( COMMA groupingSetExpression)*  RPAREN ) ?
    ;
*/
groupByExpression
    :
    expression
    ;
//*******************************HiveDataOpParser.g*******************************//
hiveDataOpStatement
    :   loadStatement
    |   exportStatement
    |   importStatement
    ;
loadStatement
    : KW_LOAD KW_DATA (islocal=KW_LOCAL)? KW_INPATH (path=StringLiteral) (isoverwrite=KW_OVERWRITE)? KW_INTO KW_TABLE (tab=tableOrPartition)
    ;
exportStatement
    : KW_EXPORT KW_TABLE (tab=tableOrPartition) KW_TO (path=StringLiteral)
    ;
importStatement
    : KW_IMPORT ((ext=KW_EXTERNAL)? KW_TABLE (tab=tableOrPartition))? KW_FROM (path=StringLiteral) tableLocation?
    ;
//*******************************InceptorIndexParser.g*******************************//
createHyperbaseIndexStatement
    : KW_CREATE KW_LOCAL KW_INDEX indexName=identifier KW_ON tableName LPAREN indexedCols=hyperbaseColumnNameList RPAREN attachColumn?
    |
     KW_CREATE KW_GLOBAL KW_INDEX indexName=identifier KW_ON tableName LPAREN indexedCols=hyperbaseColumnNameList RPAREN attachColumn?
    | KW_CREATE KW_FULLTEXT KW_INDEX KW_ON tableName LPAREN fulltextColsList RPAREN shardNumber
    ;
rebuildHolodeskGlobalIndexStatement
    : KW_REBUILD KW_GLOBAL KW_INDEX indexName=identifier KW_ON tableName LPAREN indexedCols=hyperbaseColumnNameList RPAREN attachColumn?
    ;
fulltextColsList
    : fulltextIndexAndProps (COMMA fulltextIndexAndProps)*
    ;
fulltextIndexAndProps
     : coln=identifier fulltextIndexProps?
     ;
fulltextIndexProps
     : KW_DOCVALUES LSQUARE  booleanValue  RSQUARE
     ;
shardNumber
     : KW_SHARD KW_NUM Number
     ;
//drop index indexname on identifier;
dropHyperbaseIndexStatement
    : KW_DROP KW_INDEX ifExists? indexName=identifier KW_ON tab=tableName
    ;
hyperbaseColumnNameList
    : indexWithLength (COMMA indexWithLength)*
    ;
indexWithLength
    : coln=identifier segmentLength?
    ;
segmentLength
    : KW_SEGMENT KW_LENGTH Number
    | LPAREN Number RPAREN
    ;
attachColumn
    : KW_ATTACH LPAREN colNames=columnNameList RPAREN
    ;
//*******************************MandarinStmtParser.g*******************************//
mandarinStatement
    : hiveDataOpStatement
    | ddlStatement
    | dclStatement
    | queryStatementExpression
    | sqlCallStatement
    ;
//*******************************QueryBodyBParser.g*******************************//
selectStatement
   :
   selectClause
   (bulkCollect? into=KW_INTO leftValue (COMMA leftValue)*)?
   fromClause
   whereClause?
   hierarchicalQueryClause?
   groupByClause?
   havingClause?
   qualifyClause?
   orderByClause?
   clusterByClause?
   distributeByClause?
   sortByClause?
   window_clause?
   stream_window_clause?
   limitClause?
   forUpdateClause?
   ;
subSelectStatement
   :
   selectClause
   (bulkCollect? into=KW_INTO leftValue (COMMA leftValue)*)?
   fromClause
   whereClause?
   hierarchicalQueryClause?
   groupByClause?
   havingClause?
   qualifyClause?
   orderByClause?
   clusterByClause?
   distributeByClause?
   sortByClause?
   window_clause?
   stream_window_clause?
   limitClause?
   forUpdateClause?
   ;
explicitInsertStatement
   :
   KW_INSERT KW_INTO KW_TABLE? tableOrPartition valuesClause
   ;
// Unify batch insert and single insert
batchInsertStatement
   :
     KW_BATCH_INSERT KW_INTO tableOrPartition batchValuesClause
   ;
//*******************************QueryBodyParser.g*******************************//
withClause
    :
    KW_WITH withClauseElement+ queryStatementExpression
    ;
withClauseElement
    :
    KW_WITH? Identifier KW_AS LPAREN queryStatementExpression RPAREN COMMA?
    ;
regular_body
   :
   insertClause
   (
   withClause
   |
   queryStatementExpressionPlus
   )
   |
   insertClause
   selectClause
   fromClause
   whereClause?
   hierarchicalQueryClause?
   groupByClause?
   havingClause?
   qualifyClause?
   orderByClause?
   clusterByClause?
   distributeByClause?
   sortByClause?
   window_clause?
   limitClause?
   |
   selectStatement
   |
   crudStatement
   |
   explicitInsertStatement
   |
   batchInsertStatement
   |
   graphPathStatement
   ;
   /*catch [MismatchedTokenException ex] {
       throw new AllAltMismatchException(input, "query regular body");
   }*/
bulkCollect
   :  KW_BULK KW_COLLECT
   ;
body
   :
   insertClause
   selectClause
   lateralView?
   whereClause?
   hierarchicalQueryClause?
   groupByClause?
   havingClause?
   qualifyClause?
   orderByClause?
   clusterByClause?
   distributeByClause?
   sortByClause?
   window_clause?
   stream_window_clause?
   limitClause?
   |
   selectClause
   lateralView?
   whereClause?
   hierarchicalQueryClause?
   groupByClause?
   havingClause?
   qualifyClause?
   orderByClause?
   clusterByClause?
   distributeByClause?
   sortByClause?
   window_clause?
   stream_window_clause?
   limitClause?
   ;
insertClause
   :
     KW_INSERT KW_OVERWRITE destination ifNotExists?
   | KW_INSERT KW_INTO KW_TABLE? tableOrPartition
   ;
whereClause
    :
    KW_WHERE searchCondition
    ;
qualifyClause
    :
    KW_QUALIFY searchCondition
    ;
havingClause
    :
    KW_HAVING havingCondition
    ;
havingCondition
    :
    expression
    ;
// VALUES (v1, v2, v3), (v4, v5, v6)
valuesClause
    :  KW_VALUES valuesRow (COMMA valuesRow)*
    ;
valuesRow
    :  (LPAREN expression (COMMA expression)* RPAREN)
    ;
// VALUES (v1, v2, v3)
// Only for batch insert/update statement
batchValuesRow
    :  KW_VALUES valuesRow
    ;
batchValuesClause
   :  KW_BATCH_VALUES LPAREN batchValuesRow (COMMA batchValuesRow)*  RPAREN
   ;
searchCondition
    :
    expression
    ;
hierarchicalQueryClause
   :
     startWithCondition? connectByCondition
   ;
startWithCondition
   : KW_START KW_WITH searchCondition
   ;
connectByCondition
   : KW_CONNECT KW_BY nocycle? searchCondition
   ;
nocycle
   : KW_NOCYCLE
   ;
destination
   :
     KW_LOCAL KW_DIRECTORY StringLiteral tableRowFormat? tableFileFormat?
   | KW_DIRECTORY StringLiteral tableRowFormat? tableFileFormat?
   | KW_TABLE tableOrPartition
   ;
// select statement select ... from ... where ... group by ... order by ...
queryStatementExpression
    : queryStatementMayInParenthese (queryOperator queryStatementMayInParenthese)*
    ;
// Only for handling cases like:
// INSERT ... SELECT ... UNION SELECT;
// For not touching single SELECT cases, requiring at least one queryOperator, otherwise error out (if surrounded with ()).
queryStatementExpressionPlus
    : queryStatementMayInParenthese (queryOperator queryStatementMayInParenthese)+
    ;
queryStatementMayInParenthese
    : queryStatement
    | LPAREN queryStatement RPAREN
    ;
queryOperator
    : KW_UNION KW_ALL?
    | KW_INTERSECT KW_ALL?
    | KW_EXCEPT KW_ALL?
    ;
//*******************************QueryParser.g*******************************//
/*
  Note: the generated java file seems to be at the edge of code too large error, so avoid adding new grammar to this file
*/
// --------------------------------------------------------------------
queryStatement
    :
     fromClause (body)+
    | regular_body
    | withClause
    ;
//*******************************RangePartitionParser.g*******************************//
tableRangePartition
    : KW_PARTITIONED KW_BY KW_RANGE LPAREN columnList RPAREN
      intervalPartitionValue?
      (LPAREN rangePartitionList RPAREN)?
    ;
intervalPartitionValue
    : KW_INTERVAL LPAREN (intervalConst=constant|normfunction) RPAREN
    ;
rangePartitionList
    : rangePartition (COMMA rangePartition)*
    ;
rangePartition
    : KW_PARTITION identifier? rangeValues tablePartitionDesc? partitionLocation?
    ;
rangeValues
    : KW_VALUES KW_LESS KW_THAN LPAREN constant (COMMA constant)* RPAREN
    ;
tablePartitionDesc
    : segmentAttributesClause
    ;
segmentAttributesClause
    : segmentAttribute+
    ;
segmentAttribute
    :
    physicalAttributesClause
    |
    KW_TABLESPACE identifier
    ;
physicalAttributesClause
    :
    physicalAttribute+
    ;
physicalAttribute
    :
    KW_PCTFREE num=Number
    |
    KW_PCTUSED num=Number
    |
    KW_INITRANS num=Number
    |
    KW_MAXTRANS num=Number
    |
    storageClause
    ;
storageClause
    :
    KW_STORAGE LPAREN storageItem+ RPAREN
    ;
storageItem
    :
    KW_INITIAL sz=ByteLengthLiteral
    |
    KW_INITIAL num=Number
    |
    KW_NEXT sz=ByteLengthLiteral
    |
    KW_NEXT num=Number
    |
    KW_MINEXTENTS num=Number
    |
    KW_MAXEXTENTS KW_UNLIMITED
    |
    KW_MAXEXTENTS num=Number
    ;
//*******************************SelectClauseParser.g*******************************//
// --------------------------------------------------------------------
// Dummy start rule of this sub-parser,
// in order to depress ANTLR warning 138:
// no start rule (no rule can obviously be followed by EOF).
selectClauseParserStart
    :  selectClause
    ;
//----------------------- Rules for parsing selectClause -----------------------------
// select a,b,c ...
selectClause
    :
    KW_SELECT hintClause? (((KW_ALL | dist=KW_DISTINCT)? selectList)
                          | (transform=KW_TRANSFORM selectTrfmClause))
    |    trfmClause
    ;
selectList
    :
    selectItem ( COMMA  selectItem )*
    ;
hintClause
    :
    HINT_LEFT hintList C_COMMENT_RIGHT
    ;
hintList
    :
    hintItem (COMMA hintItem)*
    ;
hintItem
    :
    hintName (LPAREN hintArgs RPAREN)?
    | indexHintName (LPAREN indexHintArgs RPAREN)?
    | stargateHintName (LPAREN stargateHintArgs RPAREN)?
    | mboHintName (LPAREN mboHintArgs RPAREN)?
    ;
stargateHintName
    :
    KW_STARGATE
    ;
stargateHintArgs
    :
    stargateHintArgName
    ;
stargateHintArgName
    :
    identifier identifier identifier
    | identifier identifier
    ;
hintName
    :
    KW_MAPJOIN
    | KW_USE_BULKLOAD
    | KW_STREAMTABLE
    | KW_HOLD_DDLTIME
    | KW_COMBINE
    | KW_GLKJOIN
    | KW_COMBINE_STRUCT_INDEX
    | KW_ADHOC
    | KW_PRECOMPILE
    ;
indexHintName
    :
    KW_USE_INDEX
    ;
mboHintName
    :
    KW_NO_REWRITE
    | KW_REWRITE
    ;
indexHintArgs
    :
    indexHintArgName (COMMA indexHintArgName)*
    ;
mboHintArgs
    :
    mboHintArgName (COMMA mboHintArgName)*
    ;
indexHintArgName
    :
    hintArgName KW_USING hintArgName
    ;
mboHintArgName
    :
    tableName
    ;
hintArgs
    :
    hintArgName (COMMA hintArgName)*
    ;
hintArgName
    :
    Number | identifier
    ;
selectItem
    :
    ( expression
      ((KW_AS? columnAlias) | (KW_AS LPAREN columnAlias (COMMA columnAlias)* RPAREN))?
    )
    |
    ( tableAllColumns
    )
    ;
trfmClause
    :
    (   KW_MAP    selectExpressionList
      | KW_REDUCE selectExpressionList )
    inSerde=rowFormat inRec=recordWriter
    KW_USING StringLiteral
    ( KW_AS ((LPAREN (aliasList | columnNameTypeList) RPAREN) | (aliasList | columnNameTypeList)))?
    outSerde=rowFormat outRec=recordReader
    ;
selectExpression
    :
    expression | tableAllColumns
    ;
selectExpressionList
    :
    selectExpression (COMMA selectExpression)*
    ;
rowFormat
    : rowFormatSerde
    | rowFormatDelimited
    |
    ;
recordReader
    : KW_RECORDREADER StringLiteral
    |
    ;
recordWriter
    : KW_RECORDWRITER StringLiteral
    |
    ;
//----------------------- Rules for parsing selectTrfmClause -----------------------------
selectTrfmClause
    :
    LPAREN selectExpressionList RPAREN
    inSerde=rowFormat inRec=recordWriter
    KW_USING StringLiteral
    ( KW_AS ((LPAREN (aliasList | columnNameTypeList) RPAREN) | (aliasList | columnNameTypeList)))?
    outSerde=rowFormat outRec=recordReader
    ;
//*******************************SequenceParser.g*******************************//
sequenceOption
    : (
      sequenceStartWith
    |
      sequenceOptionWithoutStart
    )
    ;
sequenceOptionWithoutStart
    : (
      sequenceIncrement
    |
      sequenceMaxValue
    |
      sequenceMinValue
    |
      sequenceCycle
    |
      sequenceCache
    |
      sequenceOrder
    )
    ;
sequenceIncrement
    : KW_INCREMENT KW_BY precedencePlusOperator num=Number
    |
    KW_INCREMENT KW_BY num=Number
    ;
sequenceStartWith
    : KW_START KW_WITH precedencePlusOperator num=Number
    |
    KW_START KW_WITH num=Number
    ;
sequenceMaxValue
    : KW_MAXVALUE precedencePlusOperator num=Number
    | KW_MAXVALUE num=Number
    | KW_NOMAXVALUE
    ;
sequenceMinValue
    : KW_MINVALUE precedencePlusOperator num=Number
    | KW_MINVALUE num=Number
    | KW_NOMINVALUE
    ;
sequenceCycle
    : KW_CYCLE
    | KW_NOCYCLE
    ;
sequenceCache
    : KW_CACHE PLUS num=Number
    | KW_CACHE num=Number
    | KW_NOCACHE
    ;
sequenceOrder
    : KW_ORDER
    | KW_NOORDER
    ;
//*******************************SQLTailParser.g*******************************//
// order by a,b
orderByClause
    :
    KW_ORDER KW_BY
    LPAREN columnRefOrder
    ( COMMA columnRefOrder)* RPAREN
    |
    KW_ORDER KW_BY
    columnRefOrder
    ( COMMA columnRefOrder)*
    ;
clusterByClause
    :
    KW_CLUSTER KW_BY
    LPAREN expression (COMMA expression)* RPAREN
    |
    KW_CLUSTER KW_BY
    expression
    ( COMMA expression )*
    ;
partitionByClause
    :
    KW_PARTITION KW_BY
    LPAREN expression (COMMA expression)* RPAREN
    |
    KW_PARTITION KW_BY
    expression (COMMA expression)*
    ;
distributeByClause
    :
    KW_DISTRIBUTE KW_BY
    LPAREN expression (COMMA expression)* RPAREN
    |
    KW_DISTRIBUTE KW_BY
    expression (COMMA expression)*
    ;
sortByClause
    :
    KW_SORT KW_BY
    LPAREN columnRefOrder
    ( COMMA columnRefOrder)* RPAREN
    |
    KW_SORT KW_BY
    columnRefOrder
    ( COMMA columnRefOrder)*
    ;
limitClause
   : dialectLimitClause
   ;
partitioningSpec
   :
   partitionByClause orderByClause?
   orderByClause
   distributeByClause sortByClause?
   sortByClause
   clusterByClause
   ;
forUpdateClause
    : KW_FOR KW_UPDATE (KW_OF columnOrtableDotColumnWithDBNameList)?
    ;
//---------------------- Rules for windowing clauses -------------------------------
window_clause
:
  KW_WINDOW window_defn (COMMA window_defn)*
;
window_defn
:
  Identifier KW_AS window_specification
;
window_specification
:
  (Identifier | ( LPAREN Identifier? partitioningSpec? window_frame? RPAREN))
;
window_frame :
 window_range_expression |
 window_value_expression |
 window_timerange_expression
;
window_range_expression
:
 KW_ROWS sb=window_frame_start_boundary
 KW_ROWS KW_BETWEEN s=window_frame_boundary KW_AND end=window_frame_boundary
;
window_value_expression
:
 KW_RANGE sb=window_frame_start_boundary
 KW_RANGE KW_BETWEEN s=window_frame_boundary KW_AND end=window_frame_boundary
;
// window time range used by stream
window_timerange_expression
:
 KW_RANGE sb=window_time_frame_start_boundary window_time_frame_interval? streamwindow_zerotime_expression? window_time_frame_resetinterval? window_time_frame_cache_clause?
 KW_RANGE KW_BETWEEN s=window_time_frame_boundary KW_AND end=window_time_frame_boundary window_time_frame_interval? streamwindow_zerotime_expression? window_time_frame_resetinterval? window_time_frame_cache_clause?
;
window_frame_start_boundary
:
  KW_UNBOUNDED KW_PRECEDING
  KW_CURRENT KW_ROW
  Number KW_PRECEDING
;
window_frame_boundary
:
  KW_UNBOUNDED (r=KW_PRECEDING|r=KW_FOLLOWING)
  KW_CURRENT KW_ROW
  Number (d=KW_PRECEDING | d=KW_FOLLOWING )
;
// window frame defined by time used by streaming
window_time_frame_start_boundary
:
  //KW_UNBOUNDED KW_PRECEDING
  streamIntervalLiteral KW_PRECEDING
;
window_time_frame_boundary
:
  //KW_UNBOUNDED (r=KW_PRECEDING|r=KW_FOLLOWING)
  streamIntervalLiteral (d=KW_PRECEDING | d=KW_FOLLOWING )
;
// whether set a interval for time frame, default for every row
// can set time alignment here, default 0
window_time_frame_interval
:
  KW_INTERVAL streamIntervalLiteral
;
window_time_frame_resetinterval
:
  KW_WINDOWRESET expression
;
window_time_frame_cache_clause
:
  KW_CACHE KW_AS metricName=expression KW_INTO cacheLayer=expression
;
//---------------------- Rules for stream windowing clauses -------------------------------
stream_window_clause
:
  KW_STREAMWINDOW stream_window_defn (COMMA stream_window_defn)*
  KW_SESSIONWINDOW stream_window_defn
;
stream_window_defn
:
  Identifier KW_AS stream_window_specification
  stream_window_specification
;
stream_window_specification
:
  (Identifier | (LPAREN stream_window_frame? RPAREN))
;
stream_window_frame :
  sessionwindow_expression |
  streamwindow_separated_expression? ((streamwindow_range_expression streamwindow_slide_expression)|streamwindow_interval_expression) streamwindow_format_expression? streamwindow_zerotime_expression?
;
sessionwindow_expression
:
  sessionwindow_start_expression sessionwindow_stop_expression sessionwindow_partition_expression? sessionwindow_expire_expression?
;
sessionwindow_start_expression
:
  KW_SESSIONSTART LSQUARE expression session_boundary_interval_expr? RSQUARE
;
sessionwindow_stop_expression
:
  KW_END LSQUARE expression session_boundary_interval_expr? RSQUARE
;
session_boundary_interval_expr
:
  KW_SESSIONWINDOW_INCLUDE | KW_SESSIONWINDOW_EXCLUDE
;
sessionwindow_partition_expression
:
  KW_SESSIONPARTITION LPAREN expression (COMMA expression)* RPAREN
;
sessionwindow_expire_expression
:
  KW_SESSIONEXPIRE LPAREN streamIntervalLiteral sessionwindow_expire_operation_expression? RPAREN
;
sessionwindow_expire_operation_expression
:
  KW_SESSIONEXPIRE_DISCARD | KW_SESSIONEXPIRE_COMPLETE
;
streamwindow_range_expression
:
  KW_LENGTH streamwindow_length
;
streamwindow_length
:
  streamIntervalLiteral | KW_INFINITE
;
streamwindow_slide_expression
:
  KW_STREAMWINDOWSLIDELENGTH streamIntervalLiteral
;
streamwindow_interval_expression
:
  KW_INTERVAL streamIntervalLiteral
;
streamwindow_separated_expression
:
  KW_STREAMWINDOWSEPARATED KW_BY field=identifier
;
streamwindow_format_expression
:
  KW_FORMAT format=StringLiteral
;
streamwindow_zerotime_expression
:
  KW_START KW_TIME KW_AT zerotime=StringLiteral
;
streamIntervalLiteral
    :
    StringLiteral qualifiers=streamIntervalQualifiers
    // {adaptor.create(qualifiers.tree.token.getType(), $StringLiteral.text)}
    ;
streamIntervalQualifiers
    :
    KW_DAY
    | KW_HOUR
    | KW_MINUTE
    | KW_SECOND
    ;
//*******************************SQLTypeParser.g*******************************//
type
    : primitiveType
    | listType
    | structType
    | mapType
    | unionType;
primitiveType
    : KW_TINYINT
    | KW_SMALLINT
    | KW_INT
    | KW_BIGINT
    | KW_BOOLEAN
    | KW_FLOAT
    | KW_DOUBLE
    | KW_DATE (KW_FORMAT StringLiteral)?
    | KW_DATETIME
    | KW_GEO
    | KW_TIMESTAMP(LPAREN length=Number RPAREN)?
    | KW_INTERVAL KW_YEAR KW_TO KW_MONTH
    | KW_INTERVAL KW_DAY KW_TO KW_SECOND
    | KW_STRING (KW_LENGTH length=Number)?
    | KW_NVARCHAR
    | KW_CLOB
    | KW_BINARY
    | KW_BLOB
    | KW_CHAR (LPAREN length=Number RPAREN)?
    // for TPC-H
    | KW_INTEGER
    | (KW_DECIMAL | KW_NUMERIC | KW_NUMBER | KW_DEC) (LPAREN Number (COMMA Number)? RPAREN)?
    | dialectPrimitiveType
    ;
listType
    : KW_ARRAY LESSTHAN type GREATERTHAN
    ;
structType
    : KW_STRUCT LESSTHAN columnNameColonTypeList GREATERTHAN
    ;
mapType
    : KW_MAP LESSTHAN left=primitiveType COMMA right=type GREATERTHAN
    ;
unionType
    : KW_UNIONTYPE LESSTHAN colTypeList GREATERTHAN
    ;
columnNameColonType
    : colName=identifier COLON colType (KW_COMMENT comment=StringLiteral)?
    ;
colType
    : type
    ;
colTypeList
    : colType (COMMA colType)*
    ;
//******************************Oracle/ControlParser.g*******************************//

gotoStatement
    : KW_GOTO Identifier
    ;
returnStatement
    : KW_RETURN expression?
    ;
continueStatement
    :  KW_CONTINUE Identifier? (KW_WHEN condition)?
    ;
exitStatement
    :  KW_EXIT Identifier? (KW_WHEN condition)?
    ;
dialectEndCase
    : KW_END
    ;
//******************************Oracle/CursorParser.g*******************************//
// --------------------------------------------------------------------
// Dummy start rule of this sub-parser,
// in order to depress ANTLR warning 138:
// no start rule (no rule can obviously be followed by EOF).
cursorParserStart
    :  cursorName
    ;
cursorName
    :
    identifier
    ;
cursorParamSpec
    :
    parameter
    ;
cursorParamList
    :
    LPAREN cursorParamSpec (COMMA cursorParamSpec)* RPAREN
    ;
cursorReturnSpec
    :
    KW_RETURN datatype
    ;
cursorBodySpec
    :
    // queryStatementExpression
    selectStatement
    ;
cursorDeclStatement
    :
    KW_CURSOR
    cursorName
    cursorParamList?
    cursorReturnSpec?
    KW_IS cursorBodySpec
    ;
openForOrOpenCursorStatement
    :   KW_OPEN leftValue (opFor=KW_FOR openForClause)?
    ;
openForClause
    : selectStatement
    | dynamicSqlStatement usingClause?
    ;
fetchCursorIntoStatement
    :  KW_FETCH leftValue bulkCollect? intoClause limitClause?
    ;
closeCursorStatement
    :  KW_CLOSE leftValue
    ;
intoClause
    :  KW_INTO leftValue (COMMA leftValue)*
    ;
//******************************Oracle/DeclareParser.g*******************************//
realParam
    : LPAREN expression* (COMMA identifier)* RPAREN
    ;
parameters
    : LPAREN parameter* (COMMA parameter)* RPAREN
    ;
parameter
    :  variable_name parameter_attribute* datatype ((assign = ASSIGN_OP |  assign = KW_DEFAULT) default_value)?
    ;
parameter_attribute
    : KW_IN
    | KW_OUT
    | KW_INOUT
    | KW_NOCOPY
    ;
declareSpecItem
    : typeDeclStatement (SEMICOLON)?
    | declareException (SEMICOLON)?
    | declareVariable (SEMICOLON)?
    | cursorDeclStatement (SEMICOLON)?
    | pragmaStatement (SEMICOLON)?
    ;
   /*catch [MismatchedTokenException ex] {
       throw new AllAltMismatchException(input, "oracle declare item");
   }*/
declareVariable
    :  variable_name KW_CONSTANT? datatype (KW_NOT KW_NULL)? ((assign=ASSIGN_OP | assign=KW_DEFAULT) default_value)?
    ;
variable_name
    : AT? identifier
    ;
default_value
    :  expression
    ;
return_type_spec
    : datatype
    ;
size
    : Digit+
    ;
// Left value could be the combination of function and dot expression in any order,
// which falls in to the scope of precedenceFieldExpression.
leftValue
    :  moleculeExpression
    ;
plFuncProcName
    :
    db=identifier DOT funcpro=identifier
    |
    funcpro=identifier
    ;
// FIXME
// ------------------------------------------
declareException
    :  identifier KW_EXCEPTION
    ;
pragmaStatement
    : KW_PRAGMA pragmas
    ;
pragmas
    : pragmaExceptionInit
    | pragmaAutonomousTransaction
    | pragmaSeriallyReusable
    ;
pragmaExceptionInit
    : KW_EXCEPTION_INIT LPAREN identifier COMMA expression RPAREN
    ;
pragmaAutonomousTransaction
    : KW_AUTONOMOUS_TRANSACTION
    ;
pragmaSeriallyReusable
    : KW_SERIALLY_REUSABLE
    ;
declare_pragma
    : KW_PRAGMA identifier*
    ;
declare_record
    : KW_RECORD  identifier*
    ;
declare_table
    : KW_TABLE identifier*
    ;
//******************************Oracle/DynamicSqlParser.g*******************************//
// --------------------------------------------------------------------
// Dummy start rule of this sub-parser,
// in order to depress ANTLR warning 138:
// no start rule (no rule can obviously be followed by EOF).
dynamicSqlParserStart
    :  dynamicSqlStatement
    ;
executeImmediateStatement
    :  KW_EXEC KW_IMMEDIATE
       dynamicSqlStatement
       (bulkCollect? into=intoClause)? usingClause?
    ;
dynamicSqlStatement
    :
    expression
    ;
usingClause
    :  KW_USING dynamicSqlBindArgs
    ;
dynamicSqlBindArgs
    :  dynamicSqlBindArg (COMMA dynamicSqlBindArg)*
    ;
dynamicSqlBindArg
    :  parameter_attribute* expression
    ;
assignStatement
    :  leftValue (a=ASSIGN_OP expression)?
    ;
nullStatement
    :  KW_NULL
    ;
//******************************Oracle/ExceptionParser.g*******************************//
// --------------------------------------------------------------------
// Dummy start rule of this sub-parser,
// in order to depress ANTLR warning 138:
// no start rule (no rule can obviously be followed by EOF).
exceptionParserStart
    :  raiseStatement
    ;
raiseStatement
    :  KW_RAISE leftValue?
    ;
exceptionHandlers
	: KW_EXCEPTION exceptionHandler+
	;
exceptionHandler
	: KW_WHEN leftValue (KW_OR leftValue)* KW_THEN
	  plBlockBody
	;
//******************************Oracle/ForLoopParser.g*******************************//
// There are 4 loop types:
// 1. simple loop
// 2. while loop
// 3. for loop using number
// 4. for loop using cursor --- Note: not supported yet
loopStatement
    :   (KW_WHILE condition
          // {mode = 1;}
          | KW_FOR identifier KW_IN forLoopBound
          // {mode = 2;}
        )?
        KW_LOOP labeledStatement+
        KW_END KW_LOOP Identifier?
    ;
forLoopBound
    :  rangeBound
    |  cursorBound
    ;
   /*catch [MismatchedTokenException ex] {
       throw new AllAltMismatchException(input, "oracle for loop bound");
   }*/
rangeBound
    :  KW_REVERSE? rangeBoundMin expression
    ;
rangeBoundMin
    :  IntRangeMin
    |  expression RANGE_OP
    ;
cursorBound
    : LPAREN selectStatement RPAREN
    |  leftValue (LPAREN expression (COMMA expression)* RPAREN)?
    ;
forAllStatement
    :  KW_FORALL identifier KW_IN forAllBound (saveExceptions)? queryStatement
    ;
saveExceptions
    :  KW_SAVE KW_EXCEPTIONS
    ;
forAllBound
    :  rangeBound
    |  indicesBound
    // |  valuesOfBound
    ;
indicesBound
    :  KW_INDICES KW_OF leftValue (KW_BETWEEN low=precedenceNotExpression KW_AND high=precedenceNotExpression)?
    ;
//******************************Oracle/MoleculeExpressionParser.g*******************************//
//-----------------------------------------------------------------------------------
attr
    :  KW_ISOPEN | KW_FOUND | KW_NOTFOUND | KW_ROWCOUNT | KW_BULK_ROWCOUNT | KW_BULK_EXCEPTIONS;
attrs
    :  MOD attr
    ;
moleculeExpression
    : (atomExpression | dialectFunctionName) // Left side of op
    ( (attrs) // Attributes %
    | (DOT atomExpression) // Fileds .
    | (LSQUARE expression RSQUARE) // Fields []
    | (funcOp (paramExpression (COMMA paramExpression)*)?
      RPAREN (KW_OVER window_specification)?) // Function call ()
    )*
    ;
//******************************Oracle/IfParser.g*******************************//
/*
  Note: the generated java file seems to be at the edge of code too large error, so avoid adding new grammar to this file
*/
// IF/ELSE statement
ifStatement
    :   KW_IF condition KW_THEN labeledStatement*
        elsifStatement* elseStatement? KW_END KW_IF?
    ;
elsifStatement
    :    KW_ELSIF condition KW_THEN labeledStatement*
    ;
elseStatement
    :    KW_ELSE labeledStatement*
    ;
//******************************Oracle/NonReservedKWParser.g*******************************//
dialectNonReserved
    : KW_NOCOPY | KW_VARRAY
    | KW_PACKAGE | KW_PACKAGES | KW_BODY
    | KW_ISOPEN | KW_FOUND | KW_NOTFOUND | KW_ROWCOUNT | KW_BULK_ROWCOUNT | KW_BULK_EXCEPTIONS
    | KW_REVERSE | KW_SAVE | KW_EXCEPTIONS | KW_INDICES | KW_REF | KW_VALUES | KW_SET
    | KW_SYSDATE | KW_YEARS | KW_MONTHS | KW_DAYS | KW_HOURS | KW_MINUTES | KW_SECONDS
    ;
dialectFunctionName
    : // Keyword IF is also a function name
    KW_IF | KW_ARRAY | KW_MAP | KW_STRUCT | KW_UNIONTYPE | KW_SYSDATE | KW_SYSTIMESTAMP | KW_SYSTIME
    ;
//******************************Oracle/NonSqlStatementParser.g*******************************//

// --------------------------------------------------------------------

nonSqlStatement
    : nullStatement
    | ifStatement
    | loopStatement
    | forAllStatement
    | continueStatement
    | exitStatement
    | returnStatement
    | gotoStatement
    | openForOrOpenCursorStatement
    | fetchCursorIntoStatement
    | closeCursorStatement
    | assignStatement
    | raiseStatement
    | dclStatement
    | plBlockStatement
    | executeImmediateStatement
//    | declare_variable
    ;
//******************************Oracle/OracleLexer.g*******************************//

KW_NOCOPY: 'NOCOPY';
KW_VARRAY: 'VARRAY';

KW_PACKAGE: 'PACKAGE';
KW_PACKAGES: 'PACKAGES';
KW_BODY: 'BODY';

KW_ISOPEN: 'ISOPEN';
KW_NOTFOUND: 'NOTFOUND';
KW_ROWCOUNT: 'ROWCOUNT';
KW_BULK_ROWCOUNT: 'BULK_ROWCOUNT';
KW_BULK_EXCEPTIONS: 'BULK_EXCEPTIONS';

KW_REVERSE: 'REVERSE';
KW_FORALL: 'FORALL';
KW_SAVE: 'SAVE';
KW_EXCEPTIONS: 'EXCEPTIONS';
KW_INDICES: 'INDICES';
KW_REF: 'REF';
KW_RAISE: 'RAISE';

KW_PRAGMA: 'PRAGMA';
KW_EXCEPTION_INIT: 'EXCEPTION_INIT';
KW_AUTONOMOUS_TRANSACTION: 'AUTONOMOUS_TRANSACTION';
KW_SERIALLY_REUSABLE: 'SERIALLY_REUSABLE';
KW_RECORD: 'RECORD';

KW_YEARS: 'YEARS';
KW_MONTHS: 'MONTHS';
KW_DAYS: 'DAYS';
KW_HOURS: 'HOURS';
KW_MINUTES: 'MINUTES';
KW_SECONDS: 'SECONDS';
//******************************Oracle/OracleParser.g*******************************//
// starting rule
statements
    : (sqlStatement)* sqlStatement
    ;

sqlStatementEmpty
    : sqlStatement
    ;

sqlStatement
    : plantStatement (SEMICOLON)? EOF
    | explainStatement EOF
    | execStatement (SEMICOLON)? EOF
    ;
plantStatement
    : KW_PLANT execStatement
    ;
explainStatement
    : KW_EXPLAIN (explainOptions=KW_EXTENDED|explainOptions=KW_FORMATTED|explainOptions=KW_DEPENDENCY|explainOptions=KW_LOGICAL|explainOptions=KW_COST|explainOptions=KW_STARGATE)? execStatement
    ;
execStatement
    : mandarinStatement
    | anonExecStatement
    ;
//******************************Oracle/PackageParser.g*******************************//
// --------------------------------------------------------------------
pkgName
    :  db=identifier DOT pkg=Identifier
    |  pkg=Identifier
    ;
createPackageStatement
    :  KW_PACKAGE ifNotExists? pkgName (KW_IS | KW_AS)
       KW_DECLARE? pkgDeclSpecItem*
       KW_END Identifier?
    ;
createPackageBodyStatement
    :  KW_PACKAGE KW_BODY ifNotExists? pkgName (KW_IS | KW_AS)
       KW_DECLARE? pkgBodyDeclSpecItem*
       (begin=KW_BEGIN
       plBlockBody
       exceptionHandlers?)?
       KW_END Identifier?
    ;
dropPackageStatement
    :  KW_DROP KW_PLSQL? KW_PACKAGE ifExists? pkgName
    ;
pkgDeclSpecItem
    :  declFunctionSpec | declProcedureSpec | declareSpecItem
    ;
pkgBodyDeclSpecItem
    :  createSQL92FunctionStatement SEMICOLON?
    | createSQL92ProcedureStatement SEMICOLON?
    | declareSpecItem
    ;
declFunctionSpec
    :  KW_FUNCTION identifier parameters KW_RETURN return_type_spec SEMICOLON?
    ;
declProcedureSpec
    :  KW_PROCEDURE identifier parameters SEMICOLON?
    ;
//******************************Oracle/PlBlockParser.g*******************************//
anonExecStatement
    : plBlockStatement
    ;
plBlockStatement
    :
    (KW_DECLARE declareSpecItem*)?
    KW_BEGIN
    plBlockBody
    exceptionHandlers?
    KW_END Identifier?
    ;
plBlockBody
    :  (labeledStatement)+
    ;
atomExecStatement
    :  updateStatement
    |  deleteStatement
    |  mergeStatement
    |  queryStatementExpression
    |  nonSqlStatement
    ;
hintedStatement
    :  hintClause atomExecStatement
    |  atomExecStatement
    ;
label
    :  DOUBLELESSTHAN Identifier DOUBLEGREATERTHAN
    ;
labeledStatement
    :  label hintedStatement SEMICOLON?
    |  hintedStatement (SEMICOLON)?
    ;
//******************************Oracle/PlFunctionParser.g*******************************//
// --------------------------------------------------------------------
dialectCreateOrReplaceStatement
    :
    createSQL92FunctionStatement
    |
    createSQL92ProcedureStatement
    |
    createPackageStatement
    |
    createPackageBodyStatement
    ;
dialectDropStatement
    :  dropSQL92FunctionStatement
    |  dropSQL92ProcedureStatement
    |  dropPackageStatement
    ;
createSQL92FunctionStatement
    :  KW_FUNCTION ifNotExists? func_name=plFuncProcName parameters
       KW_RETURN return_type_spec
       (KW_IS | KW_AS)
       KW_DECLARE? declareSpecItem*
       KW_BEGIN
       plBlockBody
       exceptionHandlers?
       KW_END Identifier?
    ;
dropSQL92FunctionStatement
    : KW_DROP KW_PLSQL? KW_FUNCTION ifExists? func_name=plFuncProcName parameters?
    ;
createSQL92ProcedureStatement
    :  KW_PROCEDURE ifNotExists? procedure_name=plFuncProcName parameters
       (KW_IS | KW_AS)
       KW_DECLARE? declareSpecItem*
       KW_BEGIN
       plBlockBody
       exceptionHandlers?
       KW_END Identifier?
    ;
dropSQL92ProcedureStatement
    : KW_DROP KW_PLSQL? KW_PROCEDURE ifExists? procedure_name=plFuncProcName parameters?
    ;
// ------------------------------------------
//******************************Oracle/SQLDialectParser.g*******************************//
dialectLimitClause
    : KW_LIMIT (offset=Number COMMA)? num=Number
    | KW_FETCH KW_FIRST num=Number KW_ROWS KW_ONLY
    | (KW_OFFSET value=Number KW_ROWS)? KW_FETCH KW_NEXT num=Number KW_ROWS KW_ONLY
    ;
dialectCreateTemporaryTableStatement
    : KW_CREATE temp=KW_TEMPORARY (ext=KW_EXTERNAL)? KW_TABLE ifNotExists? name=tableName tableDefinitionClause
    ;
dialectCreateTableStatement
    : KW_CREATE (ext=KW_EXTERNAL)? KW_TABLE ifNotExists? name=tableName tableDefinitionClause
    ;
dialectWithNoData
    : KW_WITH KW_NO KW_DATA
    ;
dialectcolumnConstraint
    : KW_NOT KW_NULL
    | KW_UNIQUE
    ;
dialectTableDefinitionClause
    : like=KW_LIKE likeName=tableName tableLocation? tablePropertiesPrefixed?
    | (LPAREN columnNameTypeOrConstraintList RPAREN)?
      tableComment?
      tablePartition?
      tableRoute?
      tableBuckets?
      tableSkewed?
      tableRowFormat?
      tableFileFormat?
      esProps?
      holoProps?
      holoTableSize?
      tableLocation?
      tablePropertiesPrefixed?
      erroLogTableSpec?
      (KW_AS ctasTargetStatement)?
      noDataCopyQuery?
    ;
dialectPrimitiveType
    : KW_NVARCHAR
    | KW_VARCHAR2 (LPAREN length=Number RPAREN)?
    | KW_VARCHAR LPAREN length=Number RPAREN
    ;
//******************************Oracle/TimeTypeLiteralParser.g*******************************//
// --------------------------------------------------------------------
timeTypeLiteral
    : dateLiteral
    | timestampLiteral
    | sysdateortimestampLiteral
    | intervalLiteral
    ;
dateLiteral
    :
    KW_DATE StringLiteral
    ;
timestampLiteral
    : KW_TIMESTAMP StringLiteral
    ;
sysdateortimestampLiteral
	: KW_SYSDATE(LPAREN RPAREN)?
    | KW_SYSTIMESTAMP(LPAREN RPAREN)?
    | KW_SYSTIME(LPAREN RPAREN)?
	;
dateTimeExpression
    : KW_DAY|KW_HOUR|KW_MINUTE|KW_SECOND
    ;
monthExpression
    : KW_YEAR|KW_MONTH
    ;
//-----------------------------------------------------------------------------------
intervalValue
    :
    StringLiteral | Number
    ;
intervalLiteral
    :
    value=intervalValue qualifiers=intervalQualifiers
    |
    KW_INTERVAL value=intervalValue qualifiers=intervalQualifiers (LPAREN Number RPAREN)?
    ;
intervalQualifiers
    :
    KW_YEAR KW_TO KW_MONTH
    | KW_DAY KW_TO KW_SECOND
    | (KW_YEAR | KW_YEARS)
    | (KW_MONTH | KW_MONTHS)
    | (KW_DAY | KW_DAYS)
    | (KW_HOUR | KW_HOURS)
    | (KW_MINUTE | KW_MINUTES)
    | (KW_SECOND | KW_SECONDS)
    ;
//******************************Oracle/TypeParser.g*******************************//
// --------------------------------------------------------------------
// Dummy start rule of this sub-parser,
// in order to depress ANTLR warning 138:
// no start rule (no rule can obviously be followed by EOF).
typeParserStart
    :  datatype
    ;
datatype
    :  scalarType | otherType;
otherType
    :  leftValue (MOD (KW_TYPE
        // {mode = 1;}
        | KW_ROWTYPE
        // {mode = 2;}
        ))?
    ;
scalarType
    :  scalarTypes
    ;
scalarTypes
    :  primitiveType
    ;
typeDeclStatement
    :  KW_TYPE Identifier KW_IS
       (
       assocArrayOrNestedTableTypeDef
       |
       varrayTypeDef
       |
       recordTypeDef
       |
       refCursorTypeDef
       |
       datatype
       )
    ;
recordTypeDef
    :  KW_RECORD LPAREN declareVariable (COMMA declareVariable)* RPAREN
    ;
assocArrayOrNestedTableTypeDef
    :  KW_TABLE KW_OF elementType (KW_NOT KW_NULL)? (idx=KW_INDEX KW_BY indexType)?
    ;
indexType
    :  KW_INT
    |  KW_STRING
    ;
varrayTypeDef
    :  (KW_VARRAY | KW_VARYING KW_ARRAY) LPAREN Number RPAREN KW_OF elementType (KW_NOT KW_NULL)?
    ;
elementType
    :  datatype;
refCursorTypeDef
    : KW_REF KW_CURSOR (KW_RETURN otherType)?
    ;
