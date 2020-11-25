/*
MySQL (Positive Technologies) grammar
The MIT License (MIT).
Copyright (c) 2015-2017, Ivan Kochurkin (kvanttt@gmail.com), Positive Technologies.
Copyright (c) 2017, Ivan Khudyashev (IHudyashov@ptsecurity.com)

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

lexer grammar MySqlLexer;

channels { MYSQLCOMMENT, ERRORCHANNEL }

// SKIP

SPACE:                               [ \t\r\n]+    -> channel(HIDDEN);
SPEC_MYSQL_COMMENT:                  '/*!' .+? '*/' -> channel(MYSQLCOMMENT);
COMMENT_INPUT:                       '/*' .*? '*/' -> channel(HIDDEN);
MINUS_COMMENT:                       '-''-'+;
LINE_COMMENT:                        (
                                       (MINUS_COMMENT ' '? | '#') ~[\r\n]* ('\r'? '\n' | EOF)
                                       | MINUS_COMMENT ('\r'? '\n' | EOF)
                                     ) -> channel(HIDDEN);

// Keywords
// Common Keywords

ADD:                                 'ADD';
ALL:                                 'ALL';
ALTER:                               'ALTER';
ALWAYS:                              'ALWAYS';
ANALYZE:                             'ANALYZE';
AND:                                 'AND';
AS:                                  'AS';
ASC:                                 'ASC';
BEFORE:                              'BEFORE';
BETWEEN:                             'BETWEEN';
BOTH:                                'BOTH';
BY:                                  'BY';
CALL:                                'CALL';
CASCADE:                             'CASCADE';
CASE:                                'CASE';
CAST:                                'CAST';
CHANGE:                              'CHANGE';
CHARACTER:                           'CHARACTER';
CHECK:                               'CHECK';
COLLATE:                             'COLLATE';
COLUMN:                              'COLUMN';
CONDITION:                           'CONDITION';
CONSTRAINT:                          'CONSTRAINT';
CONTINUE:                            'CONTINUE';
CONVERT:                             'CONVERT';
CREATE:                              'CREATE';
CROSS:                               'CROSS';
CURRENT_USER:                        'CURRENT_USER';
CURSOR:                              'CURSOR';
DATABASE:                            'DATABASE';
DATABASES:                           'DATABASES';
DECLARE:                             'DECLARE';
DEFAULT:                             'DEFAULT';
DELAYED:                             'DELAYED';
DELETE:                              'DELETE';
DESC:                                'DESC';
DESCRIBE:                            'DESCRIBE';
DETERMINISTIC:                       'DETERMINISTIC';
DISTINCT:                            'DISTINCT';
DISTINCTROW:                         'DISTINCTROW';
DROP:                                'DROP';
EACH:                                'EACH';
ELSE:                                'ELSE';
ELSEIF:                              'ELSEIF';
ENCLOSED:                            'ENCLOSED';
ESCAPED:                             'ESCAPED';
EXISTS:                              'EXISTS';
EXIT:                                'EXIT';
EXPLAIN:                             'EXPLAIN';
FALSE:                               'FALSE';
FETCH:                               'FETCH';
FOR:                                 'FOR';
FORCE:                               'FORCE';
FOREIGN:                             'FOREIGN';
FROM:                                'FROM';
FULLTEXT:                            'FULLTEXT';
GENERATED:                           'GENERATED';
GRANT:                               'GRANT';
GROUP:                               'GROUP';
HAVING:                              'HAVING';
HIGH_PRIORITY:                       'HIGH_PRIORITY';
IF:                                  'IF';
IGNORE:                              'IGNORE';
IN:                                  'IN';
INDEX:                               'INDEX';
INFILE:                              'INFILE';
INNER:                               'INNER';
INOUT:                               'INOUT';
INSERT:                              'INSERT';
INTERVAL:                            'INTERVAL';
INTO:                                'INTO';
IS:                                  'IS';
ITERATE:                             'ITERATE';
JOIN:                                'JOIN';
KEY:                                 'KEY';
KEYS:                                'KEYS';
KILL:                                'KILL';
LEADING:                             'LEADING';
LEAVE:                               'LEAVE';
LEFT:                                'LEFT';
LIKE:                                'LIKE';
LIMIT:                               'LIMIT';
LINEAR:                              'LINEAR';
LINES:                               'LINES';
LOAD:                                'LOAD';
LOCK:                                'LOCK';
LOOP:                                'LOOP';
LOW_PRIORITY:                        'LOW_PRIORITY';
MASTER_BIND:                         'MASTER_BIND';
MASTER_SSL_VERIFY_SERVER_CERT:       'MASTER_SSL_VERIFY_SERVER_CERT';
MATCH:                               'MATCH';
MAXVALUE:                            'MAXVALUE';
MODIFIES:                            'MODIFIES';
NATURAL:                             'NATURAL';
NOT:                                 'NOT';
NO_WRITE_TO_BINLOG:                  'NO_WRITE_TO_BINLOG';
NULL_LITERAL:                        'NULL';
ON:                                  'ON';
OPTIMIZE:                            'OPTIMIZE';
OPTION:                              'OPTION';
OPTIONALLY:                          'OPTIONALLY';
OR:                                  'OR';
ORDER:                               'ORDER';
OUT:                                 'OUT';
OUTER:                               'OUTER';
OUTFILE:                             'OUTFILE';
PARTITION:                           'PARTITION';
PRIMARY:                             'PRIMARY';
PROCEDURE:                           'PROCEDURE';
PURGE:                               'PURGE';
RANGE:                               'RANGE';
READ:                                'READ';
READS:                               'READS';
REFERENCES:                          'REFERENCES';
REGEXP:                              'REGEXP';
RELEASE:                             'RELEASE';
RENAME:                              'RENAME';
REPEAT:                              'REPEAT';
REPLACE:                             'REPLACE';
REQUIRE:                             'REQUIRE';
RESTRICT:                            'RESTRICT';
RETURN:                              'RETURN';
REVOKE:                              'REVOKE';
RIGHT:                               'RIGHT';
RLIKE:                               'RLIKE';
SCHEMA:                              'SCHEMA';
SCHEMAS:                             'SCHEMAS';
SELECT:                              'SELECT';
SET:                                 'SET';
SEPARATOR:                           'SEPARATOR';
SHOW:                                'SHOW';
SPATIAL:                             'SPATIAL';
SQL:                                 'SQL';
SQLEXCEPTION:                        'SQLEXCEPTION';
SQLSTATE:                            'SQLSTATE';
SQLWARNING:                          'SQLWARNING';
SQL_BIG_RESULT:                      'SQL_BIG_RESULT';
SQL_CALC_FOUND_ROWS:                 'SQL_CALC_FOUND_ROWS';
SQL_SMALL_RESULT:                    'SQL_SMALL_RESULT';
SSL:                                 'SSL';
STARTING:                            'STARTING';
STRAIGHT_JOIN:                       'STRAIGHT_JOIN';
TABLE:                               'TABLE';
TERMINATED:                          'TERMINATED';
THEN:                                'THEN';
TO:                                  'TO';
TRAILING:                            'TRAILING';
TRIGGER:                             'TRIGGER';
TRUE:                                'TRUE';
UNDO:                                'UNDO';
UNION:                               'UNION';
UNIQUE:                              'UNIQUE';
UNLOCK:                              'UNLOCK';
UNSIGNED:                            'UNSIGNED';
UPDATE:                              'UPDATE';
USAGE:                               'USAGE';
USE:                                 'USE';
USING:                               'USING';
VALUES:                              'VALUES';
WHEN:                                'WHEN';
WHERE:                               'WHERE';
WHILE:                               'WHILE';
WITH:                                'WITH';
WRITE:                               'WRITE';
XOR:                                 'XOR';
ZEROFILL:                            'ZEROFILL';


// INCEPTOR Keywords
ADMIN:                                'ADMIN';
ANALYZER:                             'ANALYZER';
APP:                                  'APP';
APPEND:                               'APPEND';
APPS:                                 'APPS';
APPLICATION:                          'APPLICATION';
APPLICATIONS:                         'APPLICATIONS';
BLACKLIST:                            'BLACKLIST';
BODY:                                 'BODY';
BUCKETS:                              'BUCKETS';
BULK:                                 'BULK';
CACHEDMETRIC:                         'CACHEDMETRIC';
CACHEDMETRICS:                        'CACHEDMETRICS';
CALLER:                               'CALLER';
CAPACITY:                             'CAPACITY';
CLUSTER:                              'CLUSTER';
CLUSTERED:                            'CLUSTERED';
COLLECT:                              'COLLECT';
COLLECTION:                           'COLLECTION';
COMPACTIONS:                          'COMPACTIONS';
CONCATENATE:                          'CONCATENATE';
CONNECT:                              'CONNECT';
CONF:                                 'CONF';
CUBE:                                 'CUBE';
CURRENT:                              'CURRENT';
DBPROPERTIES:                         'DBPROPERTIES';
DB2:                                  'DB2';
DELIMITED:                            'DELIMITED';
DELIMITER:                            'DELIMITER';
DIRECTORIES:                          'DIRECTORIES';
DISTRIBUTE:                           'DISTRIBUTE';
EXTERNAL:                             'EXTERNAL';
EXCLAMATION_SET:                      '!SET';
FACL:                                 'FACL';
FILEFORMAT:                           'FILEFORMAT';
FOLLOWING:                            'FOLLOWING';
FORMATTED:                            'FORMATTED';
FUNCTIONS:                            'FUNCTIONS';
GROUPING:                             'GROUPING';
HOLD:                                 'HOLD';
INCEPTOR:                             'INCEPTOR';
IMMEDIATE:                            'IMMEDIATE';
INPATH:                               'INPATH';
INPUTDRIVER:                          'INPUTDRIVER';
INPUTFORMAT:                          'INPUTFORMAT';
ITEMS:                                'ITEMS';
JAR:                                  'JAR';
JARS:                                 'JARS';
LATERAL:                              'LATERAL';
LINK:                                 'LINK';
LINKS:                                'LINKS';
LOCATION:                             'LOCATION';
LOCKS:                                'LOCKS';
MAP:                                  'MAP';
MATCHED:                              'MATCHED';
MATERIALIZED:                         'MATERIALIZED';
METRICS:                              'METRICS';
NOCYCLE:                              'NOCYCLE';
NORELY:                               'NORELY';
NOVALIDATE:                           'NOVALIDATE';
NONSTRICT:                            'NONSTRICT';
NO_DROP:                              'NO_DROP';
NO_INDEX:                             'NO_INDEX';
OFF:                                  'OFF';
ORACLE:                               'ORACLE';
OUTPUTDRIVER:                         'OUTPUTDRIVER';
OUTPUTFORMAT:                         'OUTPUTFORMAT';
OVERWRITE:                            'OVERWRITE';
PACKAGE:                              'PACKAGE';
PACKAGES:                             'PACKAGES';
PARTITIONED:                          'PARTITIONED';
PERCENT:                              'PERCENT';
PERMANENT:                            'PERMANENT';
PERMISSION:                           'PERMISSION';
PRETTY:                               'PRETTY';
PLSQL:                                'PLSQL';
PLSQLUSESLASH:                        'PLSQLUSESLASH';
PLSQLCLIENTDIALECT:                   'PLSQLCLIENTDIALECT';
POLICY:                               'POLICY';
POLICYBASES:                          'POLICYBASES';
POLICIES:                             'POLICIES';
PRECEDING:                            'PRECEDING';
PRINCIPALS:                           'PRINCIPALS';
PRIOR:                                'PRIOR';
PROTECTION:                           'PROTECTION';
QUOTA:                                'QUOTA';
READONLY:                             'READONLY';
REJECT:                               'REJECT';
RELY:                                 'RELY';
ROLE:                                 'ROLE';
ROLES:                                'ROLES';
RULE:                                 'RULE';
RULEBASE:                             'RULEBASE';
RULEBASES:                            'RULEBASES';
RULEFUNCTION:                         'RULEFUNCTION';
RULEFUNCTIONS:                        'RULEFUNCTIONS';
RULES:                                'RULES';
SEGMENT:                              'SEGMENT';
SEMI2:                                'SEMI';
SEQUENCES:                            'SEQUENCES';
SERDE:                                'SERDE';
SERDEPROPERTIES:                      'SERDEPROPERTIES';
SETS:                                 'SETS';
SHARD:                                'SHARD';
SHOW_DATABASE:                        'SHOW_DATABASE';
SKEWED:                               'SKEWED';
SORT:                                 'SORT';
SORTED:                               'SORTED';
SPACE2:                               'SPACE';
STATISTICS:                           'STATISTICS';
STREAMJOB:                            'STREAMJOB';
STREAMJOBS:                           'STREAMJOBS';
STREAMS:                              'STREAMS';
SYSTIMESTAMP:                         'SYSTIMESTAMP';
TABLESIZE:                            'TABLESIZE';
TABLET:                               'TABLET';
TBLPROPERTIES:                        'TBLPROPERTIES';
TD:                                   'TD';
TOUCH:                                'TOUCH';
TRANSACTIONS:                         'TRANSACTIONS';
TYPE:                                 'TYPE';
UNARCHIVE:                            'UNARCHIVE';
UNBOUNDED:                            'UNBOUNDED';
UNIONTYPE:                            'UNIONTYPE';
UNLIMITED:                            'UNLIMITED';
UNSET:                                'UNSET';
URI:                                  'URI';
VALIDATE:                             'VALIDATE';
VIEWS:                                'VIEWS';

// INCEPTOR PLSQL Keywords
AUTONOMOUS_TRANSACTION:               'AUTONOMOUS_TRANSACTION';
CONSTANT:                             'CONSTANT';
DENSE_RANK:                           'DENSE_RANK';
ELSIF:                                'ELSIF';
EXCEPTION:                            'EXCEPTION';
EXCEPTIONS:                           'EXCEPTIONS';
EXCEPTION_INIT:                       'EXCEPTION_INIT';
FORALL:                               'FORALL';
GOTO:                                 'GOTO';
INDEXED:                              'INDEXED';
INDICATOR:                            'INDICATOR';
INDICES:                              'INDICES';
INLINE:                               'INLINE';
ISOPEN:                               'ISOPEN';
KEEP:                                 'KEEP';
NOCOPY:                               'NOCOPY';
NOTFOUND:                             'NOTFOUND';
NULLS:                                'NULLS';
OF:                                   'OF';
OVER:                                 'OVER';
PIPE:                                 'PIPE';
PIPELINED:                            'PIPELINED';
PRAGMA:                               'PRAGMA';
RAISE:                                'RAISE';
RECORD:                               'RECORD';
REF:                                  'REF';
RESPECT:                              'RESPECT';
RESTRICT_REFERENCES:                  'RESTRICT_REFERENCES';
RESULT_CACHE:                         'RESULT_CACHE';
ROWTYPE:                              'ROWTYPE';
ROWCOUNT:                             'ROWCOUNT';
SAVE:                                 'SAVE';
SIBLINGS:                             'SIBLINGS';
SUBTYPE:                              'SUBTYPE';
SERIALLY_REUSABLE:                    'SERIALLY_REUSABLE';
VARRAY:                               'VARRAY';


// DATA TYPE Keywords

TINYINT:                             'TINYINT';
SMALLINT:                            'SMALLINT';
MEDIUMINT:                           'MEDIUMINT';
INT:                                 'INT';
INTEGER:                             'INTEGER';
BIGINT:                              'BIGINT';
REAL:                                'REAL';
DOUBLE:                              'DOUBLE';
PRECISION:                           'PRECISION';
FLOAT:                               'FLOAT';
DECIMAL:                             'DECIMAL';
DEC:                                 'DEC';
NUMERIC:                             'NUMERIC';
DATE:                                'DATE';
TIME:                                'TIME';
TIMESTAMP:                           'TIMESTAMP';
DATETIME:                            'DATETIME';
YEAR:                                'YEAR';
CHAR:                                'CHAR';
VARCHAR:                             'VARCHAR';
NVARCHAR:                            'NVARCHAR';
NATIONAL:                            'NATIONAL';
BINARY:                              'BINARY';
VARBINARY:                           'VARBINARY';
TINYBLOB:                            'TINYBLOB';
BLOB:                                'BLOB';
MEDIUMBLOB:                          'MEDIUMBLOB';
LONGBLOB:                            'LONGBLOB';
TINYTEXT:                            'TINYTEXT';
TEXT:                                'TEXT';
MEDIUMTEXT:                          'MEDIUMTEXT';
LONGTEXT:                            'LONGTEXT';
ENUM:                                'ENUM';
VARYING:                             'VARYING';
SERIAL:                              'SERIAL';

// INCEPTOR TYPE Keywords
ARRAY:                               'ARRAY';
CLOB:                                'CLOB';
GEO:                                 'GEO';
NUMBER:                              'NUMBER';
STRUCT:                              'STRUCT';
VARCHAR2:                            'VARCHAR2';


// Interval type Keywords

YEAR_MONTH:                          'YEAR_MONTH';
DAY_HOUR:                            'DAY_HOUR';
DAY_MINUTE:                          'DAY_MINUTE';
DAY_SECOND:                          'DAY_SECOND';
HOUR_MINUTE:                         'HOUR_MINUTE';
HOUR_SECOND:                         'HOUR_SECOND';
MINUTE_SECOND:                       'MINUTE_SECOND';
SECOND_MICROSECOND:                  'SECOND_MICROSECOND';
MINUTE_MICROSECOND:                  'MINUTE_MICROSECOND';
HOUR_MICROSECOND:                    'HOUR_MICROSECOND';
DAY_MICROSECOND:                     'DAY_MICROSECOND';


// Group function Keywords

AVG:                                 'AVG';
BIT_AND:                             'BIT_AND';
BIT_OR:                              'BIT_OR';
BIT_XOR:                             'BIT_XOR';
COUNT:                               'COUNT';
GROUP_CONCAT:                        'GROUP_CONCAT';
MAX:                                 'MAX';
MIN:                                 'MIN';
STD:                                 'STD';
STDDEV:                              'STDDEV';
STDDEV_POP:                          'STDDEV_POP';
STDDEV_SAMP:                         'STDDEV_SAMP';
SUM:                                 'SUM';
VAR_POP:                             'VAR_POP';
VAR_SAMP:                            'VAR_SAMP';
VARIANCE:                            'VARIANCE';


// Common function Keywords

CURRENT_DATE:                        'CURRENT_DATE';
CURRENT_TIME:                        'CURRENT_TIME';
CURRENT_TIMESTAMP:                   'CURRENT_TIMESTAMP';
LOCALTIME:                           'LOCALTIME';
CURDATE:                             'CURDATE';
CURTIME:                             'CURTIME';
DATE_ADD:                            'DATE_ADD';
DATE_SUB:                            'DATE_SUB';
EXTRACT:                             'EXTRACT';
LOCALTIMESTAMP:                      'LOCALTIMESTAMP';
NOW:                                 'NOW';
POSITION:                            'POSITION';
SUBSTR:                              'SUBSTR';
SUBSTRING:                           'SUBSTRING';
SYSDATE:                             'SYSDATE';
TRIM:                                'TRIM';
UTC_DATE:                            'UTC_DATE';
UTC_TIME:                            'UTC_TIME';
UTC_TIMESTAMP:                       'UTC_TIMESTAMP';



// Keywords, but can be ID
// Common Keywords, but can be ID

ACCOUNT:                             'ACCOUNT';
ACTION:                              'ACTION';
AFTER:                               'AFTER';
AGGREGATE:                           'AGGREGATE';
ALGORITHM:                           'ALGORITHM';
ANY:                                 'ANY';
AT:                                  'AT';
AUTHORS:                             'AUTHORS';
AUTOCOMMIT:                          'AUTOCOMMIT';
AUTOEXTEND_SIZE:                     'AUTOEXTEND_SIZE';
AUTO_INCREMENT:                      'AUTO_INCREMENT';
AVG_ROW_LENGTH:                      'AVG_ROW_LENGTH';
BEGIN:                               'BEGIN';
BINLOG:                              'BINLOG';
BIT:                                 'BIT';
BLOCK:                               'BLOCK';
BOOL:                                'BOOL';
BOOLEAN:                             'BOOLEAN';
BTREE:                               'BTREE';
CACHE:                               'CACHE';
CASCADED:                            'CASCADED';
CHAIN:                               'CHAIN';
CHANGED:                             'CHANGED';
CHANNEL:                             'CHANNEL';
CHECKSUM:                            'CHECKSUM';
PAGE_CHECKSUM:                       'PAGE_CHECKSUM';
CIPHER:                              'CIPHER';
CLIENT:                              'CLIENT';
CLOSE:                               'CLOSE';
COALESCE:                            'COALESCE';
CODE:                                'CODE';
COLUMNS:                             'COLUMNS';
COLUMN_FORMAT:                       'COLUMN_FORMAT';
COMMENT:                             'COMMENT';
COMMIT:                              'COMMIT';
COMPACT:                             'COMPACT';
COMPLETION:                          'COMPLETION';
COMPRESSED:                          'COMPRESSED';
COMPRESSION:                         'COMPRESSION';
CONCURRENT:                          'CONCURRENT';
CONNECTION:                          'CONNECTION';
CONSISTENT:                          'CONSISTENT';
CONTAINS:                            'CONTAINS';
CONTEXT:                             'CONTEXT';
CONTRIBUTORS:                        'CONTRIBUTORS';
COPY:                                'COPY';
CPU:                                 'CPU';
DATA:                                'DATA';
DATAFILE:                            'DATAFILE';
DEALLOCATE:                          'DEALLOCATE';
DEFAULT_AUTH:                        'DEFAULT_AUTH';
DEFINER:                             'DEFINER';
DELAY_KEY_WRITE:                     'DELAY_KEY_WRITE';
DES_KEY_FILE:                        'DES_KEY_FILE';
DIRECTORY:                           'DIRECTORY';
DISABLE:                             'DISABLE';
DISCARD:                             'DISCARD';
DISK:                                'DISK';
DO:                                  'DO';
DUMPFILE:                            'DUMPFILE';
DUPLICATE:                           'DUPLICATE';
DYNAMIC:                             'DYNAMIC';
ENABLE:                              'ENABLE';
ENCRYPTION:                          'ENCRYPTION';
END:                                 'END';
ENDS:                                'ENDS';
ENGINE:                              'ENGINE';
ENGINES:                             'ENGINES';
ERROR:                               'ERROR';
ERRORS:                              'ERRORS';
ESCAPE:                              'ESCAPE';
EVEN:                                'EVEN';
EVENT:                               'EVENT';
EVENTS:                              'EVENTS';
EVERY:                               'EVERY';
EXCHANGE:                            'EXCHANGE';
EXCLUSIVE:                           'EXCLUSIVE';
EXPIRE:                              'EXPIRE';
EXPORT:                              'EXPORT';
EXTENDED:                            'EXTENDED';
EXTENT_SIZE:                         'EXTENT_SIZE';
FAST:                                'FAST';
FAULTS:                              'FAULTS';
FIELDS:                              'FIELDS';
FILE_BLOCK_SIZE:                     'FILE_BLOCK_SIZE';
FILTER:                              'FILTER';
FIRST:                               'FIRST';
FIXED:                               'FIXED';
FLUSH:                               'FLUSH';
FOLLOWS:                             'FOLLOWS';
FOUND:                               'FOUND';
FULL:                                'FULL';
FUNCTION:                            'FUNCTION';
GENERAL:                             'GENERAL';
GLOBAL:                              'GLOBAL';
GRANTS:                              'GRANTS';
GROUP_REPLICATION:                   'GROUP_REPLICATION';
HANDLER:                             'HANDLER';
HASH:                                'HASH';
HELP:                                'HELP';
HOST:                                'HOST';
HOSTS:                               'HOSTS';
IDENTIFIED:                          'IDENTIFIED';
IGNORE_SERVER_IDS:                   'IGNORE_SERVER_IDS';
IMPORT:                              'IMPORT';
INDEXES:                             'INDEXES';
INITIAL_SIZE:                        'INITIAL_SIZE';
INPLACE:                             'INPLACE';
INSERT_METHOD:                       'INSERT_METHOD';
INSTALL:                             'INSTALL';
INSTANCE:                            'INSTANCE';
INVOKER:                             'INVOKER';
IO:                                  'IO';
IO_THREAD:                           'IO_THREAD';
IPC:                                 'IPC';
ISOLATION:                           'ISOLATION';
ISSUER:                              'ISSUER';
JSON:                                'JSON';
KEY_BLOCK_SIZE:                      'KEY_BLOCK_SIZE';
LANGUAGE:                            'LANGUAGE';
LAST:                                'LAST';
LEAVES:                              'LEAVES';
LESS:                                'LESS';
LEVEL:                               'LEVEL';
LIST:                                'LIST';
LOCAL:                               'LOCAL';
LOGFILE:                             'LOGFILE';
LOGS:                                'LOGS';
MASTER:                              'MASTER';
MASTER_AUTO_POSITION:                'MASTER_AUTO_POSITION';
MASTER_CONNECT_RETRY:                'MASTER_CONNECT_RETRY';
MASTER_DELAY:                        'MASTER_DELAY';
MASTER_HEARTBEAT_PERIOD:             'MASTER_HEARTBEAT_PERIOD';
MASTER_HOST:                         'MASTER_HOST';
MASTER_LOG_FILE:                     'MASTER_LOG_FILE';
MASTER_LOG_POS:                      'MASTER_LOG_POS';
MASTER_PASSWORD:                     'MASTER_PASSWORD';
MASTER_PORT:                         'MASTER_PORT';
MASTER_RETRY_COUNT:                  'MASTER_RETRY_COUNT';
MASTER_SSL:                          'MASTER_SSL';
MASTER_SSL_CA:                       'MASTER_SSL_CA';
MASTER_SSL_CAPATH:                   'MASTER_SSL_CAPATH';
MASTER_SSL_CERT:                     'MASTER_SSL_CERT';
MASTER_SSL_CIPHER:                   'MASTER_SSL_CIPHER';
MASTER_SSL_CRL:                      'MASTER_SSL_CRL';
MASTER_SSL_CRLPATH:                  'MASTER_SSL_CRLPATH';
MASTER_SSL_KEY:                      'MASTER_SSL_KEY';
MASTER_TLS_VERSION:                  'MASTER_TLS_VERSION';
MASTER_USER:                         'MASTER_USER';
MAX_CONNECTIONS_PER_HOUR:            'MAX_CONNECTIONS_PER_HOUR';
MAX_QUERIES_PER_HOUR:                'MAX_QUERIES_PER_HOUR';
MAX_ROWS:                            'MAX_ROWS';
MAX_SIZE:                            'MAX_SIZE';
MAX_UPDATES_PER_HOUR:                'MAX_UPDATES_PER_HOUR';
MAX_USER_CONNECTIONS:                'MAX_USER_CONNECTIONS';
MEDIUM:                              'MEDIUM';
MERGE:                               'MERGE';
MID:                                 'MID';
MIGRATE:                             'MIGRATE';
MIN_ROWS:                            'MIN_ROWS';
MODE:                                'MODE';
MODIFY:                              'MODIFY';
MUTEX:                               'MUTEX';
MYSQL:                               'MYSQL';
NAME:                                'NAME';
NAMES:                               'NAMES';
NCHAR:                               'NCHAR';
NEVER:                               'NEVER';
NEXT:                                'NEXT';
NO:                                  'NO';
NODEGROUP:                           'NODEGROUP';
NONE:                                'NONE';
OFFLINE:                             'OFFLINE';
OFFSET:                              'OFFSET';
OJ:                                  'OJ';
OLD_PASSWORD:                        'OLD_PASSWORD';
ONE:                                 'ONE';
ONLINE:                              'ONLINE';
ONLY:                                'ONLY';
OPEN:                                'OPEN';
OPTIMIZER_COSTS:                     'OPTIMIZER_COSTS';
OPTIONS:                             'OPTIONS';
OWNER:                               'OWNER';
PACK_KEYS:                           'PACK_KEYS';
PAGE:                                'PAGE';
PARSER:                              'PARSER';
PARTIAL:                             'PARTIAL';
PARTITIONING:                        'PARTITIONING';
PARTITIONS:                          'PARTITIONS';
PASSWORD:                            'PASSWORD';
PHASE:                               'PHASE';
PLUGIN:                              'PLUGIN';
PLUGIN_DIR:                          'PLUGIN_DIR';
PLUGINS:                             'PLUGINS';
PORT:                                'PORT';
PRECEDES:                            'PRECEDES';
PREPARE:                             'PREPARE';
PRESERVE:                            'PRESERVE';
PREV:                                'PREV';
PROCESSLIST:                         'PROCESSLIST';
PROFILE:                             'PROFILE';
PROFILES:                            'PROFILES';
PROXY:                               'PROXY';
QUERY:                               'QUERY';
QUICK:                               'QUICK';
REBUILD:                             'REBUILD';
RECOVER:                             'RECOVER';
REDO_BUFFER_SIZE:                    'REDO_BUFFER_SIZE';
REDUNDANT:                           'REDUNDANT';
RELAY:                               'RELAY';
RELAY_LOG_FILE:                      'RELAY_LOG_FILE';
RELAY_LOG_POS:                       'RELAY_LOG_POS';
RELAYLOG:                            'RELAYLOG';
REMOVE:                              'REMOVE';
REORGANIZE:                          'REORGANIZE';
REPAIR:                              'REPAIR';
REPLICATE_DO_DB:                     'REPLICATE_DO_DB';
REPLICATE_DO_TABLE:                  'REPLICATE_DO_TABLE';
REPLICATE_IGNORE_DB:                 'REPLICATE_IGNORE_DB';
REPLICATE_IGNORE_TABLE:              'REPLICATE_IGNORE_TABLE';
REPLICATE_REWRITE_DB:                'REPLICATE_REWRITE_DB';
REPLICATE_WILD_DO_TABLE:             'REPLICATE_WILD_DO_TABLE';
REPLICATE_WILD_IGNORE_TABLE:         'REPLICATE_WILD_IGNORE_TABLE';
REPLICATION:                         'REPLICATION';
RESET:                               'RESET';
RESUME:                              'RESUME';
RETURNS:                             'RETURNS';
ROLLBACK:                            'ROLLBACK';
ROLLUP:                              'ROLLUP';
ROTATE:                              'ROTATE';
ROW:                                 'ROW';
ROWS:                                'ROWS';
ROW_FORMAT:                          'ROW_FORMAT';
SAVEPOINT:                           'SAVEPOINT';
SCHEDULE:                            'SCHEDULE';
SECURITY:                            'SECURITY';
SERVER:                              'SERVER';
SESSION:                             'SESSION';
SHARE:                               'SHARE';
SHARED:                              'SHARED';
SIGNED:                              'SIGNED';
SIMPLE:                              'SIMPLE';
SLAVE:                               'SLAVE';
SLOW:                                'SLOW';
SNAPSHOT:                            'SNAPSHOT';
SOCKET:                              'SOCKET';
SOME:                                'SOME';
SONAME:                              'SONAME';
SOUNDS:                              'SOUNDS';
SOURCE:                              'SOURCE';
SQL_AFTER_GTIDS:                     'SQL_AFTER_GTIDS';
SQL_AFTER_MTS_GAPS:                  'SQL_AFTER_MTS_GAPS';
SQL_BEFORE_GTIDS:                    'SQL_BEFORE_GTIDS';
SQL_BUFFER_RESULT:                   'SQL_BUFFER_RESULT';
SQL_CACHE:                           'SQL_CACHE';
SQL_NO_CACHE:                        'SQL_NO_CACHE';
SQL_THREAD:                          'SQL_THREAD';
START:                               'START';
STARTS:                              'STARTS';
STATS_AUTO_RECALC:                   'STATS_AUTO_RECALC';
STATS_PERSISTENT:                    'STATS_PERSISTENT';
STATS_SAMPLE_PAGES:                  'STATS_SAMPLE_PAGES';
STATUS:                              'STATUS';
STOP:                                'STOP';
STORAGE:                             'STORAGE';
STORED:                              'STORED';
STRING:                              'STRING';
SUBJECT:                             'SUBJECT';
SUBPARTITION:                        'SUBPARTITION';
SUBPARTITIONS:                       'SUBPARTITIONS';
SUSPEND:                             'SUSPEND';
SWAPS:                               'SWAPS';
SWITCHES:                            'SWITCHES';
TABLESPACE:                          'TABLESPACE';
TEMPORARY:                           'TEMPORARY';
TEMPTABLE:                           'TEMPTABLE';
THAN:                                'THAN';
TRADITIONAL:                         'TRADITIONAL';
TRANSACTION:                         'TRANSACTION';
TRIGGERS:                            'TRIGGERS';
TRUNCATE:                            'TRUNCATE';
UNDEFINED:                           'UNDEFINED';
UNDOFILE:                            'UNDOFILE';
UNDO_BUFFER_SIZE:                    'UNDO_BUFFER_SIZE';
UNINSTALL:                           'UNINSTALL';
UNKNOWN:                             'UNKNOWN';
UNTIL:                               'UNTIL';
UPGRADE:                             'UPGRADE';
USER:                                'USER';
USE_FRM:                             'USE_FRM';
USER_RESOURCES:                      'USER_RESOURCES';
VALIDATION:                          'VALIDATION';
VALUE:                               'VALUE';
VARIABLES:                           'VARIABLES';
VIEW:                                'VIEW';
VIRTUAL:                             'VIRTUAL';
WAIT:                                'WAIT';
WARNINGS:                            'WARNINGS';
WITHOUT:                             'WITHOUT';
WORK:                                'WORK';
WRAPPER:                             'WRAPPER';
X509:                                'X509';
XA:                                  'XA';
XML:                                 'XML';


// Date format Keywords

EUR:                                 'EUR';
USA:                                 'USA';
JIS:                                 'JIS';
ISO:                                 'ISO';


// Interval type Keywords

QUARTER:                             'QUARTER';
MONTH:                               'MONTH';
DAY:                                 'DAY';
HOUR:                                'HOUR';
MINUTE:                              'MINUTE';
WEEK:                                'WEEK';
SECOND:                              'SECOND';
MICROSECOND:                         'MICROSECOND';


// PRIVILEGES

TABLES:                              'TABLES';
ROUTINE:                             'ROUTINE';
EXECUTE:                             'EXECUTE';
FILE:                                'FILE';
PROCESS:                             'PROCESS';
RELOAD:                              'RELOAD';
SHUTDOWN:                            'SHUTDOWN';
SUPER:                               'SUPER';
PRIVILEGES:                          'PRIVILEGES';


// Charsets

ARMSCII8:                            'ARMSCII8';
ASCII:                               'ASCII';
BIG5:                                'BIG5';
CP1250:                              'CP1250';
CP1251:                              'CP1251';
CP1256:                              'CP1256';
CP1257:                              'CP1257';
CP850:                               'CP850';
CP852:                               'CP852';
CP866:                               'CP866';
CP932:                               'CP932';
DEC8:                                'DEC8';
EUCJPMS:                             'EUCJPMS';
EUCKR:                               'EUCKR';
GB2312:                              'GB2312';
GBK:                                 'GBK';
GEOSTD8:                             'GEOSTD8';
GREEK:                               'GREEK';
HEBREW:                              'HEBREW';
HP8:                                 'HP8';
KEYBCS2:                             'KEYBCS2';
KOI8R:                               'KOI8R';
KOI8U:                               'KOI8U';
LATIN1:                              'LATIN1';
LATIN2:                              'LATIN2';
LATIN5:                              'LATIN5';
LATIN7:                              'LATIN7';
MACCE:                               'MACCE';
MACROMAN:                            'MACROMAN';
SJIS:                                'SJIS';
SWE7:                                'SWE7';
TIS620:                              'TIS620';
UCS2:                                'UCS2';
UJIS:                                'UJIS';
UTF16:                               'UTF16';
UTF16LE:                             'UTF16LE';
UTF32:                               'UTF32';
UTF8:                                'UTF8';
UTF8MB3:                             'UTF8MB3';
UTF8MB4:                             'UTF8MB4';

// File format type
CSVFILE:                             'CSVFILE';
ES:                                  'ES';
FWCFILE:                             'FWCFILE';
HOLODESK:                            'HOLODESK';
HYPERDRIVE:                          'HYPERDRIVE';
ORC:                                 'ORC';
ORC_TRANSACTION:                     'ORC_TRANSACTION';
PARQUET:                             'PARQUET';
RCFILE:                              'RCFILE';
SEQUENCEFILE:                        'SEQUENCEFILE';
STARGATE:                            'STARGATE';
STELLARDB:                           'STELLARDB';
TEXTFILE:                            'TEXTFILE';

// DB Engines

ARCHIVE:                             'ARCHIVE';
BLACKHOLE:                           'BLACKHOLE';
CSV:                                 'CSV';
FEDERATED:                           'FEDERATED';
INNODB:                              'INNODB';
MEMORY:                              'MEMORY';
MRG_MYISAM:                          'MRG_MYISAM';
MYISAM:                              'MYISAM';
NDB:                                 'NDB';
NDBCLUSTER:                          'NDBCLUSTER';
PERFORMANCE_SCHEMA:                  'PERFORMANCE_SCHEMA';
TOKUDB:                              'TOKUDB';


// Transaction Levels

REPEATABLE:                          'REPEATABLE';
COMMITTED:                           'COMMITTED';
UNCOMMITTED:                         'UNCOMMITTED';
SERIALIZABLE:                        'SERIALIZABLE';


// Spatial data types

GEOMETRYCOLLECTION:                  'GEOMETRYCOLLECTION';
GEOMCOLLECTION:                      'GEOMCOLLECTION';
GEOMETRY:                            'GEOMETRY';
LINESTRING:                          'LINESTRING';
MULTILINESTRING:                     'MULTILINESTRING';
MULTIPOINT:                          'MULTIPOINT';
MULTIPOLYGON:                        'MULTIPOLYGON';
POINT:                               'POINT';
POLYGON:                             'POLYGON';

// Common function names
CHARSET:                             'CHARSET';
COLLATION:                           'COLLATION';
FORMAT:                              'FORMAT';
GET_FORMAT:                          'GET_FORMAT';
LOG:                                 'LOG';
REVERSE:                             'REVERSE';
WEIGHT_STRING:                       'WEIGHT_STRING';


// Operators
// Operators. Assigns

VAR_ASSIGN:                          ':=';
PLUS_ASSIGN:                         '+=';
MINUS_ASSIGN:                        '-=';
MULT_ASSIGN:                         '*=';
DIV_ASSIGN:                          '/=';
MOD_ASSIGN:                          '%=';
AND_ASSIGN:                          '&=';
XOR_ASSIGN:                          '^=';
OR_ASSIGN:                           '|=';


// Operators. Arithmetics

STAR:                                '*';
DIVIDE:                              '/';
MODULE:                              '%';
PLUS:                                '+';
MINUSMINUS:                          '--';
MINUS:                               '-';
DIV:                                 'DIV';
MOD:                                 'MOD';


// Operators. Comparation

EQUAL_SYMBOL:                        '=';
GREATER_SYMBOL:                      '>';
LESS_SYMBOL:                         '<';
EXCLAMATION_SYMBOL:                  '!';


// Operators. Bit

BIT_NOT_OP:                          '~';
BIT_OR_OP:                           '|';
BIT_AND_OP:                          '&';
BIT_XOR_OP:                          '^';


// Constructors symbols

DOT:                                 '.';
LC_BRACKET:                          '{';
RC_BRACKET:                          '}';
LR_BRACKET:                          '(';
RR_BRACKET:                          ')';
LS_BRACKET:                          '[';
RS_BRACKET:                          ']';
COMMA:                               ',';
SEMI:                                ';';
AT_SIGN:                             '@';
ZERO_DECIMAL:                        '0';
ONE_DECIMAL:                         '1';
TWO_DECIMAL:                         '2';
SINGLE_QUOTE_SYMB:                   '\'';
DOUBLE_QUOTE_SYMB:                   '"';
REVERSE_QUOTE_SYMB:                  '`';
COLON_SYMB:                          ':';
DOLLAR_SIGN:                         '$';



// Charsets

CHARSET_REVERSE_QOUTE_STRING:        '`' CHARSET_NAME '`';



// File's sizes


// 增加了'B' 在inceptor合法
FILESIZE_LITERAL:                    DEC_DIGIT+ ('B'|'K'|'M'|'G'|'T');



// Literal Primitives


START_NATIONAL_STRING_LITERAL:       'N' SQUOTA_STRING;
STRING_LITERAL:                      DQUOTA_STRING | SQUOTA_STRING | BQUOTA_STRING;
DECIMAL_LITERAL:                     DEC_DIGIT+;
HEXADECIMAL_LITERAL:                 'X' '\'' (HEX_DIGIT HEX_DIGIT)+ '\''
                                     | '0X' HEX_DIGIT+;

REAL_LITERAL:                        (DEC_DIGIT+)? '.' DEC_DIGIT+
                                     | DEC_DIGIT+ '.' EXPONENT_NUM_PART
                                     | (DEC_DIGIT+)? '.' (DEC_DIGIT+ EXPONENT_NUM_PART)
                                     | DEC_DIGIT+ EXPONENT_NUM_PART;
NULL_SPEC_LITERAL:                   '\\' 'N';
BIT_STRING:                          BIT_STRING_L;
STRING_CHARSET_NAME:                 '_' CHARSET_NAME;




// Hack for dotID
// Prevent recognize string:         .123somelatin AS ((.123), FLOAT_LITERAL), ((somelatin), ID)
//  it must recoginze:               .123somelatin AS ((.), DOT), (123somelatin, ID)

DOT_ID:                              '.' ID_LITERAL;



// Identifiers

ID:                                  ID_LITERAL;
// DOUBLE_QUOTE_ID:                  '"' ~'"'+ '"';
REVERSE_QUOTE_ID:                    '`' ~'`'+ '`';
STRING_USER_NAME:                    (
                                       SQUOTA_STRING | DQUOTA_STRING
                                       | BQUOTA_STRING | ID_LITERAL
                                     ) '@'
                                     (
                                       SQUOTA_STRING | DQUOTA_STRING
                                       | BQUOTA_STRING | ID_LITERAL
                                     );
LOCAL_ID:                            '@'
                                (
                                  [A-Z0-9._$]+
                                  | SQUOTA_STRING
                                  | DQUOTA_STRING
                                  | BQUOTA_STRING
                                );
GLOBAL_ID:                           '@' '@'
                                (
                                  [A-Z0-9._$]+
                                  | BQUOTA_STRING
                                );
TEMPLATE_ID:                         '$' SPACE* '{' SPACE* ID_LITERAL DOT_ID* SPACE* '}';

// Others
QUESTION_MARK:                        '?';
INTRODUCER:                           '_';
TWO_DOTS:                             '..';

// Fragments for Literal primitives

fragment CHARSET_NAME:               ARMSCII8 | ASCII | BIG5 | BINARY | CP1250
                                     | CP1251 | CP1256 | CP1257 | CP850
                                     | CP852 | CP866 | CP932 | DEC8 | EUCJPMS
                                     | EUCKR | GB2312 | GBK | GEOSTD8 | GREEK
                                     | HEBREW | HP8 | KEYBCS2 | KOI8R | KOI8U
                                     | LATIN1 | LATIN2 | LATIN5 | LATIN7
                                     | MACCE | MACROMAN | SJIS | SWE7 | TIS620
                                     | UCS2 | UJIS | UTF16 | UTF16LE | UTF32
                                     | UTF8 | UTF8MB4;

fragment EXPONENT_NUM_PART:          'E' [-+]? DEC_DIGIT+;
// 汉语unicode
fragment HAN:                        [\p{Script=Han}\p{Script=Hans}\p{Script=Hant}];
fragment ID_CHAR:                    [A-Z] | HAN | '_' | '$';
fragment ID_LITERAL:                 (ID_CHAR | [0-9])*?ID_CHAR+?(ID_CHAR | [0-9])*;
fragment DQUOTA_STRING:              '"' ( '\\'. | '""' | ~('"'| '\\') )* '"';
fragment SQUOTA_STRING:              '\'' ('\\'. | '\'\'' | ~('\'' | '\\'))* '\'';
fragment BQUOTA_STRING:              '`' ( '\\'. | '``' | ~('`'|'\\'))* '`';
fragment HEX_DIGIT:                  [0-9A-F];
fragment DEC_DIGIT:                  [0-9];
fragment BIT_STRING_L:               'B' '\'' [01]+ '\'';


// Last tokens must generate Errors

ERROR_RECONGNIGION:                  .    -> channel(ERRORCHANNEL);
