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

parser grammar MySqlParser;

options { tokenVocab=MySqlLexer; }


// Top Level Description

root
    : sqlStatements? MINUSMINUS? EOF
    ;

sqlStatements
    : (sqlStatement MINUSMINUS? SEMI? | emptyStatement)*
    (sqlStatement (MINUSMINUS? SEMI)? | emptyStatement)
    ;

sqlStatement
    : dclStatement | ddlStatement | dmlStatement | transactionStatement
    | replicationStatement | preparedStatement | administrationStatement
    | utilityStatement | anchorStatement
    | {this.isDialect('inceptor')}? (
      plsqlStatement
    )
    ;

emptyStatement
    : SEMI
    ;

ddlStatement
    : createDatabase | createIndex | createProcedure
    | createFunction | createTable | createView
    | createTemporaryFunction
    | alterDatabase | alterProcedure | alterTable
    | dropDatabase | dropIndex | dropPackage| dropProcedure
    | dropFunction | dropTable | dropView
    | truncateTable
    | {this.isDialect('mysql')}? (
        createEvent | createLogfileGroup | createServer
        | createTablespaceInnodb | createTablespaceNdb
        | createTrigger
        | alterEvent | alterFunction | alterInstance
        | alterLogfileGroup | alterServer | alterTablespace
        | alterView
        | dropEvent | dropLogfileGroup
        | dropServer | dropTablespace | dropTrigger
        | renameTable
      )
    ;

dmlStatement
    : selectStatement | insertStatement | updateStatement
    | deleteStatement | callStatement | loadDataStatement
    | doStatement
    | {this.isDialect('inceptor')}? (
        insertFile | mergeStatement | withStatement | fromInsertStatement
      )
    | {this.isDialect('mysql')}? (
        replaceStatement | loadXmlStatement | handlerStatement
      )
    // TODO: SEE if callStatement can be in procedure body
    ;

transactionStatement
    : {this.isDialect('mysql')}? (startTransaction
      | beginWork | commitWork | rollbackWork
      | lockTables | unlockTables | savepointStatement
      | releaseStatement | rollbackStatement
    )
    | {this.isDialect('inceptor')}? transactionStatementInceptor
    ;

replicationStatement
    : {this.isDialect('mysql')}? (
        changeMaster | changeReplicationFilter | purgeBinaryLogs
        | resetMaster | resetSlave | startSlave | stopSlave
        | startGroupReplication | stopGroupReplication
        | xaStartTransaction | xaEndTransaction | xaPrepareStatement
        | xaCommitWork | xaRollbackWork | xaRecoverWork
      )
    ;

preparedStatement
    : {this.isDialect('mysql')}? (
        prepareStatement | executeStatement | deallocatePrepare
      )
    ;

// remark: NOT INCLUDED IN sqlStatement, but include in body
//  of routine's statements
compoundStatement
    : blockStatement
    | caseStatement | ifStatement | leaveStatement
    | loopStatement | repeatStatement | whileStatement
    | iterateStatement | returnStatement | cursorStatement
    ;

administrationStatement
    : analyzeTable | setStatement | showStatement | setDelimiter
    | {this.isDialect('mysql')}? (
        checksumTable | optimizeTable | repairTable | checkTable
        | createUdfunction | installPlugin | uninstallPlugin
        | binlogStatement | cacheIndexStatement | flushStatement
        | killStatement | loadIndexIntoCache | resetStatement
        | shutdownStatement
      )
    | {this.isDialect('inceptor')}? (
        addJarStatement | listJarStatement | setPlsqlDialect
      )
    ;

utilityStatement
    : describeStatement | useStatement
    | {this.isDialect('mysql')}? (
        helpStatement
      )
    ;

dclStatement
    : {this.isDialect('mysql')}? (
      alterUser | createUser | dropUser | grantStatement
      | grantProxy | renameUser | revokeStatement | revokeProxy
    )
    | {this.isDialect('inceptor')}? (
        grantFacl | grantPermission | grantQuota | grantStatementInceptor
        | revokeFacl | revokePermission | revokeQuota | revokeStatementInceptor
        | roleStatementInceptor | showFacl | showGrantInceptor
        | showPermission | showPrincipal | showQuota
      )
    ;

// Start anchor
anchorStatement
    : CREATE createAnchor
    | DROP dropAnchor
    | startAnchor
      {
        this.notifyPlaceholderError($startAnchor.ctx, 'Please provide statement')
      }
    ;

startAnchor
    : placeholder
    ;

createAnchor
    : placeholder
    ;

dropAnchor
    : placeholder
    ;

// Data Definition Language

//    Create statements

createDatabase
    : CREATE dbFormat=(DATABASE | SCHEMA)
      ifNotExists? databaseName createDatabaseOption
    ;

createEvent
    : CREATE ownerStatement? EVENT ifNotExists? fullId
      ON SCHEDULE scheduleExpression
      (ON COMPLETION NOT? PRESERVE)? enableType?
      (COMMENT STRING_LITERAL)?
      DO routineBody
    ;

createIndex
    : CREATE
      intimeAction=(ONLINE | OFFLINE)?
      indexCategory=(UNIQUE | FULLTEXT | SPATIAL)?
      INDEX uid indexType?
      ON tableName indexColumnNames
      indexOption*
      (
        ALGORITHM '='? algType=(DEFAULT | INPLACE | COPY)
        | LOCK '='?
          lockType=(DEFAULT | NONE | SHARED | EXCLUSIVE)
      )?
    ;

createLogfileGroup
    : CREATE LOGFILE GROUP uid
      ADD UNDOFILE undoFile=STRING_LITERAL
      (INITIAL_SIZE '='? initSize=fileSizeLiteral)?
      (UNDO_BUFFER_SIZE '='? undoSize=fileSizeLiteral)?
      (REDO_BUFFER_SIZE '='? redoSize=fileSizeLiteral)?
      (NODEGROUP '='? uid)?
      WAIT?
      (COMMENT '='? comment=STRING_LITERAL)?
      ENGINE '='? engineName
    ;

createProcedure
    : CREATE orReplaceDialectAction?
    ownerStatement? PROCEDURE fullId
      '(' procedureParameter? (',' procedureParameter)* ')'
      routineOption*
    routineBody
    ;

createFunction
    : CREATE orReplaceDialectAction?
    ownerStatement? FUNCTION fullId
      '(' functionParameter? (',' functionParameter)* ')'
      RETURNS dataType
      routineOption*
    routineBody
    ;

createTemporaryFunction
    : {this.isDialect('inceptor')}? CREATE functionType FUNCTION ifNotExists? uid AS stringLiteral
      (USING permanentFunctionResource  (',' permanentFunctionResource )*)?
    ;

createServer
    : CREATE SERVER uid
    FOREIGN DATA WRAPPER wrapperName=(MYSQL | STRING_LITERAL)
    OPTIONS '(' serverOption (',' serverOption)* ')'
    ;

createTable
    : createTableHead ifNotExists?
       tableName
       (
         LIKE tableName
         | '(' LIKE parenthesisTable=tableName ')'
       ) createTableLikeOption                                      #copyCreateTable
    | createTableHead ifNotExists?
       tableName createDefinitions?
       createTableCreateOption createTableAsKeyViolate?
       createTableQuery
       dialectWithNoData?                                           #queryCreateTable
    | createTableHead ifNotExists?
       tableName createDefinitions?
       createTableAsKeyViolate?
       createTableQuery
       dialectWithNoData?                                           #queryCreateTable
    | createTableHead ifNotExists?
       tableName createDefinitions?
       {
         // createDefinitions -> createDefinitions? Error-Tolerant
         this.checkContextExist($createDefinitions.ctx, 'Please provide create table definition');

       }
       createTableCreateOption                                      #columnCreateTable
    ;

createTablespaceInnodb
    : CREATE TABLESPACE uid
      ADD DATAFILE datafile=STRING_LITERAL
      (FILE_BLOCK_SIZE '=' fileBlockSize=fileSizeLiteral)?
      (ENGINE '='? engineName)?
    ;

createTablespaceNdb
    : CREATE TABLESPACE uid
      ADD DATAFILE datafile=STRING_LITERAL
      USE LOGFILE GROUP uid
      (EXTENT_SIZE '='? extentSize=fileSizeLiteral)?
      (INITIAL_SIZE '='? initialSize=fileSizeLiteral)?
      (AUTOEXTEND_SIZE '='? autoextendSize=fileSizeLiteral)?
      (MAX_SIZE '='? maxSize=fileSizeLiteral)?
      (NODEGROUP '='? uid)?
      WAIT?
      (COMMENT '='? comment=STRING_LITERAL)?
      ENGINE '='? engineName
    ;

createTrigger
    : CREATE ownerStatement?
      TRIGGER thisTrigger=fullId
      triggerTime=(BEFORE | AFTER)
      triggerEvent=(INSERT | UPDATE | DELETE)
      ON tableName FOR EACH ROW
      (triggerPlace=(FOLLOWS | PRECEDES) otherTrigger=fullId)?
      routineBody
    ;

createView
    : {this.isDialect('mysql')}? createViewMysql
    | {this.isDialect('inceptor')}? createViewInceptor
    ;

createViewMysql
    locals [
      newlineTokens: Array<string> = ['VIEW', 'WITH']
    ]
    : CREATE (OR REPLACE)?
      (
        ALGORITHM '=' algType=(UNDEFINED | MERGE | TEMPTABLE)
      )?
      ownerStatement?
      (SQL SECURITY secContext=(DEFINER | INVOKER))?
      VIEW viewName ('(' uidList ')')?
      asSelectStatement?
      {
        // asSelectStatement -> asSelectStatement? Error-Tolerant
        this.checkContextExist($asSelectStatement.ctx, 'Please provide as select statement');
      }
      (WITH checkOption=(CASCADED | LOCAL)? CHECK OPTION)?
    ;

createViewInceptor
    locals [
      newlineTokens: Array<string> = ['PARTITIONED', 'TBLPROPERTIES']
    ]
    : CREATE (OR REPLACE)? VIEW
      ifNotExists? viewName
      ('(' uidCommentList ')')? commentClause?
      (PARTITIONED ON '(' uidList ')')?
      (TBLPROPERTIES '(' keyValueProperties ')')?
      asSelectStatement?
      {
        // asSelectStatement -> asSelectStatement? Error-Tolerant
        this.checkContextExist($asSelectStatement.ctx, 'Please provide as select statement');
      }
    ;

// details

createDatabaseOption
    locals [level: number = 0]
    : {this.isDialect('mysql')}? mysqlCreateDatabaseOption*
    | {this.isDialect('inceptor')}? inceptorCreateDatabaseOption
    ;

mysqlCreateDatabaseOption
    locals [level: number = 1]
    : DEFAULT? (CHARACTER SET | CHARSET) '='? charsetName
    | DEFAULT? COLLATE '='? collationName
    ;

inceptorCreateDatabaseOption
    locals [
      level: number = 1
      newlineTokens: Array<string> = ['LOCATION', 'WITH']
    ]
    : commentClause? (LOCATION stringLiteral)?
      (WITH DBPROPERTIES '(' keyValueProperties ')' )?
    ;

keyOrValueProperties
    : keyValueProperties | keyProperties
    ;

keyProperties
    : stringLiteral (',' stringLiteral)*
    ;

keyValueProperties
    : keyValueProperty (',' keyValueProperty)*
    ;

keyValueProperty
    : key=stringLiteral '=' value=stringLiteral
    ;

idValueProperties
    : idValueProperty (',' idValueProperty)*
    ;

idValueProperty
    : key=uid '=' value=constant
    ;

orReplaceDialectAction
    : {this.isDialect('inceptor')}? OR REPLACE
    ;

ownerStatement
    : DEFINER '=' (userName | CURRENT_USER ( '(' ')')?)
    ;

scheduleExpression
    : AT timestampValue intervalExpr*                               #preciseSchedule
    | EVERY (decimalLiteral | expression) intervalType
        (
          STARTS start_=timestampValue
          (startIntervals+=intervalExpr)*
        )?
        (
          ENDS end=timestampValue
          (endIntervals+=intervalExpr)*
        )?                                                          #intervalSchedule
    ;

timestampValue
    : CURRENT_TIMESTAMP
    | stringLiteral
    | decimalLiteral
    | expression
    ;

intervalExpr
    : '+' INTERVAL (decimalLiteral | expression) intervalType
    ;

intervalType
    : intervalTypeBase
    | YEAR | YEAR_MONTH | DAY_HOUR | DAY_MINUTE
    | DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND
    | SECOND_MICROSECOND | MINUTE_MICROSECOND
    | HOUR_MICROSECOND | DAY_MICROSECOND
    ;

enableType
    : ENABLE | DISABLE | DISABLE ON SLAVE
    ;

indexType
    : USING (BTREE | HASH)
    ;

indexOption
    : KEY_BLOCK_SIZE '='? fileSizeLiteral
    | indexType
    | WITH PARSER uid
    | COMMENT STRING_LITERAL
    ;

procedureParameter
    : direction=(IN | OUT | INOUT)? uid dataType
    ;

functionParameter
    : uid dataType
    ;

permanentFunctionResource
    : (JAR|FILE|ARCHIVE) (filePath | stringLiteral)
    ;

routineOption
    : COMMENT STRING_LITERAL                                        #routineComment
    | LANGUAGE SQL                                                  #routineLanguage
    | NOT? DETERMINISTIC                                            #routineBehavior
    | (
        CONTAINS SQL | NO SQL | READS SQL DATA
        | MODIFIES SQL DATA
      )                                                             #routineData
    | SQL SECURITY context=(DEFINER | INVOKER)                      #routineSecurity
    ;

serverOption
    : HOST STRING_LITERAL
    | DATABASE STRING_LITERAL
    | USER STRING_LITERAL
    | PASSWORD STRING_LITERAL
    | SOCKET STRING_LITERAL
    | OWNER STRING_LITERAL
    | PORT decimalLiteral
    ;

createTableHead
    : {this.isDialect('mysql')}? CREATE TEMPORARY? TABLE
    | {this.isDialect('inceptor')}? CREATE TEMPORARY? EXTERNAL? TABLE
    ;

createTableAsKeyViolate
    : {this.isDialect('mysql')}? keyViolate=(IGNORE | REPLACE)
    ;

createTableQuery
    : {this.isDialect('mysql')}? AS? selectStatement
    | {this.isDialect('inceptor')}? AS selectStatement
    ;

createTableLikeOption
    : {this.isDialect('inceptor')}? locationDefinition? tblPropertiesDefinition?
    ;

createTableCreateOption
    locals [level: number = 0]
    : {this.isDialect('mysql')}? ( tableOption (','? tableOption)* )?
      partitionDefinitions?
    | {this.isDialect('inceptor')}? commentClause?
      tablePartitionedBy?
      tableBuckets?
      tableSkewed?
      rowFormat?
      (
        fileStore | fileStoreBy
      )?
      esProps?
      locationDefinition?
      tblPropertiesDefinition?
      errorLogTableDefinition?
    ;

createDefinitions
    : '(' createDefinition (',' createDefinition)* ')'
    ;

createDefinition
    : createColumnDeclaration
    | tableConstraint
    | {this.isDialect('mysql')}? indexColumnDefinition
    ;

createColumnDeclaration
    : uid columnDefinition
    ;

columnDefinition
    : {this.isDialect('mysql')}? dataType columnConstraintMysql*
    | {this.isDialect('inceptor')}? dataType columnAnalyzer? columnConstraintInceptor*
    ;

columnConstraintMysql
    : nullNotnull                                                   #nullColumnConstraint
    | DEFAULT defaultValue                                          #defaultColumnConstraint
    | (AUTO_INCREMENT | ON UPDATE currentTimestamp)                 #autoIncrementColumnConstraint
    | PRIMARY? KEY                                                  #primaryKeyColumnConstraint
    | UNIQUE KEY?                                                   #uniqueKeyColumnConstraint
    | COMMENT STRING_LITERAL                                        #commentColumnConstraint
    | COLUMN_FORMAT colformat=(FIXED | DYNAMIC | DEFAULT)           #formatColumnConstraint
    | STORAGE storageval=(DISK | MEMORY | DEFAULT)                  #storageColumnConstraint
    | referenceDefinition                                           #referenceColumnConstraint
    | COLLATE collationName                                         #collateColumnConstraint
    | (GENERATED ALWAYS)? AS '(' expression ')' (VIRTUAL | STORED)? #generatedColumnConstraint
    | SERIAL DEFAULT VALUE                                          #serialDefaultColumnConstraint
    ;

columnConstraintInceptor
    : NOT NULL_LITERAL
    | UNIQUE
    | (CONSTRAINT uid)? PRIMARY KEY constraintOpts
    | (CONSTRAINT uid)? REFERENCES tableName '(' uid ')' constraintOpts
    | COMMENT stringLiteral
    | DEFAULT (constant | NULL_LITERAL)
    ;

columnAnalyzer
    : WITH ANALYZER p=stringLiteral analyzer=stringLiteral
    | APPEND ANALYZER p=stringLiteral analyzer=stringLiteral
    | NO_INDEX
    ;

constraintOpts
    : (ENABLE | DISABLE)? (VALIDATE | NOVALIDATE)? (RELY | NORELY)?
    ;

asSelectStatement
    locals [level: number = 0]
    : AS selectStatement
    ;

uidCommentList
    : uidComment (',' uidComment)*
    ;

uidComment
    : uid (COMMENT stringLiteral)?
    ;

tableBuckets
    locals [level: number = 0]
    : CLUSTERED BY ('(' uidList ')')
      (SORTED BY ('(' uidOrderList ')'))?
      intoBuckets?
      {
        this.checkContextExist($intoBuckets.ctx, 'Please provide INTO ... BUCKETS part');
      }
    ;

intoBuckets
    : INTO decimalLiteral BUCKETS
    ;

tableSkewed
    locals [level: number = 0]
    : SKEWED BY '(' uidList ')' ON '('
      (
        constants
        | ('(' constants ')' ',' ('(' constants ')')*)
      ) ')' (STORED AS DIRECTORIES)?
    ;

setSerde
    : SET SERDE stringLiteral
      (WITH SERDEPROPERTIES '(' keyOrValueProperties ')')?
    ;

esProps
    locals [level: number = 0]
    : WITH SHARD NUMBER decimalLiteral
      REPLICATION decimalLiteral ((DISABLE|ENABLE) ALL)?
    ;

holoProps
    locals [level: number = 0]
    : WITH TABLET NUMBER decimalLiteral
      CAPACITY NUMBER decimalLiteral REPLICATION decimalLiteral
    ;

holoTableSize
    locals [level: number = 0]
    : WITH TABLESIZE (decimalLiteral | stringLiteral)
      (REPLICATION (decimalLiteral | stringLiteral))?
    ;

dialectWithNoData
    : {this.isDialect('inceptor')}? WITH NO DATA
    ;

commentClause
    locals [level: number = 0]
    : COMMENT stringLiteral
    ;

setLocationDefinition
    : SET LOCATION stringLiteral
    ;

locationDefinition
    locals [level: number = 0]
    : LOCATION stringLiteral
    ;

tblPropertiesDefinition
    locals [level: number = 0]
    : TBLPROPERTIES '(' keyValueProperties ')'
    ;

// TODO: 这个规则似乎只给CREATE EXTERNAL TABLE用
errorLogTableDefinition
    locals [level: number = 0]
    : {this.isDialect('inceptor')}? LOG ERRORS INTO tableName
      OVERWRITE? errorRejectSpec?
    ;

errorRejectSpec
    : SEGMENT REJECT LIMIT numeric (ROWS | PERCENT)
    ;

tableConstraint
    : {this.isDialect('mysql')}? tableConstraintMysql
    | {this.isDialect('inceptor')}? tableConstraintInceptor
    ;

tableConstraintMysql
    : (CONSTRAINT name=uid?)?
      PRIMARY KEY index=uid? indexType?
      indexColumnNames indexOption*                                 #primaryKeyTableConstraint
    | (CONSTRAINT name=uid?)?
      UNIQUE indexFormat=(INDEX | KEY)? index=uid?
      indexType? indexColumnNames indexOption*                      #uniqueKeyTableConstraint
    | (CONSTRAINT name=uid?)?
      FOREIGN KEY index=uid? indexColumnNames
      referenceDefinition                                           #foreignKeyTableConstraint
    | (CONSTRAINT name=uid?)?
      CHECK '(' expression ')'                                      #checkTableConstraint
    ;

tableConstraintInceptor
    : (CONSTRAINT uid)? FOREIGN KEY '(' uidList ')'
      REFERENCES tabName=tableName '(' uidList ')' constraintOpts
    | (CONSTRAINT uid)? PRIMARY KEY '(' uidList ')' constraintOpts
    ;

referenceDefinition
    : REFERENCES tableName indexColumnNames?
      (MATCH matchType=(FULL | PARTIAL | SIMPLE))?
      referenceAction?
    ;

referenceAction
    : ON DELETE onDelete=referenceControlType
      (
        ON UPDATE onUpdate=referenceControlType
      )?
    | ON UPDATE onUpdate=referenceControlType
      (
        ON DELETE onDelete=referenceControlType
      )?
    ;

referenceControlType
    : RESTRICT | CASCADE | SET NULL_LITERAL | NO ACTION
    ;

indexColumnDefinition
    : indexFormat=(INDEX | KEY) uid? indexType?
      indexColumnNames indexOption*                                 #simpleIndexDeclaration
    | (FULLTEXT | SPATIAL)
      indexFormat=(INDEX | KEY)? uid?
      indexColumnNames indexOption*                                 #specialIndexDeclaration
    ;

tableOption
    : ENGINE '='? engineName                                        #tableOptionEngine
    | AUTO_INCREMENT '='? decimalLiteral                            #tableOptionAutoIncrement
    | AVG_ROW_LENGTH '='? decimalLiteral                            #tableOptionAverage
    | DEFAULT? (CHARACTER SET | CHARSET) '='? charsetName           #tableOptionCharset
    | (CHECKSUM | PAGE_CHECKSUM) '='? boolValue=('0' | '1')         #tableOptionChecksum
    | DEFAULT? COLLATE '='? collationName                           #tableOptionCollate
    | COMMENT '='? STRING_LITERAL                                   #tableOptionComment
    | COMPRESSION '='? (STRING_LITERAL | ID)                        #tableOptionCompression
    | CONNECTION '='? STRING_LITERAL                                #tableOptionConnection
    | DATA DIRECTORY '='? STRING_LITERAL                            #tableOptionDataDirectory
    | DELAY_KEY_WRITE '='? boolValue=('0' | '1')                    #tableOptionDelay
    | ENCRYPTION '='? STRING_LITERAL                                #tableOptionEncryption
    | INDEX DIRECTORY '='? STRING_LITERAL                           #tableOptionIndexDirectory
    | INSERT_METHOD '='? insertMethod=(NO | FIRST | LAST)           #tableOptionInsertMethod
    | KEY_BLOCK_SIZE '='? fileSizeLiteral                           #tableOptionKeyBlockSize
    | MAX_ROWS '='? decimalLiteral                                  #tableOptionMaxRows
    | MIN_ROWS '='? decimalLiteral                                  #tableOptionMinRows
    | PACK_KEYS '='? extBoolValue=('0' | '1' | DEFAULT)             #tableOptionPackKeys
    | PASSWORD '='? STRING_LITERAL                                  #tableOptionPassword
    | ROW_FORMAT '='?
        rowFormatValue=(
          DEFAULT | DYNAMIC | FIXED | COMPRESSED
          | REDUNDANT | COMPACT
        )                                                           #tableOptionRowFormat
    | STATS_AUTO_RECALC '='? extBoolValue=(DEFAULT | '0' | '1')     #tableOptionRecalculation
    | STATS_PERSISTENT '='? extBoolValue=(DEFAULT | '0' | '1')      #tableOptionPersistent
    | STATS_SAMPLE_PAGES '='? decimalLiteral                        #tableOptionSamplePage
    | TABLESPACE uid tablespaceStorage?                             #tableOptionTablespace
    | tablespaceStorage                                             #tableOptionTablespace
    | UNION '='? '(' tables ')'                                     #tableOptionUnion
    ;

tablespaceStorage
    : STORAGE (DISK | MEMORY | DEFAULT)
    ;

partitionDefinitions
    locals [level: number = 0]
    : PARTITION BY partitionFunctionDefinition
      (PARTITIONS count=decimalLiteral)?
      (
        SUBPARTITION BY subpartitionFunctionDefinition
        (SUBPARTITIONS subCount=decimalLiteral)?
      )?
    ('(' partitionDefinition (',' partitionDefinition)* ')')?
    ;

partitionFunctionDefinition
    : LINEAR? HASH '(' expression ')'                               #partitionFunctionHash
    | LINEAR? KEY (ALGORITHM '=' algType=('1' | '2'))?
      '(' uidList ')'                                               #partitionFunctionKey
    | RANGE ( '(' expression ')' | COLUMNS '(' uidList ')' )        #partitionFunctionRange
    | LIST ( '(' expression ')' | COLUMNS '(' uidList ')' )         #partitionFunctionList
    ;

subpartitionFunctionDefinition
    : LINEAR? HASH '(' expression ')'                               #subPartitionFunctionHash
    | LINEAR? KEY (ALGORITHM '=' algType=('1' | '2'))?
      '(' uidList ')'                                               #subPartitionFunctionKey
    ;

partitionDefinition
    : PARTITION uid VALUES LESS THAN
      '('
          partitionDefinerAtom (',' partitionDefinerAtom)*
      ')'
      partitionOption*
      (subpartitionDefinition (',' subpartitionDefinition)*)?       #partitionComparision
    | PARTITION uid VALUES LESS THAN
      partitionDefinerAtom partitionOption*
      (subpartitionDefinition (',' subpartitionDefinition)*)?       #partitionComparision
    | PARTITION uid VALUES IN
      '('
          partitionDefinerAtom (',' partitionDefinerAtom)*
      ')'
      partitionOption*
      (subpartitionDefinition (',' subpartitionDefinition)*)?       #partitionListAtom
    | PARTITION uid VALUES IN
      '('
          partitionDefinerVector (',' partitionDefinerVector)*
      ')'
      partitionOption*
      (subpartitionDefinition (',' subpartitionDefinition)*)?       #partitionListVector
    | PARTITION uid partitionOption*
      (subpartitionDefinition (',' subpartitionDefinition)*)?       #partitionSimple
    ;

partitionDefinerAtom
    : constant | expression | MAXVALUE
    ;

partitionDefinerVector
    : '(' partitionDefinerAtom (',' partitionDefinerAtom)+ ')'
    ;

subpartitionDefinition
    : SUBPARTITION uid partitionOption*
    ;

partitionOption
    : STORAGE? ENGINE '='? engineName                               #partitionOptionEngine
    | COMMENT '='? comment=STRING_LITERAL                           #partitionOptionComment
    | DATA DIRECTORY '='? dataDirectory=STRING_LITERAL              #partitionOptionDataDirectory
    | INDEX DIRECTORY '='? indexDirectory=STRING_LITERAL            #partitionOptionIndexDirectory
    | MAX_ROWS '='? maxRows=decimalLiteral                          #partitionOptionMaxRows
    | MIN_ROWS '='? minRows=decimalLiteral                          #partitionOptionMinRows
    | TABLESPACE '='? tablespace=uid                                #partitionOptionTablespace
    | NODEGROUP '='? nodegroup=uid                                  #partitionOptionNodeGroup
    ;

//    Alter statements

alterDatabase
    : ALTER dbFormat=(DATABASE | SCHEMA) databaseName
      alterDatabaseOption                                           #alterUpgradeName
    | {this.isDialect('mysql')}? ALTER dbFormat=(DATABASE | SCHEMA)
      mysqlCreateDatabaseOption+                                    #alterSimpleDatabase
    | {this.isDialect('mysql')}? ALTER dbFormat=(DATABASE | SCHEMA)
      databaseName mysqlCreateDatabaseOption+                       #alterSimpleDatabase
    | ALTER dbFormat=(DATABASE | SCHEMA) databaseName
      {
        this.notifyErrorListeners('Please provide alter body');
      }                                                             #alterMissingBody
    | ALTER dbFormat=(DATABASE | SCHEMA) databaseName
      alterDatabaseAnchor
      {
        this.notifyPlaceholderError($alterDatabaseAnchor.ctx, 'Please provide alter specification')
      }                                                             #alterDbPlacholder
    ;

alterEvent
    : ALTER ownerStatement?
      EVENT fullId
      (ON SCHEDULE scheduleExpression)?
      (ON COMPLETION NOT? PRESERVE)?
      (RENAME TO fullId)? enableType?
      (COMMENT STRING_LITERAL)?
      (DO routineBody)?
    ;

alterFunction
    : ALTER FUNCTION fullId routineOption*
    ;

alterInstance
    : ALTER INSTANCE ROTATE INNODB MASTER KEY
    ;

alterLogfileGroup
    : ALTER LOGFILE GROUP uid
      ADD UNDOFILE STRING_LITERAL
      (INITIAL_SIZE '='? fileSizeLiteral)?
      WAIT? ENGINE '='? engineName
    ;

alterProcedure
    : ALTER PROCEDURE fullId routineOption*
    ;

alterServer
    : ALTER SERVER uid OPTIONS
      '(' serverOption (',' serverOption)* ')'
    ;

alterTable
    : ALTER alterTableAction
      tableName alterSpecification
    ;

alterTablespace
    : ALTER TABLESPACE uid
      objectAction=(ADD | DROP) DATAFILE STRING_LITERAL
      (INITIAL_SIZE '=' fileSizeLiteral)?
      WAIT?
      ENGINE '='? engineName
    ;

alterView
    : ALTER
      (
        ALGORITHM '=' algType=(UNDEFINED | MERGE | TEMPTABLE)
      )?
      ownerStatement?
      (SQL SECURITY secContext=(DEFINER | INVOKER))?
      VIEW fullId ('(' uidList ')')? AS selectStatement
      (WITH checkOpt=(CASCADED | LOCAL)? CHECK OPTION)?
    ;

// details

alterDatabaseOption
    locals [level: number = 0]
    : {this.isDialect('mysql')}? UPGRADE DATA DIRECTORY NAME
    | {this.isDialect('inceptor')}? (alterDatabaseSetDbproperties | alterDatabaseSetOwner)
    ;

alterDatabaseSetDbproperties
    locals [level: number = 0]
    : SET DBPROPERTIES '(' keyValueProperties ')'
    ;

alterDatabaseSetOwner
    locals [level: number = 0]
    : SET OWNER (USER | GROUP | ROLE) uid
    ;

alterDatabaseAnchor
    : placeholder
    ;

alterTableAction
    : {this.isDialect('mysql')}? intimeAction=(ONLINE | OFFLINE)? IGNORE? TABLE
    | {this.isDialect('inceptor')}? TABLE
    ;

alterSpecification
    locals [level: number = 0]
    : {this.isDialect('mysql')}? alterSpecificationMysql
    | {this.isDialect('inceptor')}? alterSpecificationInceptor
    ;

alterSpecificationMysql
    : (alterSpecificationMysqlItem (',' alterSpecificationMysqlItem)*)?
      partitionDefinitions?
    ;

alterSpecificationMysqlItem
    : tableOption (','? tableOption)*                               #alterByTableOption
    | ADD COLUMN? uid columnDefinition (FIRST | AFTER uid)?         #alterByAddColumn
    | ADD COLUMN?
        '('
          uid columnDefinition ( ',' uid columnDefinition)*
        ')'                                                         #alterByAddColumns
    | ADD indexFormat=(INDEX | KEY) uid? indexType?
      indexColumnNames indexOption*                                 #alterByAddIndex
    | ADD (CONSTRAINT name=uid?)? PRIMARY KEY
      indexType? indexColumnNames indexOption*                      #alterByAddPrimaryKey
    | ADD (CONSTRAINT name=uid?)? UNIQUE
      indexFormat=(INDEX | KEY)? indexName=uid?
      indexType? indexColumnNames indexOption*                      #alterByAddUniqueKey
    | ADD keyType=(FULLTEXT | SPATIAL)
      indexFormat=(INDEX | KEY)? uid?
      indexColumnNames indexOption*                                 #alterByAddSpecialIndex
    | ADD (CONSTRAINT name=uid?)? FOREIGN KEY
      indexName=uid? indexColumnNames referenceDefinition           #alterByAddForeignKey
    | ADD (CONSTRAINT name=uid?)? CHECK '(' expression ')'          #alterByAddCheckTableConstraint
    | ALGORITHM '='? algType=(DEFAULT | INPLACE | COPY)             #alterBySetAlgorithm
    | ALTER COLUMN? uid
      (SET DEFAULT defaultValue | DROP DEFAULT)                     #alterByChangeDefault
    | CHANGE COLUMN? oldColumn=uid
      newColumn=uid columnDefinition
      (FIRST | AFTER afterColumn=uid)?                              #alterByChangeColumn
    | RENAME COLUMN oldColumn=uid TO newColumn=uid                  #alterByRenameColumn
    | LOCK '='? lockType=(DEFAULT | NONE | SHARED | EXCLUSIVE)      #alterByLock
    | MODIFY COLUMN?
      uid columnDefinition (FIRST | AFTER uid)?                     #alterByModifyColumn
    | DROP COLUMN? uid RESTRICT?                                    #alterByDropColumn
    | DROP PRIMARY KEY                                              #alterByDropPrimaryKey
    | DROP indexFormat=(INDEX | KEY) uid                            #alterByDropIndex
    | DROP FOREIGN KEY uid                                          #alterByDropForeignKey
    | DISABLE KEYS                                                  #alterByDisableKeys
    | ENABLE KEYS                                                   #alterByEnableKeys
    | RENAME renameFormat=(TO | AS)? (uid | fullId)                 #alterByRename
    | ORDER BY uidList                                              #alterByOrder
    | CONVERT TO CHARACTER SET charsetName
      (COLLATE collationName)?                                      #alterByConvertCharset
    | DEFAULT? CHARACTER SET '=' charsetName
      (COLLATE '=' collationName)?                                  #alterByDefaultCharset
    | DISCARD TABLESPACE                                            #alterByDiscardTablespace
    | IMPORT TABLESPACE                                             #alterByImportTablespace
    | FORCE                                                         #alterByForce
    | validationFormat=(WITHOUT | WITH) VALIDATION                  #alterByValidate
    | ADD PARTITION
        '('
          partitionDefinition (',' partitionDefinition)*
        ')'                                                         #alterByAddPartition
    | DROP PARTITION uidList                                        #alterByDropPartition
    | DISCARD PARTITION (uidList | ALL) TABLESPACE                  #alterByDiscardPartition
    | IMPORT PARTITION (uidList | ALL) TABLESPACE                   #alterByImportPartition
    | TRUNCATE PARTITION (uidList | ALL)                            #alterByTruncatePartition
    | COALESCE PARTITION decimalLiteral                             #alterByCoalescePartition
    | REORGANIZE PARTITION uidList
        INTO '('
          partitionDefinition (',' partitionDefinition)*
        ')'                                                         #alterByReorganizePartition
    | EXCHANGE PARTITION uid WITH TABLE tableName
      (validationFormat=(WITH | WITHOUT) VALIDATION)?               #alterByExchangePartition
    | ANALYZE PARTITION (uidList | ALL)                             #alterByAnalyzePartition
    | CHECK PARTITION (uidList | ALL)                               #alterByCheckPartition
    | OPTIMIZE PARTITION (uidList | ALL)                            #alterByOptimizePartition
    | REBUILD PARTITION (uidList | ALL)                             #alterByRebuildPartition
    | REPAIR PARTITION (uidList | ALL)                              #alterByRepairPartition
    | REMOVE PARTITIONING                                           #alterByRemovePartitioning
    | UPGRADE PARTITIONING                                          #alterByUpgradePartitioning
    ;

alterSpecificationInceptor
    locals [newlineTokens: Array<string> = ['OVERWRITE', 'REJECT', 'LIMIT']]
    : RENAME TO tableName                                           #alterByRenameTable
    | SET (TBLPROPERTIES '(' keyValueProperties ')'
        | SERDEPROPERTIES '(' keyValueProperties ')'
      )                                                             #alterBySetTbproperties
    | UNSET TBLPROPERTIES ifExists? '(' uidList ')'                 #alterByUnSetTbproperties
    | setLocationDefinition                                         #alterBySetLocation
    | SET ERRORS LOG (ON | OFF)? intoTable
      (OVERWRITE (ON | OFF))? (REJECT (ON | OFF))?
      (LIMIT constant (ROWS | PERCENT))?                            #alterByErrorLog
    | alterSpecificationColumn                                      #alterByColumn
    | alterSpecificationPartition                                   #alterByPartition
    | alterSpecificationSkewed                                      #alterBySkewed
    | alterSpecificationConstraint                                  #alterByAddConstraint
    | alterSpecificationAnchor
      {
        this.notifyPlaceholderError($alterSpecificationAnchor.ctx, 'Please provide alter specification')
      }                                                             #alterByPlaceholer
    ;

intoTable:
    INTO tableName
    ;

alterSpecificationAnchor
    : placeholder
    ;

alterSpecificationColumn
    : (ADD | REPLACE) COLUMNS createDefinitions restrictOrCascade?  #alterSpecificationColumnAdd
    | DELETE COLUMNS '(' uidList ')' restrictOrCascade?             #alterSpecificationColumnDelete
    | CHANGE COLUMN column=uid createColumnDeclaration?
     {
       this.checkContextExist($createColumnDeclaration.ctx, 'Please define change to column');
     }
     ((FIRST | LAST) uid)? restrictOrCascade?                       #alterSpecificationColumnRename
    ;

alterSpecificationPartition
    : ADD ifNotExists? (
        partitionPlus+
        | rangePartition+
      )                                                             #alterSpecificationPartitionAdd
    | DROP ifExists? PARTITION (
        uidList
        | '(' dropPartitionAtom (',' dropPartitionAtom)* ')'
      ) (IGNORE PROTECTION)? PURGE?                                 #alterSpecificationPartitionDrop
    | (TOUCH | ARCHIVE | UNARCHIVE) partitionSpec*                  #alterSpecificationPartitionArchive
    | EXCHANGE partitionSpec WITH TABLE tableName                   #alterSpecificationPartitionExchange
    | PARTITION COLUMN '(' createDefinition ')'                     #alterSpecificationPartitionColumn
    // TODO: partitionSpec?是个不准确的写法。这是从inceptorOracle挪过来的。
    //   这个语法规则既包含了table和partition的alter所以写成了partitionSpec?
    | partitionSpec? alterTablePartitionOption                      #alterSpecificationPartitionOptions
    ;

alterTablePartitionOption
    : SET FILEFORMAT fileFormat
    | setLocationDefinition
    | (ENABLE | DISABLE)
      (OFFLINE | (NO_DROP CASCADE?) | READONLY)
    | CONCATENATE
    | setSerde
    | SET SERDEPROPERTIES keyOrValueProperties
    | RENAME TO partitionSpec
    | intoBuckets
    | NOT (CLUSTERED | SORTED)
    | tableBuckets
    | (
      COMPACT stringLiteral (AND WAIT)?
      | ENABLE COMPACT
      | DISABLE COMPACT (FOR stringLiteral)?)
    | UPDATE STATISTICS FOR COLUMNS? column=uid
      SET '(' keyOrValueProperties ')' commentClause?
    ;

alterSpecificationSkewed
    : tableSkewed
    | NOT SKEWED
    | NOT STORED AS DIRECTORIES
    ;

alterSpecificationConstraint
    : ADD (CONSTRAINT uid)? FOREIGN KEY '(' columns=uidList ')'?
      foreignKeyReferences? constraintOpts
      {
        this.checkContextExist($foreignKeyReferences.ctx, 'Please define foreign key');
      }                                                             #alterSpecificationConstraintForeignKey
    | ADD (CONSTRAINT uid)? PRIMARY KEY '(' uidList ')'
      constraintOpts                                                #alterSpecificationConstraintPrimaryKey
    | DROP CONSTRAINT uid                                           #alterSpecificationConstraintDrop
    ;

foreignKeyReferences
    : REFERENCES tableName ('(' refs=uidList ')')?
      {
        this.checkContextExist($uidList.ctx, 'Please define reference colunm');
      }
    ;

restrictOrCascade
    : RESTRICT | CASCADE
    ;

//    Drop statements

dropDatabase
    : {this.isDialect('mysql')}? DROP dbFormat=(DATABASE | SCHEMA)
      ifExists? databaseName
    | {this.isDialect('inceptor')}? DROP dbFormat=(DATABASE | SCHEMA)
      ifExists? databaseName restrictOrCascade?
    ;

dropEvent
    : DROP EVENT ifExists? fullId
    ;

dropIndex
    : DROP INDEX intimeAction=(ONLINE | OFFLINE)?
      uid ON tableName
      (
        ALGORITHM '='? algType=(DEFAULT | INPLACE | COPY)
      )?
      (
        LOCK '='? lockType=(DEFAULT | NONE | SHARED | EXCLUSIVE)
      )?
    ;

dropLogfileGroup
    : DROP LOGFILE GROUP uid ENGINE '=' engineName
    ;

dropProcedure
    : DROP PROCEDURE ifExists? procName
    ;

dropFunction
    : DROP functionType? FUNCTION ifExists? funcName
    ;

dropServer
    : DROP SERVER ifExists? uid
    ;

dropTable
    : {this.isDialect('mysql')}? DROP TEMPORARY? TABLE ifExists?
      tables dropType=restrictOrCascade?
    | {this.isDialect('inceptor')}? DROP TEMPORARY? TABLE ifExists?
      tableName PURGE?
    ;

dropTablespace
    : DROP TABLESPACE uid (ENGINE '='? engineName)?
    ;

dropTrigger
    : DROP TRIGGER ifExists? fullId
    ;

dropView
    : {this.isDialect('mysql')}? DROP VIEW ifExists?
      viewName (',' viewName)* dropType=restrictOrCascade?
    | {this.isDialect('inceptor')}? DROP VIEW ifExists?
      viewName
    ;

functionType
    : {this.isDialect('inceptor')}? (TEMPORARY | PERMANENT)
    ;

//    Other DDL statements

renameTable
    locals [level: number = 0]
    : RENAME TABLE renameTableClause (',' renameTableClause)*
    ;

renameTableClause
    : tableName TO? tableName
    {
      // TO -> TO? Error-Tolerant
      this.checkTokenExist($TO, 'Please provide keyword TO between table');
    }
    ;

truncateTable
    : {this.isDialect('inceptor')}? TRUNCATE TABLE tableName partitionSpec?
    | {this.isDialect('mysql')}? TRUNCATE TABLE? tableName
    ;

// Data Manipulation Language

//    Primary DML Statements


callStatement
    : CALL fullId
      (
        '(' (constants | expressions)? ')'
      )?
    ;

deleteStatement
    : {this.isDialect('mysql')}? (singleDeleteStatement | multipleDeleteStatement)
    | {this.isDialect('inceptor')}? deleteStatementInceptor
    ;

doStatement
    : DO expressions
    ;

handlerStatement
    : handlerOpenStatement
    | handlerReadIndexStatement
    | handlerReadStatement
    | handlerCloseStatement
    ;

insertStatement
    : INSERT insertAction
      tableName
      insertPartitionSpec?
      (
        ('(' columns=columnUids ')')? insertStatementValue
        | setUpdatedElements
      )
      insertOnDuplicate?
    ;

fromInsertStatement
    : FROM tableSources fromInsertStatementInsert+
    ;

fromInsertStatementInsert
    : INSERT insertAction tableName
      (partitionSpec ifNotExists)? fromInsertStatementSelect?
      {
        this.checkContextExist($fromInsertStatementSelect.ctx, 'Please provide select statement');
      }
    | insertTypeAnchor
      {
        this.notifyPlaceholderError($insertTypeAnchor.ctx, 'Please provide insert statement')
      }
    ;

// NOTE: 转给FROM ... INSERT用，并且并未在inceptor的语法文件中找到确切的语法定义。
fromInsertStatementSelect
    locals [level: number = 0]
    : SELECT selectSpec? selectElements whereExpressionOptional?
      hierarchyClause? groupByClause? havingClause? orderByClause?
      clusterByClause? distributeByClause? sortByClause? limitClause?
    ;

insertTypeAnchor
    : placeholder
    ;

insertFile
    : INSERT OVERWRITE
      (
        DIRECTORY
        | LOCAL DIRECTORY
      )
      filename=stringLiteral
      rowFormatDelimited? fileStore?
      selectStatement
    ;

loadDataStatement
    : {this.isDialect('mysql')}? loadDataMysql
    | {this.isDialect('inceptor')}? loadDataInceptor
    ;

loadDataMysql
    locals [
      newlineTokens: Array<string> = ['INTO', 'PARTITION', 'CHARACTER', 'FIELDS', 'COLUMNS', 'LINES']
    ]
    : LOAD DATA
      priority=(LOW_PRIORITY | CONCURRENT)?
      LOCAL? INFILE filename=STRING_LITERAL
      violation=(REPLACE | IGNORE)?
      INTO TABLE tableName
      (PARTITION '(' uidList ')' )?
      (CHARACTER SET charset=charsetName)?
      (
        fieldsFormat=(FIELDS | COLUMNS)
        selectFieldsInto+
      )?
      (
        LINES
          selectLinesInto+
      )?
      (
        IGNORE decimalLiteral linesFormat=(LINES | ROWS)
      )?
      ( '(' assignmentField (',' assignmentField)* ')' )?
      setUpdatedElements?
    ;

loadDataInceptor
    : LOAD DATA LOCAL? INPATH path=stringLiteral
      loadDataInceptorTable
      partitionSpec? ('(' uidList ')')?
    ;

loadDataInceptorTable
    locals [level: number = 0]
    : (
        OVERWRITE? INTO TABLE
        | loadDataInceptorAnchor
      )
      tableName
    ;

loadDataInceptorAnchor
    : placeholder
      {
        this.notifyErrorListeners('Please provide load table')
      }
    ;

loadXmlStatement
    : LOAD XML
      priority=(LOW_PRIORITY | CONCURRENT)?
      LOCAL? INFILE filename=STRING_LITERAL
      violation=(REPLACE | IGNORE)?
      INTO TABLE tableName
      (CHARACTER SET charset=charsetName)?
      (ROWS IDENTIFIED BY '<' tag=STRING_LITERAL '>')?
      ( IGNORE decimalLiteral linesFormat=(LINES | ROWS) )?
      ( '(' assignmentField (',' assignmentField)* ')' )?
      (SET updatedElement (',' updatedElement)*)?
    ;

mergeStatement
    : {this.isDialect('inceptor')}? MERGE INTO crudTargetClause
      mergeUsingClause? mergeUpdateClause? mergeInsertClause?
      {
        this.checkContextExist($mergeUsingClause.ctx, 'Please provide USING clause');
      }
    ;

replaceStatement
    : REPLACE priority=(LOW_PRIORITY | DELAYED)?
      INTO? tableName
      (PARTITION '(' partitions=uidList ')' )?
      (
        ('(' columns=uidList ')')? insertStatementValue
        | SET
          setFirst=updatedElement
          (',' setElements+=updatedElement)*
      )
    ;

selectStatement
    locals [level: number = 0]
    : querySpecification lockClause?                                #simpleSelect
    | queryExpression lockClause?                                   #parenthesisSelect
    | querySpecificationNointo unionStatement+
        (
          UNION unionType=(ALL | DISTINCT)?
          (querySpecification | queryExpression)
        )?
        orderByClause? limitClause? lockClause?                     #unionSelect
    | queryExpressionNointo unionParenthesis+
        (
          UNION unionType=(ALL | DISTINCT)?
          queryExpression
        )?
        orderByClause? limitClause? lockClause?                     #unionParenthesisSelect
    ;

updateStatement
    : {this.isDialect('mysql')}? (singleUpdateStatement | multipleUpdateStatement)
    | {this.isDialect('inceptor')}? updateStatementInceptor
    ;

withStatement
    locals [level: number = 0]
    : {this.isDialect('inceptor')}?
    WITH withCommonTableExpression (',' withCommonTableExpression)* selectStatement?
    {
      // selectStatement -> selectStatement? Error-Tolerant
      this.checkContextExist($selectStatement.ctx, 'Please provide select statement');
    }
    ;

withCommonTableExpression
    : uid AS queryExpression
    ;

// details

insertPartitionSpec
    locals [level: number = 1]
    : {this.isDialect('mysql')}? PARTITION '(' partitions=uidList ')'
    | {this.isDialect('inceptor')}? partitionSpec
    ;

insertOnDuplicate
    locals [level: number = 0]
    : ON DUPLICATE KEY UPDATE
      duplicatedFirst=updatedElement
        (',' duplicatedElements+=updatedElement)*
    ;

// 用于hive，inceptor
rowFormatDelimited
    locals [level: number = 1]
    : ROW FORMAT DELIMITED rowFormatDelimitedTail
    ;

rowFormatDelimitedTail
    : (FIELDS TERMINATED BY stringLiteral (ESCAPED BY stringLiteral)?)?
      (COLLECTION ITEMS TERMINATED BY stringLiteral)?
      (MAP KEYS TERMINATED BY stringLiteral)? (LINES TERMINATED BY stringLiteral)?
    ;

rowFormatSerde
    locals [level: number = 1]
    : ROW FORMAT SERDE rowFormatSerdeTail
    ;

rowFormatSerdeTail
    : stringLiteral (WITH SERDEPROPERTIES '(' keyValueProperties ')')?
    ;

rowFormat
    locals [level: number = 1]
    // NOTE: 需要提取ROW FORMAT关键词前缀，不然在输入ROW之后只会提示FORMAT DELIMITED
    : ROW FORMAT
      (
        // 独立的DELIMITED使得c3能正确提示后续的关键词
        DELIMITED
        | DELIMITED rowFormatDelimitedTail
        | SERDE rowFormatSerdeTail
      )
    ;

fileStore
    locals [level: number = 1]
    : STORED AS fileFormat
    ;

fileFormat
    : fileFormatEnum
    | STARGATE ('(' uid ')')?
    | INPUTFORMAT inFmt=stringLiteral OUTPUTFORMAT outFmt=stringLiteral
      (INPUTDRIVER inDriver=stringLiteral OUTPUTDRIVER outDriver=stringLiteral)?
    | HOLODESK (holoProps | holoTableSize)?
    | uid
    ;

fileFormatEnum
    : CSVFILE | ES | FWCFILE | HYPERDRIVE | ORC | ORC_TRANSACTION
      | PARQUET | RCFILE | SEQUENCEFILE | STELLARDB | TEXTFILE
    ;

fileStoreBy
    locals [level: number = 1]
    : STORED BY stringLiteral (WITH SERDEPROPERTIES '(' keyValueProperties ')')?
    ;

insertAction
    : {this.isDialect('mysql')}? priority=(LOW_PRIORITY | DELAYED | HIGH_PRIORITY)?
      IGNORE? INTO?
    | {this.isDialect('inceptor')}?
      (INTO | OVERWRITE) TABLE?
    ;

insertStatementValue
    locals [level:number = 0]
    // 使用querySpecification，因为insert后使用括号包裹的select语句会报语法错误。而且也似乎不支持UNION等需要括号的复杂select语句
    : querySpecification
    | withStatement
    | insertValueClause
    | emptyElement {this.notifyErrorListeners('Please provide insert statement');}
    | (VALUES | VALUE) {this.notifyErrorListeners('Please provide insert value');}
    ;

insertValueClause
    locals [level:number = 1]
    : insertFormat=(VALUES | VALUE)
      '(' expressionsWithDefaults ')'
      (',' '(' expressionsWithDefaults ')')*
    ;

updatedElement
    : fullColumnNameOptional '=' (expression | DEFAULT)
    | fullColumnNameOptional {this.notifyErrorListeners('Please provide updated statement `= updated expression`');}
    ;

assignmentField
    : uid | LOCAL_ID
    | emptyElement
      {
        this.notifyErrorListeners('Please provide variable');
      }
    ;

mergeUsingClause
    locals [level: number = 1]
    : USING tableSourceItem ON ('(' expression ')' | expression)
    ;

mergeUpdateClause
    locals [level: number = 1]
    : WHEN MATCHED THEN UPDATE SET
      updateAssignClauseElement (',' updateAssignClauseElement)*
      DELETE? (WHERE expression)?
    ;

mergeInsertClause
    locals [level: number = 1]
    : WHEN NOT MATCHED THEN INSERT ('(' uidList ')')?
      insertValueClause (WHERE expression)?
    ;

lockClause
    : FOR UPDATE | LOCK IN SHARE MODE
    ;

//    Detailed DML Statements

singleDeleteStatement
    : DELETE priority=LOW_PRIORITY? QUICK? IGNORE?
    FROM tableName
      (PARTITION '(' uidList ')' )?
      (WHERE expression)?
      orderByClause? (LIMIT decimalLiteral)?
    ;

multipleDeleteStatement
    : DELETE priority=LOW_PRIORITY? QUICK? IGNORE?
      (
        tableName ('.' '*')? ( ',' tableName ('.' '*')? )*
            FROM tableSources
        | FROM
            tableName ('.' '*')? ( ',' tableName ('.' '*')? )*
            USING tableSources
      )
      (WHERE expression)?
    ;

handlerOpenStatement
    : HANDLER tableName OPEN (AS? uid)?
    ;

handlerReadIndexStatement
    : HANDLER tableName READ index=uid
      (
        comparisonOperator '(' constants ')'
        | moveOrder=(FIRST | NEXT | PREV | LAST)
      )
      (WHERE expression)? (LIMIT decimalLiteral)?
    ;

handlerReadStatement
    : HANDLER tableName READ moveOrder=(FIRST | NEXT)
      (WHERE expression)? (LIMIT decimalLiteral)?
    ;

handlerCloseStatement
    : HANDLER tableName CLOSE
    ;

singleUpdateStatement
    : UPDATE priority=LOW_PRIORITY? IGNORE? tableName baseElementAlias?
      setUpdatedElements?
      {
        // setUpdatedElements -> setUpdatedElements? Error-Tolerant
        this.checkContextExist($setUpdatedElements.ctx, 'Please provide set statement');
      }
      whereExpressionOptional? orderByClause? limitClause?
    ;

multipleUpdateStatement
    : UPDATE priority=LOW_PRIORITY? IGNORE? tableSources
      setUpdatedElements?
      {
        // setUpdatedElements -> setUpdatedElements? Error-Tolerant
        this.checkContextExist($setUpdatedElements.ctx, 'Please provide set statement');
      }
      whereExpressionOptional?
    ;

setUpdatedElements
    locals [level: number = 0]
    : SET updatedElement (',' updatedElement)*
    ;

updateStatementInceptor
    locals [newlineTokens: Array<string> = ['SET']]
    : UPDATE crudTargetClause (SET updateAssignClause)?
      {
        // (SET ...) -> (SET ...)? Error-Tolerant
        this.checkContextExist($updateAssignClause.ctx, 'Please provide set statement');
      }
    ;

crudTargetClause
    : TABLE? tableName partitionSpec? baseElementAlias?             #crudTargetTable
    | '(' selectStatement ')' baseElementAlias?                     #crudTargetSubquery
    ;

updateAssignClause
    : '(' columnNames ')' '=' '(' selectStatement ')' whereExpressionOptional?
    | updateAssignClauseElement (',' updateAssignClauseElement)* whereExpressionOptional?
    ;

updateAssignClauseElement
    : fullColumnName OP='='? expression?
      {
        this.checkContextExist($expression.ctx, 'Please provide updated expression');
        this.checkTokenExist($OP, 'Please provide updated expression');
      }
    ;

deleteStatementInceptor
    : DELETE FROM? crudTargetClause whereExpressionOptional?
    ;

// details

orderByClause
    locals [level: number = 0]
    : ORDER BY orderByExpression (',' orderByExpression)*
    ;

orderByExpression
    : {this.isDialect('mysql')}? expressionOptional order=(ASC | DESC)?
    | {this.isDialect('inceptor')}? expressionOptional order=(ASC | DESC)? nullsOrder?
    ;

nullsOrder
    : NULLS (FIRST | LAST)
    ;

clusterByClause
    locals [level: number = 0]
    : {this.isDialect('inceptor')}?
      CLUSTER BY expressionOptional (',' expressionOptional) *
    ;

distributeByClause
    locals [level: number = 0]
    : {this.isDialect('inceptor')}?
      DISTRIBUTE BY expressionOptional (',' expressionOptional) *
    ;

sortByClause
    locals [level: number = 0]
    : {this.isDialect('inceptor')}?
      SORT BY orderByExpression (',' orderByExpression) *
    ;

tableSources
    : tableSource (',' tableSource)*
    ;

tableSource
    : tableSourceItem joinPart* lateralView*                        #tableSourceBase
    | '(' tableSourceItem joinPart* lateralView* ')'                #tableSourceNested
    ;

// 因为subquery和tableName都可以带alias，存在二义性问题
// 建议所有subquery都用括号包括起来
// 但根据mysql文档显示, derived table需要用括号包起来
// NOTE: 这里不直接使用baseElementAlias?是因为此写法和后面的joinPart存在二义性问题，使得后面规则的LEFT关键词误认为是alias。
//  而这样定义两份atomTableItem能work因为antlr的parse顺序而定，导致LEFT被优先认作是alias而且语法成立。
tableSourceItem
    : tableName
      (PARTITION '(' uidList ')' )?
      tableSourceItemIndex?                                         #atomTableItem
    | tableName
      (PARTITION '(' uidList ')' )? baseElementAlias
      tableSourceItemIndex?                                         #atomTableItem
    | (
        selectStatementPlus
        | '(' parenthesisSubquery=selectStatementPlus ')'
      )
      {
        // inceptor allow alias not to be defined
        if (this.isDialect('mysql')) {
          this.notifyErrorListeners('Please provide subquery an alias');
        }
      }                                                             #subqueryTableItem
    | (
        selectStatementPlus
        | '(' parenthesisSubquery=selectStatementPlus ')'
      )
      baseElementAlias                                              #subqueryTableItem
    | '(' tableSources ')'                                          #tableSourcesItem
    | {this.isDialect('inceptor')}? ('(' VALUES
        valuesSourceExprs (',' valuesSourceExprs)*
      ')')
      baseElementAlias? ('(' uidList ')')?
      {
        if ($uidList.ctx) {
          this.checkContextExist($baseElementAlias.ctx, 'Please provide alias');
        }
      }                                                             #valuesSourceTableItem
    ;

tableSourceItemIndex
    : {this.isDialect('mysql')}? (indexHint (',' indexHint)* )
    ;

fromClauseSuggester
    : tableName
    ;

selectStatementPlus
    : selectStatement
    | {this.isDialect('inceptor')}? withStatement
    ;

valuesSourceExprs
    : '(' expression (',' expression)* ')'
    ;

indexHint
    : indexHintAction=(USE | IGNORE | FORCE)
      keyFormat=(INDEX|KEY) ( FOR indexHintType)?
      '(' uidList ')'
    ;

indexHintType
    : JOIN | ORDER BY | GROUP BY
    ;

joinPart
    locals [level: number = 0]
    : joinOuterType OUTER? JOIN tableSourceItem joinCondition?
      {
        // TODO: select * from db.table LEFT JOIN xxx. LEFT will be treated as table alias.
        if (this.isDialect('mysql')) {
          this.checkContextExist($joinCondition.ctx, 'Please provide join condition');
        }
      }                                                             #outerJoin
    | NATURAL joinNaturalSubType? JOIN tableSourceItem              #naturalJoin
    | {this.isDialect('mysql')}? STRAIGHT_JOIN tableSourceItem
      (ON expression)?                                              #straightJoin
    | {this.isDialect('inceptor')}? LEFT SEMI2 JOIN
      tableSourceItem joinCondition?                                #leftSemiJoin
    | (INNER | CROSS)? JOIN tableSourceItem joinCondition?          #innerJoin
    | joinTypeAnchor tableSourceItem joinCondition?
      {
        this.notifyPlaceholderError($joinTypeAnchor.ctx, 'Please provide join type')
      }                                                             #placeholderJoin
    ;

joinTypeAnchor
    : placeholder
    ;

joinOuterType
    : {this.isDialect('mysql')}? LEFT | RIGHT
    | {this.isDialect('inceptor')}? LEFT | RIGHT | FULL
    ;

joinNaturalSubType
    : {this.isDialect('mysql')}? (LEFT | RIGHT) OUTER?
    ;

joinCondition
    : ON expressionOptional
    | {this.isDialect('mysql')}? USING '(' uidList ')'
    ;

lateralView
    : LATERAL VIEW OUTER? functionCall uid? (AS uidList)?
      {
        this.checkContextExist($uid.ctx, 'Please provide alias');
      }
    ;

//    Select Statement's Details

queryExpression
    : '(' querySpecification ')'
    | '(' queryExpression ')'
    ;

queryExpressionNointo
    : '(' querySpecificationNointo ')'
    | '(' queryExpressionNointo ')'
    ;

querySpecification
    locals [level: number = 0]
    : SELECT selectSpec? fromClauseSuggester
    | SELECT selectSpec? selectElements selectIntoExpression?
      fromClause? orderByClause? clusterByClause? distributeByClause? sortByClause? limitClause?
    | SELECT selectSpec? selectElements
      fromClause? orderByClause? clusterByClause? distributeByClause? sortByClause? limitClause? selectIntoExpression?
    ;

querySpecificationNointo
    locals [level: number = 0]
    : SELECT selectSpec? fromClauseSuggester
    | SELECT selectSpec? selectElements
      fromClause? orderByClause? clusterByClause?  distributeByClause? sortByClause? limitClause?
    ;

unionParenthesis
    : UNION unionType=(ALL | DISTINCT)? queryExpressionNointo
    ;

unionStatement
    : UNION unionType=(ALL | DISTINCT)?
      (querySpecificationNointo | queryExpressionNointo)
    ;

// details

selectSpec
    : {this.isDialect('mysql')}? selectSpecMysql+
    | {this.isDialect('inceptor')}? selectSpecInceptor
    ;

selectSpecMysql
    : (ALL | DISTINCT | DISTINCTROW)
    | HIGH_PRIORITY | STRAIGHT_JOIN | SQL_SMALL_RESULT
    | SQL_BIG_RESULT | SQL_BUFFER_RESULT
    | (SQL_CACHE | SQL_NO_CACHE)
    | SQL_CALC_FOUND_ROWS
    ;

selectSpecInceptor
    : ALL | DISTINCT
    ;

selectElements
    : (star='*' | selectElement ) (',' selectElement)*
    ;

selectElement
    : fullId '.' '*'                                                #selectStarElement
    | funcColumnNameOptional baseElementAlias?                      #selectColumnElement
    | functionCall baseElementAlias?                                #selectFunctionElement
    | expression baseElementAlias?                                  #selectExpressionElement
    | {this.isDialect('mysql')}? (LOCAL_ID VAR_ASSIGN)?
      expression baseElementAlias?                                  #selectExpressionElement
    ;

selectIntoExpression
    : INTO assignmentField (',' assignmentField )*                  #selectIntoVariables
    | {this.isDialect('inceptor')}? (BULK COLLECT)? INTO
      expressions                                                   #selectIntoExprs
    | {this.isDialect('mysql')}? INTO DUMPFILE STRING_LITERAL       #selectIntoDumpFile
    | {this.isDialect('mysql')}? (
        INTO OUTFILE filename=STRING_LITERAL
        (CHARACTER SET charset=charsetName)?
        (
          fieldsFormat=(FIELDS | COLUMNS)
          selectFieldsInto+
        )?
        (
          LINES selectLinesInto+
        )?
      )                                                             #selectIntoTextFile
    ;

selectFieldsInto
    : TERMINATED BY terminationField=STRING_LITERAL
    | OPTIONALLY? ENCLOSED BY enclosion=STRING_LITERAL
    | ESCAPED BY escaping=STRING_LITERAL
    ;

selectLinesInto
    : STARTING BY starting=STRING_LITERAL
    | TERMINATED BY terminationLine=STRING_LITERAL
    ;

fromClause
    locals [level: number = 0]
    : FROM tableSources
      whereExpressionOptional?
      hierarchyClause?
      groupByClause?
      havingClause?
    ;

groupByClause
    locals [level: number = 0]
    : GROUP BY groupByItems
    ;

havingClause
    locals [level: number = 0]
    : HAVING expressionOptional
    ;

whereExpressionOptional
    locals [level: number = 0]
    : WHERE expressionOptional
    ;

hierarchyClause
    locals [level: number = 0]
    : {this.isDialect('inceptor')}? (START WITH startExpr=expressionOptional)?
      CONNECT BY NOCYCLE? connectExpr=expressionOptional
    ;

groupByItems
    : {this.isDialect('mysql')}? groupByItem (',' groupByItem)*
        (WITH ROLLUP)?
    | {this.isDialect('inceptor')}? (
        (ROLLUP | CUBE | GROUPING SETS) '('groupByItem (',' groupByItem)* ')'
        | groupByItem (',' groupByItem)*
      )
    ;

groupByItem
    : expressionOptional order=(ASC | DESC)?
    ;

limitClause
    locals [level: number = 0]
    : {this.isDialect('mysql')}? limitClauseMysql
    | {this.isDialect('inceptor')}? limitClauseInceptor
    ;

limitClauseMysql
    : LIMIT
    (
      (offset=limitClauseAtom ',')? limit=limitClauseAtom
      | limit=limitClauseAtom OFFSET offset=limitClauseAtom
    )
    ;

limitClauseAtom
    : decimalLiteral | mysqlVariable
    ;

limitClauseInceptor
    : LIMIT (decimalLiteral ',')? decimalLiteral
    | FETCH FIRST decimalLiteral ROWS ONLY
    | (OFFSET decimalLiteral ROWS)? FETCH NEXT decimalLiteral ROWS ONLY
    ;


// Transaction's Statements

startTransaction
    : START TRANSACTION (transactionMode (',' transactionMode)* )?
    ;

beginWork
    : BEGIN WORK?
    ;

commitWork
    : COMMIT WORK?
      (AND nochain=NO? CHAIN)?
      (norelease=NO? RELEASE)?
    ;

rollbackWork
    : ROLLBACK WORK?
      (AND nochain=NO? CHAIN)?
      (norelease=NO? RELEASE)?
    ;

savepointStatement
    : SAVEPOINT uid
    ;

rollbackStatement
    : ROLLBACK WORK? TO SAVEPOINT? uid
    ;

releaseStatement
    : RELEASE SAVEPOINT uid
    ;

lockTables
    : LOCK TABLES lockTableElement (',' lockTableElement)*
    ;

unlockTables
    : UNLOCK TABLES
    ;

// Inceptor transaction

transactionStatementInceptor
    : (BEGIN | START) (TRANSACTION | WORK)
    | COMMIT WORK?
    | ROLLBACK WORK?
    ;

// details

setAutocommitStatement
    : SET AUTOCOMMIT '=' autocommitValue=('0' | '1')
    ;

setTransactionStatement
    : {this.isDialect('mysql')}? setTransactionStatementMysql
    | {this.isDialect('inceptor')}? setTransactionStatementInceptor
    ;

setTransactionStatementInceptor
    : SET TRANSACTION READ (ONLY | WRITE)
    | SET TRANSACTION ISOLATION LEVEL (
      (READ COMMITTED) | SERIALIZABLE
    )
    ;

setTransactionStatementMysql
    : SET transactionContext=(GLOBAL | SESSION)? TRANSACTION
      transactionOption (',' transactionOption)*
    ;

transactionMode
    : WITH CONSISTENT SNAPSHOT
    | READ WRITE
    | READ ONLY
    ;

lockTableElement
    : tableName (AS? uid)? lockAction
    ;

lockAction
    : READ LOCAL? | LOW_PRIORITY? WRITE
    ;

transactionOption
    : ISOLATION LEVEL transactionLevel
    | READ WRITE
    | READ ONLY
    ;

transactionLevel
    : REPEATABLE READ
    | READ COMMITTED
    | READ UNCOMMITTED
    | SERIALIZABLE
    ;


// Replication's Statements

//    Base Replication

changeMaster
    : CHANGE MASTER TO
      masterOption (',' masterOption)* channelOption?
    ;

changeReplicationFilter
    : CHANGE REPLICATION FILTER
      replicationFilter (',' replicationFilter)*
    ;

purgeBinaryLogs
    : PURGE purgeFormat=(BINARY | MASTER) LOGS
       (
           TO fileName=STRING_LITERAL
           | BEFORE timeValue=STRING_LITERAL
       )
    ;

resetMaster
    : RESET MASTER
    ;

resetSlave
    : RESET SLAVE ALL? channelOption?
    ;

startSlave
    : START SLAVE (threadType (',' threadType)*)?
      (UNTIL untilOption)?
      connectionOption* channelOption?
    ;

stopSlave
    : STOP SLAVE (threadType (',' threadType)*)?
    ;

startGroupReplication
    : START GROUP_REPLICATION
    ;

stopGroupReplication
    : STOP GROUP_REPLICATION
    ;

// details

masterOption
    : stringMasterOption '=' STRING_LITERAL                         #masterStringOption
    | decimalMasterOption '=' decimalLiteral                        #masterDecimalOption
    | boolMasterOption '=' boolVal=('0' | '1')                      #masterBoolOption
    | MASTER_HEARTBEAT_PERIOD '=' REAL_LITERAL                      #masterRealOption
    | IGNORE_SERVER_IDS '=' '(' (uid (',' uid)*)? ')'               #masterUidListOption
    ;

stringMasterOption
    : MASTER_BIND | MASTER_HOST | MASTER_USER | MASTER_PASSWORD
    | MASTER_LOG_FILE | RELAY_LOG_FILE | MASTER_SSL_CA
    | MASTER_SSL_CAPATH | MASTER_SSL_CERT | MASTER_SSL_CRL
    | MASTER_SSL_CRLPATH | MASTER_SSL_KEY | MASTER_SSL_CIPHER
    | MASTER_TLS_VERSION
    ;
decimalMasterOption
    : MASTER_PORT | MASTER_CONNECT_RETRY | MASTER_RETRY_COUNT
    | MASTER_DELAY | MASTER_LOG_POS | RELAY_LOG_POS
    ;

boolMasterOption
    : MASTER_AUTO_POSITION | MASTER_SSL
    | MASTER_SSL_VERIFY_SERVER_CERT
    ;

channelOption
    : FOR CHANNEL STRING_LITERAL
    ;

replicationFilter
    : REPLICATE_DO_DB '=' '(' uidList ')'                           #doDbReplication
    | REPLICATE_IGNORE_DB '=' '(' uidList ')'                       #ignoreDbReplication
    | REPLICATE_DO_TABLE '=' '(' tables ')'                         #doTableReplication
    | REPLICATE_IGNORE_TABLE '=' '(' tables ')'                     #ignoreTableReplication
    | REPLICATE_WILD_DO_TABLE '=' '(' simpleStrings ')'             #wildDoTableReplication
    | REPLICATE_WILD_IGNORE_TABLE
       '=' '(' simpleStrings ')'                                    #wildIgnoreTableReplication
    | REPLICATE_REWRITE_DB '='
      '(' tablePair (',' tablePair)* ')'                            #rewriteDbReplication
    ;

tablePair
    : '(' firstTable=tableName ',' secondTable=tableName ')'
    ;

threadType
    : IO_THREAD | SQL_THREAD
    ;

untilOption
    : gtids=(SQL_BEFORE_GTIDS | SQL_AFTER_GTIDS)
      '=' gtuidSet                                                  #gtidsUntilOption
    | MASTER_LOG_FILE '=' STRING_LITERAL
      ',' MASTER_LOG_POS '=' decimalLiteral                         #masterLogUntilOption
    | RELAY_LOG_FILE '=' STRING_LITERAL
      ',' RELAY_LOG_POS '=' decimalLiteral                          #relayLogUntilOption
    | SQL_AFTER_MTS_GAPS                                            #sqlGapsUntilOption
    ;

connectionOption
    : USER '=' conOptUser=STRING_LITERAL                            #userConnectionOption
    | PASSWORD '=' conOptPassword=STRING_LITERAL                    #passwordConnectionOption
    | DEFAULT_AUTH '=' conOptDefAuth=STRING_LITERAL                 #defaultAuthConnectionOption
    | PLUGIN_DIR '=' conOptPluginDir=STRING_LITERAL                 #pluginDirConnectionOption
    ;

gtuidSet
    : uuidSet (',' uuidSet)*
    | STRING_LITERAL
    ;


//    XA Transactions

xaStartTransaction
    : XA xaStart=(START | BEGIN) xid xaAction=(JOIN | RESUME)?
    ;

xaEndTransaction
    : XA END xid (SUSPEND (FOR MIGRATE)?)?
    ;

xaPrepareStatement
    : XA PREPARE xid
    ;

xaCommitWork
    : XA COMMIT xid (ONE PHASE)?
    ;

xaRollbackWork
    : XA ROLLBACK xid
    ;

xaRecoverWork
    : XA RECOVER (CONVERT xid)?
    ;


// Prepared Statements

prepareStatement
    : PREPARE uid FROM
      (query=STRING_LITERAL | variable=LOCAL_ID)
    ;

executeStatement
    : EXECUTE uid (USING userVariables)?
    ;

deallocatePrepare
    : dropFormat=(DEALLOCATE | DROP) PREPARE uid
    ;


// Compound Statements

routineBody
    : blockStatement | sqlStatement
    ;

// details

// NOTE: inceptor allow SEMI to be optional. but mysql should be must according to the original grammar
//       And it drastically slow the parse speed if we make a optional rule of SEMI because fo `warning(154)`
// TODO: make SEMI optional and check SEMI to be show for mysql.
blockStatement
    : (uid ':')? BEGIN
      (
        (declareVariable SEMI)*
        (declareCondition SEMI)*
        (declareCursor SEMI)*
        (declareHandler SEMI)*
        (declareRowDataType SEMI)*
        procedureSqlStatement*
      )
      END uid?
    ;

caseStatement
    : CASE (uid | expression)? caseAlternative+
      (ELSE procedureSqlStatement+)?
      END CASE
    ;

ifStatement
    : IF expression
      THEN thenStatements+=procedureSqlStatement+
      elifAlternative*
      (ELSE elseStatements+=procedureSqlStatement+ )?
      END IF
    ;

iterateStatement
    : ITERATE uid
    ;

leaveStatement
    : LEAVE uid
    ;

loopStatement
    : (uid ':')?
      LOOP procedureSqlStatement+
      END LOOP uid?
    ;

repeatStatement
    : (uid ':')?
      REPEAT procedureSqlStatement+
      UNTIL expression
      END REPEAT uid?
    ;

returnStatement
    : RETURN expression
    ;

whileStatement
    : (uid ':')?
      WHILE expression
      DO procedureSqlStatement+
      END WHILE uid?
    ;

cursorStatement
    : CLOSE uid                                                     #CloseCursor
    | FETCH (NEXT? FROM)? uid INTO uidList                          #FetchCursor
    | OPEN uid                                                      #OpenCursor
    ;

// details

declareVariable
    : DECLARE uidList dataType (DEFAULT defaultValue)?
    ;

declareCondition
    : DECLARE uid CONDITION FOR conditionDialectOption
    ;

declareCursor
    : DECLARE uid CURSOR cursorDialectOption
    ;

declareHandler
    : DECLARE handlerAction=(CONTINUE | EXIT | UNDO)
      HANDLER FOR
      handlerConditionValue (',' handlerConditionValue)*
      routineBody?
      {
        // routineBody -> routineBody? inceptor does not have routineBody in declareHandler
        if (this.isDialect('mysql')) {
          this.checkContextExist($routineBody.ctx, 'Please provide BEGIN ... END block after handler');
        }
      }
    ;

declareRowDataType
    : {this.isDialect('inceptor')}? DECLARE TYPE uid AS ROW '(' functionParameter (',' functionParameter)* ')'
    ;

cursorDialectOption
    : {this.isDialect('mysql')}? FOR selectStatement
    | {this.isDialect('inceptor')}? (WITH HOLD)? (WITH RETURN TO (CALLER | CLIENT)) FOR selectStatement
    ;

conditionDialectOption
    : {this.isDialect('mysql')}? ( decimalLiteral | SQLSTATE VALUE? STRING_LITERAL)
    | {this.isDialect('inceptor')}? SQLSTATE STRING_LITERAL
    ;

handlerConditionValue
    : decimalLiteral                                                #handlerConditionCode
    | SQLSTATE VALUE? STRING_LITERAL                                #handlerConditionState
    | uid                                                           #handlerConditionName
    | SQLWARNING                                                    #handlerConditionWarning
    | NOT FOUND                                                     #handlerConditionNotfound
    | SQLEXCEPTION                                                  #handlerConditionException
    ;

procedureSqlStatement
    : (compoundStatement | sqlStatement) SEMI
    ;

caseAlternative
    : WHEN (constant | expression)
      THEN procedureSqlStatement+
    ;

elifAlternative
    : ELSEIF expression
      THEN procedureSqlStatement+
    ;

// Administration Statements

//    Account management statements

alterUser
    : ALTER USER
      userSpecification (',' userSpecification)*                    #alterUserMysqlV56
    | ALTER USER ifExists?
        userAuthOption (',' userAuthOption)*
        (
          REQUIRE
          (tlsNone=NONE | tlsOption (AND? tlsOption)* )
        )?
        (WITH userResourceOption+)?
        (userPasswordOption | userLockOption)*                      #alterUserMysqlV57
    ;

createUser
    : CREATE USER userAuthOption (',' userAuthOption)*              #createUserMysqlV56
    | CREATE USER ifNotExists?
        userAuthOption (',' userAuthOption)*
        (
          REQUIRE
          (tlsNone=NONE | tlsOption (AND? tlsOption)* )
        )?
        (WITH userResourceOption+)?
        (userPasswordOption | userLockOption)*                      #createUserMysqlV57
    ;

dropUser
    : DROP USER ifExists? userName (',' userName)*
    ;

grantStatement
    : GRANT privelegeClause (',' privelegeClause)*
      ON
      privilegeObject=(TABLE | FUNCTION | PROCEDURE)?
      privilegeLevel
      TO userAuthOption (',' userAuthOption)*
      (
          REQUIRE
          (tlsNone=NONE | tlsOption (AND? tlsOption)* )
        )?
      (WITH (GRANT OPTION | userResourceOption)* )?
    ;

grantProxy
    : GRANT PROXY ON fromFirst=userName
      TO toFirst=userName (',' toOther+=userName)*
      (WITH GRANT OPTION)?
    ;

renameUser
    : RENAME USER
      renameUserClause (',' renameUserClause)*
    ;

revokeStatement
    : REVOKE privelegeClause (',' privelegeClause)*
      ON
      privilegeObject=(TABLE | FUNCTION | PROCEDURE)?
      privilegeLevel
      FROM userName (',' userName)*                                 #detailRevoke
    | REVOKE ALL PRIVILEGES? ',' GRANT OPTION
      FROM userName (',' userName)*                                 #shortRevoke
    ;

revokeProxy
    : REVOKE PROXY ON onUser=userName
      FROM fromFirst=userName (',' fromOther+=userName)*
    ;

setPasswordStatement
    : SET PASSWORD (FOR userName)?
      '=' ( passwordFunctionClause | STRING_LITERAL)
    ;

grantStatementInceptor
    : GRANT privilegeList (ON privilegeObjectSpec)?
      TO principalNames (WITH GRANT OPTION)?
    ;

revokeStatementInceptor
    : REVOKE (GRANT OPTION FOR)? privilegeList
      (ON privilegeObjectSpec)? FROM principalNames
    ;

showGrantInceptor
    : SHOW GRANT principalName? (ON
        (ALL APP? | privilegeObjectSpec)
      )?
    ;

grantPermission
    : GRANT PERMISSION onTableOrView (
        FOR ROWS whereExpressionOptional
        | FOR COLUMN uid caseFunction
      )
    ;

revokePermission
    : REVOKE PERMISSION onTableOrView (
        FOR ROWS
        | FOR COLUMNS
        | FOR COLUMN uid
      )
    ;

showPermission
    : SHOW PERMISSION onTableOrView
    ;

grantFacl
    : GRANT FACL stringLiteral ON TABLE tableName TO userOrGroup
    ;

revokeFacl
    : REVOKE FACL ON TABLE tableName (FROM userOrGroup)?
    ;

showFacl
    : SHOW FACL userOrGroup? ON TABLE tableName
    ;

grantQuota
    : GRANT QUOTA (UNLIMITED | FILESIZE_LITERAL) (ON quotaDb)? (TO quotaUser)?
    ;

revokeQuota
    : REVOKE QUOTA (ON quotaDb)? (FROM quotaUser)?
    ;

showQuota
    : SHOW QUOTA quotaUser? (ON quotaDb)?
    ;

roleStatementInceptor
    : CREATE ROLE uid
    | DROP ROLE uid
    | SET ROLE (uid | ALL)
    | SHOW CURRENT? ROLES
    | SHOW ROLE GRANT principalName
    | GRANT ROLE? uidList TO principalNames (WITH ADMIN OPTION)?
    | REVOKE (ADMIN OPTION FOR)? ROLE? uidList FROM principalNames
    ;

showPrincipal
    : SHOW PRINCIPALS uid
    ;

privilegeList
    : privlegeDef (',' privlegeDef)*
    ;

privlegeDef
    : privilegeType ('(' uidList ')')?
    ;

privilegeType
    : ALL | ALTER | UPDATE | CREATE | CREATE (APP | APPLICATION)
    | DROP | INDEX | LOCK | SELECT | SHOW_DATABASE | INSERT | DELETE
    | START | STOP | LIST
    ;

// database or table type. Type is optional, default type is table
privilegeObjectSpec
    : (DATABASE | SCHEMA) databaseName
    | TABLE? (
      '*' ('.' '*')?
      | databaseName ('.' '*')
      | tableName partitionSpec?
    )
    | (APP | APPLICATION) uid
    | URI (path=stringLiteral)
    | SERVER uid
    ;

principalNames
    : principalName (',' principalName)*
    ;

quotaUser
    : USER uid
    ;

onTableOrView
    : ON (
        TABLE? tableName
        | VIEW viewName
      )
    ;

quotaDb
    : DATABASE databaseName
    | TEMPORARY SPACE2
    ;

userOrGroup
    : USER uid
    | GROUP uid
    ;

principalName
    : USER uid
    | GROUP uid
    | ROLE uid
    ;

// details

userSpecification
    : userName userPasswordOption
    ;

userAuthOption
    : userName IDENTIFIED BY PASSWORD hashed=STRING_LITERAL         #passwordAuthOption
    | userName
      IDENTIFIED (WITH authPlugin)? BY STRING_LITERAL               #stringAuthOption
    | userName
      IDENTIFIED WITH authPlugin
      (AS STRING_LITERAL)?                                          #hashAuthOption
    | userName                                                      #simpleAuthOption
    ;

tlsOption
    : SSL
    | X509
    | CIPHER STRING_LITERAL
    | ISSUER STRING_LITERAL
    | SUBJECT STRING_LITERAL
    ;

userResourceOption
    : MAX_QUERIES_PER_HOUR decimalLiteral
    | MAX_UPDATES_PER_HOUR decimalLiteral
    | MAX_CONNECTIONS_PER_HOUR decimalLiteral
    | MAX_USER_CONNECTIONS decimalLiteral
    ;

userPasswordOption
    : PASSWORD EXPIRE
      (expireType=DEFAULT
      | expireType=NEVER
      | expireType=INTERVAL decimalLiteral DAY
      )?
    ;

userLockOption
    : ACCOUNT lockType=(LOCK | UNLOCK)
    ;

privelegeClause
    : privilege ( '(' uidList ')' )?
    ;

privilege
    : ALL PRIVILEGES?
    | ALTER ROUTINE?
    | CREATE
      (TEMPORARY TABLES | ROUTINE | VIEW | USER | TABLESPACE)?
    | DELETE | DROP | EVENT | EXECUTE | FILE | GRANT OPTION
    | INDEX | INSERT | LOCK TABLES | PROCESS | PROXY
    | REFERENCES | RELOAD
    | REPLICATION (CLIENT | SLAVE)
    | SELECT
    | SHOW (VIEW | DATABASES)
    | SHUTDOWN | SUPER | TRIGGER | UPDATE | USAGE
    ;

privilegeLevel
    : '*'                                                           #currentSchemaPriviLevel
    | '*' '.' '*'                                                   #globalPrivLevel
    | uid '.' '*'                                                   #definiteSchemaPrivLevel
    | uid '.' uid                                                   #definiteFullTablePrivLevel
    | uid                                                           #definiteTablePrivLevel
    ;

renameUserClause
    : fromFirst=userName TO toFirst=userName
    ;

//    Table maintenance statements

analyzeTable
    : ANALYZE actionOption=(NO_WRITE_TO_BINLOG | LOCAL)?
       TABLE tables
    ;

checkTable
    : CHECK TABLE tables checkTableOption*
    ;

checksumTable
    : CHECKSUM TABLE tables actionOption=(QUICK | EXTENDED)?
    ;

optimizeTable
    : OPTIMIZE actionOption=(NO_WRITE_TO_BINLOG | LOCAL)?
      TABLE tables
    ;

repairTable
    : REPAIR actionOption=(NO_WRITE_TO_BINLOG | LOCAL)?
      TABLE tables
      QUICK? EXTENDED? USE_FRM?
    ;

// details

checkTableOption
    : FOR UPGRADE | QUICK | FAST | MEDIUM | EXTENDED | CHANGED
    ;


//    Plugin and udf statements

createUdfunction
    : CREATE AGGREGATE? FUNCTION uid
      RETURNS returnType=(STRING | INTEGER | REAL | DECIMAL)
      SONAME STRING_LITERAL
    ;

installPlugin
    : INSTALL PLUGIN uid SONAME STRING_LITERAL
    ;

uninstallPlugin
    : UNINSTALL PLUGIN uid
    ;


//    Set and show statements

setStatement
    : SET variableAssignment (',' variableAssignment)*              #setVariable
    | {this.isDialect('mysql')}? SET (CHARACTER SET | CHARSET)
      (charsetName | DEFAULT)                                       #setCharset
    | {this.isDialect('mysql')}? SET NAMES
        (charsetName (COLLATE collationName)? | DEFAULT)            #setNames
    | {this.isDialect('mysql')}? setPasswordStatement               #setPassword
    | setTransactionStatement                                       #setTransaction
    | {this.isDialect('mysql')}? setAutocommitStatement             #setAutocommit
    ;

showStatement
    : {this.isDialect('mysql')}? showStatementMysql
    | {this.isDialect('inceptor')}? SHOW showStatementInceptor
    ;

showStatementMysql
    : SHOW logFormat=(BINARY | MASTER) LOGS                         #showMasterLogs
    | SHOW logFormat=(BINLOG | RELAYLOG)
      EVENTS (IN filename=STRING_LITERAL)?
        (FROM fromPosition=decimalLiteral)?
        (LIMIT
          (offset=decimalLiteral ',')?
          rowCount=decimalLiteral
        )?                                                          #showLogEvents
    | SHOW showCommonEntity showFilter?                             #showObjectFilter
    | SHOW FULL? columnsFormat=(COLUMNS | FIELDS)
      tableFormat=(FROM | IN) tableName
        (schemaFormat=fromDatabase)? showFilter?                    #showColumns
    | SHOW CREATE schemaFormat=(DATABASE | SCHEMA)
      ifNotExists? uid                                              #showCreateDb
    | SHOW CREATE
        namedEntity=(
          EVENT | FUNCTION | PROCEDURE
          | TABLE | TRIGGER | VIEW
        )
        fullId                                                      #showCreateFullIdObject
    | SHOW CREATE USER userName                                     #showCreateUser
    | SHOW ENGINE engineName engineOption=(STATUS | MUTEX)          #showEngine
    | SHOW showGlobalInfoClause                                     #showGlobalInfo
    | SHOW errorFormat=(ERRORS | WARNINGS)
        (LIMIT
          (offset=decimalLiteral ',')?
          rowCount=decimalLiteral
        )                                                           #showErrors
    | SHOW COUNT '(' '*' ')' errorFormat=(ERRORS | WARNINGS)        #showCountErrors
    | SHOW showSchemaEntity
        (schemaFormat=(FROM | IN) uid)? showFilter?                 #showSchemaFilter
    | SHOW routine=(FUNCTION | PROCEDURE) CODE fullId               #showRoutine
    | SHOW GRANTS (FOR userName)?                                   #showGrants
    | SHOW indexFormat=(INDEX | INDEXES | KEYS)
      tableFormat=(FROM | IN) tableName
        (schemaFormat=(FROM | IN) uid)? (WHERE expression)?         #showIndexes
    | SHOW OPEN TABLES ( schemaFormat=(FROM | IN) uid)?
      showFilter?                                                   #showOpenTables
    | SHOW PROFILE showProfileType (',' showProfileType)*
        (FOR QUERY queryCount=decimalLiteral)?
        (LIMIT
          (offset=decimalLiteral ',')?
          rowCount=decimalLiteral
        )                                                           #showProfile
    | SHOW SLAVE STATUS (FOR CHANNEL STRING_LITERAL)?               #showSlaveStatus
    ;

showStatementInceptor
    : (DATABASES | SCHEMAS) (LIKE stringLiteral)?                   #showInceptorDatabase
    | (TABLES | MATERIALIZED VIEWS | SEQUENCES | STREAMS |
      METRICS) fromDatabase? (LIKE wildUid)?                        #showInceptorTables
    | CURRENT (APPLICATION | APP)                                   #showInceptorCurrent
    | (APPLICATIONS | APPS | STREAMJOBS | RULES | RULEBASES
      | POLICIES | POLICYBASES | RULEFUNCTIONS | CACHEDMETRICS
      ) (LIKE wildUid)?                                             #showInceptorMisc
    | COLUMNS (FROM | IN) tableName fromDatabase?                   #showInceptorColumn
    | FUNCTIONS wildFuncOptional                                    #showInceptorFunction
    | PLSQL (FUNCTIONS | PACKAGES) wildUid?                         #showInceptorPlsql
    | PARTITIONS tableName partitionSpec?                           #showInceptorPartition
    | CREATE TABLE tableName                                        #showInceptorCreateTable
    | TABLE EXTENDED fromDatabase? LIKE wildUid partitionSpec?      #showInceptorExtendedTable
    | TBLPROPERTIES tableName ('(' stringLiteral ')')?              #showInceptorTblProperties
    // | LOCKS fullId? EXTENDED?                                       #showInceptorLockTransaction
    // | LOCKS DATABASE databaseName EXTENDED?                         #showInceptorLockDatabase
    | FORMATTED? (INDEX | INDEXES) ON wildUid fromDatabase?         #showInceptorIndex
    | COMPACT BLACKLIST databaseNameAllowEmpty                      #showInceptorBlackList
    | CONF stringLiteral                                            #showInceptorConf
    | (DATABASE LINKS | COMPACTIONS | TRANSACTIONS)                 #showInceptorOther
    ;

// details

variableAssignment
    : variableClause ('=' | ':=') (variableExprReserved | expression)
    | variableClause
      {
        this.notifyErrorListeners('Please provide expression');
      }
    ;

variableClause
    : {this.isDialect('mysql')}? (
        LOCAL_ID
        | GLOBAL_ID
        | ( ('@' '@')? (GLOBAL | SESSION | LOCAL)  )? uid
      )
    | {this.isDialect('inceptor')}? variableFullId
    | emptyElement
      {
        this.notifyErrorListeners('Please provide variable');
      }
    ;

variableFullId
    : uid dottedId*
    ;

variableExprReserved
    : {this.isDialect('inceptor')}? (ORACLE | DB2 | NONSTRICT | INCEPTOR)
    ;

showCommonEntity
    : CHARACTER SET | COLLATION | DATABASES | SCHEMAS
    | FUNCTION STATUS | PROCEDURE STATUS
    | (GLOBAL | SESSION)? (STATUS | VARIABLES)
    ;

showFilter
    : LIKE STRING_LITERAL
    | WHERE expression
    ;

showGlobalInfoClause
    : STORAGE? ENGINES | MASTER STATUS | PLUGINS
    | PRIVILEGES | FULL? PROCESSLIST | PROFILES
    | SLAVE HOSTS | AUTHORS | CONTRIBUTORS
    ;

showSchemaEntity
    : EVENTS | TABLE STATUS | FULL? TABLES | TRIGGERS
    ;

showProfileType
    : ALL | BLOCK IO | CONTEXT SWITCHES | CPU | IPC | MEMORY
    | PAGE FAULTS | SOURCE | SWAPS
    ;

fromDatabase
    : (FROM | IN) databaseName
    ;

// jars

addJarStatement
    : ADD (JAR | JARS) (filePath | stringLiteral)
    ;

listJarStatement
    : LIST (JAR | JARS)
    ;

//    Other administrative statements

binlogStatement
    : BINLOG STRING_LITERAL
    ;

cacheIndexStatement
    : CACHE INDEX tableIndexes (',' tableIndexes)*
      ( PARTITION '(' (uidList | ALL) ')' )?
      IN schema=uid
    ;

flushStatement
    : FLUSH flushFormat=(NO_WRITE_TO_BINLOG | LOCAL)?
      flushOption (',' flushOption)*
    ;

killStatement
    : KILL connectionFormat=(CONNECTION | QUERY)?
      decimalLiteral+
    ;

loadIndexIntoCache
    : LOAD INDEX INTO CACHE
      loadedTableIndexes (',' loadedTableIndexes)*
    ;

// remark reset (maser | slave) describe in replication's
//  statements section
resetStatement
    : RESET QUERY CACHE
    ;

shutdownStatement
    : SHUTDOWN
    ;


// set plsql delimiter

setDelimiter
    locals [
      delimiter: string = ';'
    ]
    : {this.isDialect('inceptor')}? EXCLAMATION_SET PLSQLUSESLASH
      booleanLiteral                                                #setDelimiterInceptor
    | {this.isDialect('mysql')}? DELIMITER token=setDelimiterToken
      {
        $ctx.delimiter = $token.text;
      }                                                             #setDelimiterMysql
    ;

// NOTE: DELIMITER statement in mysql is a mysql client side process. It is not a official mysql server
//   grammar. And the token can be anything including keywords like `SELECT`, which is not possible in
//   current grammar system.
//   1. You cannot/shouldn't form an lexer rule include anything. Lexer rule is deterministic and
//    the way it works is to define fixed lexer token. If you defined an wild lexer token. It will
//    match something like `);` which clearly does not make sense.
//   2. Another way of recognize `anything` token is in Parser rule, Something like `token=.*? '\n'`.
//    Match `anything` until the end of line. But lexer process hide space like input to hidden channel
//    and not possible for current implementation.
//   Thus, the compromise is to make the token for at least one charactor and perhaps more.
//    BUGS/FLAWS: `DELIMITER / S` will not report error.
setDelimiterToken
    : . .? .?
    ;

setPlsqlDialect
    : EXCLAMATION_SET PLSQLCLIENTDIALECT setPlsqlDialectId
    ;

setPlsqlDialectId
    : uid
    | emptyElement {this.notifyErrorListeners('Please provide dialect name');}
    ;

// details

tableIndexes
    : tableName ( indexFormat=(INDEX | KEY)? '(' uidList ')' )?
    ;

flushOption
    : (
        DES_KEY_FILE | HOSTS
        | (
            BINARY | ENGINE | ERROR | GENERAL | RELAY | SLOW
          )? LOGS
        | OPTIMIZER_COSTS | PRIVILEGES | QUERY CACHE | STATUS
        | USER_RESOURCES | TABLES (WITH READ LOCK)?
       )                                                            #simpleFlushOption
    | RELAY LOGS channelOption?                                     #channelFlushOption
    | TABLES tables flushTableOption?                               #tableFlushOption
    ;

flushTableOption
    : WITH READ LOCK
    | FOR EXPORT
    ;

loadedTableIndexes
    : tableName
      ( PARTITION '(' (partitionList=uidList | ALL) ')' )?
      ( indexFormat=(INDEX | KEY)? '(' indexList=uidList ')' )?
      (IGNORE LEAVES)?
    ;


// Utility Statements

describeStatement
    : {this.isDialect('mysql')}? describeStatementMysql
    | {this.isDialect('inceptor')}? (DESCRIBE | DESC) describeStatementInceptor
    ;

describeStatementMysql
    : simpleDescribeStatement | fullDescribeStatement
    ;

simpleDescribeStatement
    : command=(EXPLAIN | DESCRIBE | DESC) tableName
      (column=uid | pattern=STRING_LITERAL)?
    ;

fullDescribeStatement
    : command=(EXPLAIN | DESCRIBE | DESC)
      (
        formatType=(EXTENDED | PARTITIONS | FORMAT )
        '='
        formatValue=(TRADITIONAL | JSON)
      )?
      describeObjectClause
    ;

describeStatementInceptor
    : DATABASE (LINK | EXTENDED?) databaseName                      #describeInceptorDatabase
    | INDEX FORMATTED? uid ON tableName                             #describeInceptorIndex
    | FUNCTION EXTENDED? (udfName | functionNameBaseExtra)          #describeInceptorFunction
    | PLSQL (FUNCTION | PACKAGE) EXTENDED? fullId                   #describeInceptorProcedure
    | (APPLICATION | APP | STREAMJOB | RULE | POLICY
      | RULEFUNCTION | CACHEDMETRIC) uid                            #describeInceptorMisc
    | (EXTENDED | FORMATTED | PRETTY)?
      (prefixedColumnNameOptional | stringLiteral) partitionSpec?   #describeInceptorTable
    | (EXTENDED | FORMATTED | PRETTY)? uid                          #describeInceptorTableSuggester
    ;

helpStatement
    : HELP STRING_LITERAL
    ;

useStatement
    : USE databaseName
    ;

// details

describeObjectClause
    : (
        selectStatement | deleteStatement | insertStatement
        | replaceStatement | updateStatement
      )                                                             #describeStatements
    | FOR CONNECTION uid                                            #describeConnection
    ;

// Inceptor Partitions


tablePartitionedBy
    locals [level: number = 0]
    : PARTITIONED BY createDefinitions
    | PARTITIONED BY RANGE (createDefinitions | '(' uidList ')')
      (INTERVAL '(' constant | functionCall ')')?
      ('(' rangePartition (',' rangePartition)* ')')?
    ;

dropPartitionAtom
    : uid comparisonOperator expression
    ;

rangePartition
    : PARTITION uid VALUES LESS THAN
      '(' partitionDefinerAtom (',' partitionDefinerAtom)* ')'
      locationDefinition?
    ;

partitionPlus
    : partitionSpec locationDefinition?
    ;

partitionSpec
    locals [level: number = 0]
    : partitionSpecList
    | partitionSpecMap
    ;

partitionSpecList
    locals [level: number = 0]
    : PARTITION uidList
    ;

partitionSpecMap
    locals [level: number = 1]
    : PARTITION '(' idValueProperties ')'
    ;

// Common Clauses

//    DB Objects

fullId
    : uid (DOT_ID | '.' uid)?
    | uid '.'
      {this.notifyErrorListeners('Please provide complete name');}
    ;

tableName
    : fullId
    | emptyElement {this.notifyErrorListeners('Please provide full name');}
    ;

viewName
    : fullId
    | emptyElement {this.notifyErrorListeners('Please provide view name');}
    ;

tripleId
    : uid (dottedId dottedId? )?
    | uid dottedId* '.'
      {this.notifyErrorListeners('Please provide complete column name');}
    ;

columnUid
    : uid
    | emptyElement {this.notifyErrorListeners('Please provide column name');}
    ;

fullColumnNameOptional
    : fullColumnName
    | emptyElement
      {
        this.notifyErrorListeners('Please provide column');
      }
    ;

fullColumnName
    : uid (dottedId dottedId? )?
    | uid dottedId* '.'
      {this.notifyErrorListeners('Please provide complete column name');}
    ;

prefixedColumnNameOptional
    : prefixedColumnName
    | emptyElement
      {
        this.notifyErrorListeners('Please provide column');
      }
    ;

prefixedColumnName
    : uid dottedId dottedId?
    | uid dottedId* '.'
      {this.notifyErrorListeners('Please provide complete column name');}
    ;

funcName
    : fullId
    | emptyElement {this.notifyErrorListeners('Please provide function name');}
    ;

udfName
    : uid
    | emptyElement {this.notifyErrorListeners('Please provide function name');}
    ;

procName
    : fullId
    | emptyElement {this.notifyErrorListeners('Please provide procedure name');}
    ;

packName
    : fullId
    | emptyElement {this.notifyErrorListeners('Please provide package name');}
    ;

// 该rule可提示function名
funcColumnName
    : fullColumnName
    ;

funcColumnNameOptional
    : funcColumnName
    | emptyElement
      {
        this.notifyErrorListeners('Please provide column expression');
      }
    ;


wildFuncOptional
    : wildUid
    | emptyElement
      {
        this.notifyErrorListeners('Please provide function name');
      }
    ;

wildUid
    : uid | stringLiteral
    ;

indexColumnName
    : (uid | STRING_LITERAL) ('(' decimalLiteral ')')? sortType=(ASC | DESC)?
    ;

userName
    : STRING_USER_NAME | ID | STRING_LITERAL;

mysqlVariable
    : LOCAL_ID
    | GLOBAL_ID
    ;

charsetName
    : BINARY
    | charsetNameBase
    | STRING_LITERAL
    | CHARSET_REVERSE_QOUTE_STRING
    ;

collationName
    : uid | STRING_LITERAL;

engineName
    : ARCHIVE | BLACKHOLE | CSV | FEDERATED | INNODB | MEMORY
    | MRG_MYISAM | MYISAM | NDB | NDBCLUSTER | PERFORMANCE_SCHEMA
    | TOKUDB
    | STRING_LITERAL | REVERSE_QUOTE_ID
    ;

uuidSet
    : decimalLiteral '-' decimalLiteral '-' decimalLiteral
      '-' decimalLiteral '-' decimalLiteral
      (':' decimalLiteral '-' decimalLiteral)+
    ;

xid
    : globalTableUid=xuidStringId
      (
        ',' qualifier=xuidStringId
        (',' idFormat=decimalLiteral)?
      )?
    ;

xuidStringId
    : STRING_LITERAL
    | BIT_STRING
    | HEXADECIMAL_LITERAL+
    ;

authPlugin
    : uid | STRING_LITERAL
    ;

uid
    : simpleId
    //| DOUBLE_QUOTE_ID
    | REVERSE_QUOTE_ID
    | CHARSET_REVERSE_QOUTE_STRING
    ;

simpleId
    : ID
    | charsetNameBase
    | transactionLevelBase
    | engineName
    | privilegesBase
    | intervalTypeBase
    | dataTypeBase
    | keywordsCanBeId
    | functionNameBase
    | fileFormatCanBeId
    | inceptorKeywordCanBeId
    | templateId
    ;

templateId
    : TEMPLATE_ID
    ;

dottedId
    : DOT_ID
    | '.' uid
    ;

filePath
    : ('/' fileSegment (('.' fileSegment | dottedId))*)+
    ;

fileSegment
    : (simpleId | '-' | ':')*
    ;

//    Literals

decimalLiteral
    : DECIMAL_LITERAL | ZERO_DECIMAL | ONE_DECIMAL | TWO_DECIMAL
    ;

fileSizeLiteral
    : FILESIZE_LITERAL | decimalLiteral;

stringLiteral
    : (
        STRING_CHARSET_NAME? STRING_LITERAL
        | START_NATIONAL_STRING_LITERAL
      ) STRING_LITERAL+
    | (
        STRING_CHARSET_NAME? STRING_LITERAL
        | START_NATIONAL_STRING_LITERAL
      ) stringLiteralCollate?
    ;

stringLiteralCollate
    : {this.isDialect('mysql')}? COLLATE collationName
    ;

booleanLiteral
    : TRUE | FALSE;

hexadecimalLiteral
    : STRING_CHARSET_NAME? HEXADECIMAL_LITERAL;

nullNotnull
    : NOT? (NULL_LITERAL | NULL_SPEC_LITERAL)
    ;

constant
    locals [noSpaceTokens: Array<string> = ['-']]
    : stringLiteral | decimalLiteral
    | '-' decimalLiteral
    | hexadecimalLiteral | booleanLiteral
    | REAL_LITERAL | BIT_STRING
    | NOT? nullLiteral=(NULL_LITERAL | NULL_SPEC_LITERAL)
    ;


//    Data Types
dataType
      : {this.isDialect('inceptor')}? inceptorDataType
      | {this.isDialect('mysql')}? mySqlDataType
      ;


mySqlDataType
    : typeName=(
      CHAR | VARCHAR | TINYTEXT | TEXT | MEDIUMTEXT | LONGTEXT
       | NCHAR | NVARCHAR
      )
      lengthOneDimension? BINARY?
      ((CHARACTER SET | CHARSET) charsetName)?                      #stringDataType
    | NATIONAL typeName=(VARCHAR | CHARACTER)
      lengthOneDimension? BINARY?                                   #nationalStringDataType
    | NCHAR typeName=VARCHAR
      lengthOneDimension? BINARY?                                   #nationalStringDataType
    | NATIONAL typeName=(CHAR | CHARACTER) VARYING
      lengthOneDimension? BINARY?                                   #nationalVaryingStringDataType
    | typeName=(
        TINYINT | SMALLINT | MEDIUMINT | INT | INTEGER | BIGINT
      )
      lengthOneDimension? (SIGNED | UNSIGNED)? ZEROFILL?            #dimensionDataType
    | typeName=REAL
      lengthTwoDimension? (SIGNED | UNSIGNED)? ZEROFILL?            #dimensionDataType
    | typeName=DOUBLE PRECISION?
          lengthTwoDimension? (SIGNED | UNSIGNED)? ZEROFILL?            #dimensionDataType
    | typeName=(DECIMAL | DEC | FIXED | NUMERIC | FLOAT)
      lengthTwoOptionalDimension? (SIGNED | UNSIGNED)? ZEROFILL?    #dimensionDataType
    | typeName=(
        DATE | TINYBLOB | BLOB | MEDIUMBLOB | LONGBLOB
        | BOOL | BOOLEAN | SERIAL
      )                                                             #simpleDataType
    | typeName=(
        BIT | TIME | TIMESTAMP | DATETIME | BINARY
        | VARBINARY | YEAR
      )
      lengthOneDimension?                                           #dimensionDataType
    | typeName=(ENUM | SET)
      collectionOptions BINARY?
      ((CHARACTER SET | CHARSET) charsetName)?                      #collectionDataType
    | typeName=(
        GEOMETRYCOLLECTION | GEOMCOLLECTION | LINESTRING | MULTILINESTRING
        | MULTIPOINT | MULTIPOLYGON | POINT | POLYGON | JSON | GEOMETRY
      )                                                             #spatialDataType
    ;

inceptorDataType
    locals [noSpaceTokens: Array<string> = ['<', '>']]
    : typeName=(
        TINYINT | SMALLINT | INT | BIGINT | BOOLEAN | FLOAT | DOUBLE | INTEGER
        | DATETIME | GEO | NVARCHAR | CLOB | BINARY | BLOB
      )                                                             #inceptorSimpleDataType
    | DATE (FORMAT stringLiteral)?                                  #inceptorDateDataType
    | typeName=(
        TIMESTAMP | STRING | CHAR | VARCHAR2 | VARCHAR
      ) lengthOneDimension?                                         #inceptorDimensionDataType
    | (
        INTERVAL YEAR TO MONTH | INTERVAL DAY TO SECOND
      )                                                             #inceptorIntervalDataType
    | typeName=(
        DECIMAL | NUMERIC | NUMBER | DEC
      ) lengthTwoOptionalDimension?                                 #inceptorNumericDataType
    | ARRAY '<' inceptorDataType '>'                                #inceptorArrayDataType
    | MAP '<' inceptorDataType ',' inceptorDataType '>'             #inceptorMapDataType
    | UNION '<' inceptorDataType (',' inceptorDataType) * '>'       #inceptorUnionDataType
    | STRUCT '<' inceptorStructDataTypeItem (',' inceptorStructDataTypeItem) * '>'
                                                                    #inceptorStructDataType
    ;

inceptorStructDataTypeItem
    : key=uid ':' inceptorDataType
    ;

collectionOptions
    : '(' STRING_LITERAL (',' STRING_LITERAL)* ')'
    ;

convertedDataType
    : typeName=(BINARY| NCHAR) lengthOneDimension?
    | typeName=CHAR lengthOneDimension? (CHARACTER SET charsetName)?
    | typeName=(DATE | DATETIME | TIME)
    | typeName=DECIMAL lengthTwoDimension?
    | (SIGNED | UNSIGNED) INTEGER?
    ;

lengthOneDimension
    : '(' decimalLiteral ')'
    ;

lengthTwoDimension
    : '(' decimalLiteral ',' decimalLiteral ')'
    ;

lengthTwoOptionalDimension
    : '(' decimalLiteral (',' decimalLiteral)? ')'
    ;


//    Common Lists

uidList
    : uid (',' uid)*
    ;

uidOrderList
    : uidOrder (',' uidOrder)*
    ;

uidOrder
    : uid order=(ASC | DESC)?
    ;

fullIdList
    : fullId (',' fullId)*
    ;

columnUids
    : columnUid (',' columnUid)*
    ;

columnNames
    : fullColumnName (',' fullColumnName)*
    ;

tables
    : tableName (',' tableName)*
    ;

indexColumnNames
    : '(' indexColumnName (',' indexColumnName)* ')'
    ;

expressions
    : expression (',' expression)*
    ;

expressionsWithDefaults
    : expressionOrDefault (',' expressionOrDefault)*
    ;

constants
    : constant (',' constant)*
    ;

simpleStrings
    : STRING_LITERAL (',' STRING_LITERAL)*
    ;

userVariables
    : LOCAL_ID (',' LOCAL_ID)*
    ;


//    Common Expressons

defaultValue
    : NULL_LITERAL
    | unaryOperator? constant
    | currentTimestamp (ON UPDATE currentTimestamp)?
    ;

currentTimestamp
    :
    (
      (CURRENT_TIMESTAMP | LOCALTIME | LOCALTIMESTAMP) ('(' decimalLiteral? ')')?
      | NOW '(' decimalLiteral? ')'
    )
    ;

expressionOrDefault
    : expression | DEFAULT
    ;

ifExists
    : IF EXISTS;

ifNotExists
    : IF NOT EXISTS;


//    Functions

functionCall
    locals [noSpaceTokens: Array<string> = ['(']]
    : specificFunction                                              #specificFunctionCall
    | fullId (paren='(' functionArgs ')')?
      {
        this.checkTokenExist($paren, 'Pleaase provide `()` and arguments');
      }                                                             #udfFunctionCall
    | aggregateWindowedFunction                                     #aggregateFunctionCall
    | {this.isDialect('mysql')}? passwordFunctionClause             #passwordFunctionCall
    ;

specificFunction
    : {this.isDialect('mysql')}? specificFunctionMysql
    | {this.isDialect('inceptor')}? specificFunctionInceptor
    ;

specificFunctionMysql
    locals [noSpaceTokens: Array<string> = ['(']]
    : (
      CURRENT_DATE | CURRENT_TIME | CURRENT_TIMESTAMP
      | CURRENT_USER | LOCALTIME
      )                                                             #simpleFunctionCall
    | CONVERT '(' expression separator=',' convertedDataType ')'    #dataTypeFunctionCall
    | CONVERT '(' expression USING charsetName ')'                  #dataTypeFunctionCall
    | CAST '(' expression AS convertedDataType ')'                  #dataTypeFunctionCall
    | VALUES '(' fullColumnName ')'                                 #valuesFunctionCall
    | caseFunction                                                  #caseFunctionCall
    | CHAR '(' functionArgs  (USING charsetName)? ')'               #charFunctionCall
    | POSITION
      '('
          (
            positionString=stringLiteral
            | positionExpression=expression
          )
          IN
          (
            inString=stringLiteral
            | inExpression=expression
          )
      ')'                                                           #positionFunctionCall
    | substringFunction                                             #substrFunctionCall
    | TRIM
      '('
        positioinForm=(BOTH | LEADING | TRAILING)
        (
          sourceString=stringLiteral
          | sourceExpression=expression
        )?
        FROM
        (
          fromString=stringLiteral
          | fromExpression=expression
        )
      ')'                                                           #trimFunctionCall
    | TRIM
      '('
        (
          sourceString=stringLiteral
          | sourceExpression=expression
        )
        FROM
        (
          fromString=stringLiteral
          | fromExpression=expression
        )
      ')'                                                           #trimFunctionCall
    | WEIGHT_STRING
      '('
        (stringLiteral | expression)
        (AS stringFormat=(CHAR | BINARY)
        '(' decimalLiteral ')' )?  levelsInWeightString?
      ')'                                                           #weightFunctionCall
    | extractFunction                                               #extractFunctionCall
    | GET_FORMAT
      '('
        datetimeFormat=(DATE | TIME | DATETIME)
        ',' stringLiteral
      ')'                                                           #getFormatFunctionCall
    ;

specificFunctionInceptor
    : castFunctionInceptor
    | caseFunction
    | substringFunction
    | extractFunction
    ;

castFunctionInceptor
    locals [noSpaceTokens: Array<string> = ['(']]
    : CAST '(' expression AS dataType ')'
    ;

substringFunction
    locals [noSpaceTokens: Array<string> = ['(']]
    : (SUBSTR | SUBSTRING)
      '('
        (
          sourceString=stringLiteral
          | sourceExpression=expression
        ) FROM
        (
          fromDecimal=decimalLiteral
          | fromExpression=expression
        )
        (
          FOR
          (
            forDecimal=decimalLiteral
            | forExpression=expression
          )
        )?
      ')'
    ;

extractFunction
    locals [noSpaceTokens: Array<string> = ['(']]
    : EXTRACT
      '('
        intervalType
        FROM
        (
          sourceString=stringLiteral
          | sourceExpression=expression
        )
      ')'
    ;

caseFunction
    locals [
      block: any = null
      newlineTokens: Array<string> = ['ELSE']
    ]
    @init {
      $ctx.block = this.generateBlockContext('CASE', 'END', {expand: true})
    }
    : CASE expression caseFuncAlternative+
      (ELSE elseArg=functionArg)? END
    | CASE caseFuncAlternative+
      (ELSE elseArg=functionArg)? END
    ;

caseFuncAlternative
    locals [level: number = 0]
    : WHEN condi=functionArg
      THEN consequent=functionArg
    ;

levelsInWeightString
    : LEVEL levelInWeightListElement
      (',' levelInWeightListElement)*                               #levelWeightList
    | LEVEL
      firstLevel=decimalLiteral '-' lastLevel=decimalLiteral        #levelWeightRange
    ;

levelInWeightListElement
    : decimalLiteral orderType=(ASC | DESC | REVERSE)?
    ;

aggregateWindowedFunction
    : {this.isDialect('mysql')}? aggregateWindowedFunctionMysql
    | {this.isDialect('inceptor')}? aggregateWindowedFunctionInceptor
    ;

aggregateWindowedFunctionMysql
    locals [noSpaceTokens: Array<string> = ['(']]
    : functionName=(AVG | MAX | MIN | SUM)
      '(' aggregator=(ALL | DISTINCT)? functionArg ')'
    | functionName=COUNT '(' (starArg='*' | aggregator=ALL? functionArg) ')'
    | functionName=COUNT '(' aggregator=DISTINCT functionArgs ')'
    | functionName=(
        BIT_AND | BIT_OR | BIT_XOR | STD | STDDEV | STDDEV_POP
        | STDDEV_SAMP | VAR_POP | VAR_SAMP | VARIANCE
      ) '(' aggregator=ALL? functionArg ')'
    | functionName=GROUP_CONCAT '('
        aggregator=DISTINCT? functionArgs
        (ORDER BY
          orderByExpression (',' orderByExpression)*
        )? (SEPARATOR separator=STRING_LITERAL)?
      ')'
    ;

aggregateWindowedFunctionInceptor
    locals [noSpaceTokens: Array<string> = ['(']]
    : uid '(' ('*' | functionArg) ')' (OVER windowOverSpec)?
    ;

windowOverSpec
    : '('
        (PARTITION BY (
          expression+
          | ('(' expression+ ')')
        ))?
        (orderByClause windowClause?)?
      ')'
    ;

windowClause
    : (ROWS | RANGE) ( windowStartBoundaryDefault
      | (BETWEEN windowStartBoundary AND windowEndBoundary)
    )
    ;

// TODO: expression必须evaluate为正值
windowStartBoundary
    : UNBOUNDED PRECEDING
    | CURRENT ROW
    | expression (PRECEDING | FOLLOWING)
    ;

windowStartBoundaryDefault
    : UNBOUNDED PRECEDING
    | CURRENT ROW
    | expression PRECEDING
    ;

windowEndBoundary
    : UNBOUNDED FOLLOWING
    | CURRENT ROW
    | expression (PRECEDING | FOLLOWING)
    ;

passwordFunctionClause
    locals [noSpaceTokens: Array<string> = ['(']]
    : functionName=(PASSWORD | OLD_PASSWORD) '(' functionArg ')'
    ;

functionArgs
    : functionArg (',' functionArg)*
    ;

// TODO: functionArg允许空元素来启用括号内空格提示。但是
functionArg
    : constant | funcColumnName | functionCall | expression | functionArgOptional
    ;

functionArgOptional
    : emptyElement
    ;

//    Expressions, predicates

// 可为空的expression，用于空格提示
expressionOptional
    : expression
    | emptyElement
      {
        this.notifyErrorListeners('Please provide expression');
      }
    ;

// Simplified approach for expression
expression
    : notOperator=(NOT | '!') expression                            #notExpression
    | expression logicalOperator expression                         #logicalExpression
    | predicate IS NOT? testValue=(TRUE | FALSE | UNKNOWN)          #isExpression
    | predicate IS NOT? testValue=(TRUE | FALSE | UNKNOWN)?
      {this.notifyErrorListeners('Please provide value `TRUE/FALSE/UNKNOWN`');}
                                                                    #ErrorIsExpression
    | predicate                                                     #predicateExpression
    ;

predicate
    : predicate NOT? IN '(' (selectStatementPlus | expressions) ')' #inPredicate
    | predicate IS nullNotnull                                      #isNullPredicate
    | left=predicate comparisonOperator right=predicate             #binaryComparasionPredicate
    | predicate comparisonOperator
      quantifier=(ALL | ANY | SOME) '(' selectStatementPlus ')'     #subqueryComparasionPredicate
    | predicate NOT? BETWEEN predicate AND predicate                #betweenPredicate
    | predicate SOUNDS LIKE predicate                               #soundsLikePredicate
    | predicate NOT? LIKE predicate (ESCAPE STRING_LITERAL)?        #likePredicate
    | predicate NOT? regex=(REGEXP | RLIKE) predicate               #regexpPredicate
    | expressionAtom                                                #expressionAtomPredicate
    // mysql的expression显然允许灵活的变量赋值，但是基于现行的frameTransaction架构，
    // expression里递归的变量赋值会使得获取变量定义困难，并且代码写法上也会显得非常繁琐
    // NOTE: 也许需要一种不需要frameTransaction也可以在工作区中定义新变量的方法。
    // | {this.isDialect('mysql')}? (LOCAL_ID VAR_ASSIGN)?
    //   expressionAtom                                                #expressionAtomPredicate
    ;

// expressionMoleculeRight
//     : '%' (ISOPEN | FOUND | NOTFOUND | ROWCOUNT | BULK_ROWCOUNT | BULK_EXCEPTIONS)
//     | '.' expressionAtom // struct
//     | '[' expression ']' // map | array
//     | '(' ('*' | DISTINCT)? ')' // function
//     ;

// Add in ASTVisitor nullNotnull in constant
expressionAtom
    : constant                                                      #constantExpressionAtom
    | funcColumnName                                                #fullColumnNameExpressionAtom
    | functionCall                                                  #functionCallExpressionAtom
    | {this.isDialect('inceptor')}? generalElement                  #generalElementExpressionAtom
    | {this.isDialect('inceptor')}? (cursorName | SQL)
      cursorAttribute                                               #cursorAttributeExpressionAtom
    | expressionAtom COLLATE collationName                          #collateExpressionAtom
    | {this.isDialect('mysql')}? mysqlVariable                      #mysqlVariableExpressionAtom
    | (unaryOperator | unaryPriorOperator | NOT) expressionAtom     #unaryExpressionAtom
    | BINARY expressionAtom                                         #binaryExpressionAtom
    | '(' expression (',' expression)* ')'                          #nestedExpressionAtom
    | ROW '(' expression (',' expression)+ ')'                      #nestedRowExpressionAtom
    | EXISTS '(' selectStatementPlus ')'                            #existsExpessionAtom
    | '(' selectStatementPlus ')'                                   #subqueryExpessionAtom
    | INTERVAL expression intervalType                              #intervalExpressionAtom
    | left=expressionAtom bitOperator right=expressionAtom          #bitExpressionAtom
    | left=expressionAtom mathOperator right=expressionAtom         #mathExpressionAtom
    ;

unaryPriorOperator
    : {this.isDialect('inceptor')}? PRIOR
    ;

unaryOperator
    locals [noSpaceBetween: boolean = true]
    : '!' | '~' | '+' | '-'
    ;

comparisonOperator
    locals [noSpaceTokens: Array<string> = ['<', '>', '=']]
    : '=' | '>' | '<' | '<' '=' | '>' '='
    | '<' '>' | '!' '=' | '<' '=' '>'
    ;

logicalOperator
    locals [
      level: number = 1
      noSpaceTokens: Array<string> = ['&', '|']
    ]
    : AND | '&' '&' | XOR | OR | '|' '|'
    ;

bitOperator
    locals [noSpaceTokens: Array<string> = ['<', '>']]
    : '<' '<' | '>' '>' | '&' | '^' | '|'
    ;

mathOperator
    : '*' | '/' | '%' | DIV | MOD | '+' | '-' | '--'
    ;

cursorAttribute
    locals [
      noSpaceBetween: boolean = true
      noSpaceTokens: Array<string> = ['%']
    ]
    // inceptorOracle.g4 (ISOPEN | FOUND | NOTFOUND | ROWCOUNT | BULK_ROWCOUNT | BULK_EXCEPTIONS)
    : '%' (FOUND | NOTFOUND | ISOPEN | ROWCOUNT | ROWTYPE)
    ;

//    Simple id sets
//     (that keyword, which can be id)

charsetNameBase
    : ARMSCII8 | ASCII | BIG5 | CP1250 | CP1251 | CP1256 | CP1257
    | CP850 | CP852 | CP866 | CP932 | DEC8 | EUCJPMS | EUCKR
    | GB2312 | GBK | GEOSTD8 | GREEK | HEBREW | HP8 | KEYBCS2
    | KOI8R | KOI8U | LATIN1 | LATIN2 | LATIN5 | LATIN7 | MACCE
    | MACROMAN | SJIS | SWE7 | TIS620 | UCS2 | UJIS | UTF16
    | UTF16LE | UTF32 | UTF8 | UTF8MB3 | UTF8MB4
    ;

transactionLevelBase
    : REPEATABLE | COMMITTED | UNCOMMITTED | SERIALIZABLE
    ;

privilegesBase
    : TABLES | ROUTINE | EXECUTE | FILE | PROCESS
    | RELOAD | SHUTDOWN | SUPER | PRIVILEGES
    ;

intervalTypeBase
    : QUARTER | MONTH | DAY | HOUR
    | MINUTE | WEEK | SECOND | MICROSECOND
    ;

dataTypeBase
    : DATE | TIME | TIMESTAMP | DATETIME | YEAR | ENUM | TEXT
    ;

// NOTE: removed keywords from original mysql keywordsCanBeId
//    BEGIN, END
keywordsCanBeId
    : ACCOUNT | ACTION | AFTER | AGGREGATE | ALGORITHM | ANY
    | AT | AUTHORS | AUTOCOMMIT | AUTOEXTEND_SIZE
    | AUTO_INCREMENT | AVG_ROW_LENGTH | BINLOG | BIT
    | BLOCK | BOOL | BOOLEAN | BTREE | CACHE | CASCADED | CHAIN | CHANGED
    | CHANNEL | CHECKSUM | PAGE_CHECKSUM | CIPHER | CLIENT | CLOSE | COALESCE | CODE
    | COLUMNS | COLUMN_FORMAT | COMMENT | COMMIT | COMPACT
    | COMPLETION | COMPRESSED | COMPRESSION | CONCURRENT
    | CONNECTION | CONSISTENT | CONTAINS | CONTEXT
    | CONTRIBUTORS | COPY | CPU | DATA | DATAFILE | DEALLOCATE
    | DEFAULT_AUTH | DEFINER | DELAY_KEY_WRITE | DES_KEY_FILE | DIRECTORY
    | DISABLE | DISCARD | DISK | DO | DUMPFILE | DUPLICATE
    | DYNAMIC | ENABLE | ENCRYPTION | ENDS | ENGINE | ENGINES
    | ERROR | ERRORS | ESCAPE | EVEN | EVENT | EVENTS | EVERY
    | EXCHANGE | EXCLUSIVE | EXPIRE | EXPORT | EXTENT_SIZE | FAST | FAULTS
    | FIELDS | FILE_BLOCK_SIZE | FILTER | FIRST | FIXED | FLUSH
    | FOLLOWS | FOUND | FULL | GENERAL | GLOBAL | GRANTS
    | GROUP_REPLICATION | HANDLER | HASH | HELP | HOST | HOSTS | IDENTIFIED
    | IGNORE_SERVER_IDS | IMPORT | INDEXES | INITIAL_SIZE
    | INPLACE | INSERT_METHOD | INSTALL | INSTANCE | INVOKER | IO
    | IO_THREAD | IPC | ISOLATION | ISSUER | JSON | KEY_BLOCK_SIZE
    | LANGUAGE | LAST | LEAVES | LESS | LEVEL | LIST | LOCAL
    | LOGFILE | LOGS | MASTER | MASTER_AUTO_POSITION
    | MASTER_CONNECT_RETRY | MASTER_DELAY
    | MASTER_HEARTBEAT_PERIOD | MASTER_HOST | MASTER_LOG_FILE
    | MASTER_LOG_POS | MASTER_PASSWORD | MASTER_PORT
    | MASTER_RETRY_COUNT | MASTER_SSL | MASTER_SSL_CA
    | MASTER_SSL_CAPATH | MASTER_SSL_CERT | MASTER_SSL_CIPHER
    | MASTER_SSL_CRL | MASTER_SSL_CRLPATH | MASTER_SSL_KEY
    | MASTER_TLS_VERSION | MASTER_USER
    | MAX_CONNECTIONS_PER_HOUR | MAX_QUERIES_PER_HOUR
    | MAX_ROWS | MAX_SIZE | MAX_UPDATES_PER_HOUR
    | MAX_USER_CONNECTIONS | MEDIUM | MEMORY | MERGE | MID | MIGRATE
    | MIN_ROWS | MODE | MODIFY | MUTEX | MYSQL | NAME | NAMES
    | NCHAR | NEVER | NEXT | NO | NODEGROUP | NONE | OFFLINE | OFFSET
    | OJ | OLD_PASSWORD | ONE | ONLINE | ONLY | OPEN | OPTIMIZER_COSTS
    | OPTIONS | OWNER | PACK_KEYS | PAGE | PARSER | PARTIAL
    | PARTITIONING | PARTITIONS | PASSWORD | PHASE | PLUGINS
    | PLUGIN_DIR | PLUGIN | PORT | PRECEDES | PREPARE | PRESERVE | PREV
    | PROCESSLIST | PROFILE | PROFILES | PROXY | QUERY | QUICK
    | REBUILD | RECOVER | REDO_BUFFER_SIZE | REDUNDANT
    | RELAY | RELAYLOG | RELAY_LOG_FILE | RELAY_LOG_POS | REMOVE
    | REORGANIZE | REPAIR | REPLICATE_DO_DB | REPLICATE_DO_TABLE
    | REPLICATE_IGNORE_DB | REPLICATE_IGNORE_TABLE
    | REPLICATE_REWRITE_DB | REPLICATE_WILD_DO_TABLE
    | REPLICATE_WILD_IGNORE_TABLE | REPLICATION | RESET | RESUME
    | RETURNS | ROLLBACK | ROLLUP | ROTATE | ROW | ROWS
    | ROW_FORMAT | SAVEPOINT | SCHEDULE | SECURITY | SERIAL | SERVER
    | SESSION | SHARE | SHARED | SIGNED | SIMPLE | SLAVE
    | SLOW | SNAPSHOT | SOCKET | SOME | SONAME | SOUNDS | SOURCE
    | SQL_AFTER_GTIDS | SQL_AFTER_MTS_GAPS | SQL_BEFORE_GTIDS
    | SQL_BUFFER_RESULT | SQL_CACHE | SQL_NO_CACHE | SQL_THREAD
    | START | STARTS | STATS_AUTO_RECALC | STATS_PERSISTENT
    | STATS_SAMPLE_PAGES | STATUS | STOP | STORAGE | STRING
    | SUBJECT | SUBPARTITION | SUBPARTITIONS | SUSPEND | SWAPS
    | SWITCHES | TABLESPACE | TEMPORARY | TEMPTABLE | THAN | TRADITIONAL
    | TRANSACTION | TRIGGERS | TRUNCATE | UNDEFINED | UNDOFILE
    | UNDO_BUFFER_SIZE | UNINSTALL | UNKNOWN | UNTIL | UPGRADE | USER | USE_FRM | USER_RESOURCES
    | VALIDATION | VALUE | VARIABLES | VIEW | WAIT | WARNINGS | WITHOUT
    | WORK | WRAPPER | X509 | XA | XML
    | keywordsCanBeIdMysql
    ;

// keywordsCanBeId来源于mysql g4文件。如果对其他方言造成影响，请将关键词移到此处
keywordsCanBeIdMysql
    : {this.isDialect('mysql')}? EXTENDED | FUNCTION
    ;

inceptorKeywordCanBeId
    : ADMIN| ANALYZER | APP | APPS | APPLICATION | APPLICATIONS | BUCKETS
    | CAPACITY | CLUSTER | CLUSTERED | COLLECTION | CONCATENATE | CONNECT | CONF
    | DBPROPERTIES | DB2 | DEFAULT | DELIMITED | DIRECTORIES | DISTRIBUTE | EXTERNAL
    | FILEFORMAT | FORMATTED | FUNCTIONS | GROUPING | INCEPTOR | INNER | INPUTDRIVER | INPUTFORMAT | ITEMS
    | JAR | JARS | KEY | LINK | LINKS | LOCATION | LOCKS | MATERIALIZED
    | NOCYCLE | NORELY | NONSTRICT | NOVALIDATE | NO_DROP | NO_INDEX
    | ORACLE | OUTER | OUTPUTDRIVER | OUTPUTFORMAT | OVERWRITE | PACKAGE | PACKAGES | PARTITIONED
    | PERCENT | PERMANENT | PLSQL | PRETTY | POLICY | POLICIES | PRIOR | PROTECTION
    | READONLY | RELY | RULE | RULEBASE | RULEBASES | RULES | ROLE
    | SEMI2 | SEQUENCES | SERDE | SERDEPROPERTIES | SETS | SHARD
    | SKEWED | SORT | SORTED | STATISTICS | STREAMJOB | STREAMJOBS
    | TABLESIZE | TABLET | TBLPROPERTIES | TD | TOUCH | TRANSACTIONS | TYPE
    | UNARCHIVE | UNSET | VALIDATE
    ;

fileFormatCanBeId
    : fileFormatEnum
    | STARGATE
    ;

// hide logical keywords NOT, AND, OR. Because AND, OR does not support syntax like AND(col1, col2)
functionNameBase
    : ARRAY | AVG | BETWEEN | BINARY | CASE | CHAR | CHARSET | COLLATION | COUNT
    | CURRENT_DATE | CURRENT_TIME | CURRENT_TIMESTAMP | CURRENT_USER
    | DATE | DATE_ADD | DATE_SUB | DAY | DECIMAL | DENSE_RANK | DIV
    | EXISTS | EXTRACT | FORMAT | GEOMETRYCOLLECTION | GET_FORMAT | GROUP_CONCAT
    | HOUR | IF | IN | INDEX | INLINE | LEFT | LIKE | LINESTRING | LOCALTIME | LOG
    | MAP | MAX | MICROSECOND | MIN | MINUTE | MOD | MONTH | MULTILINESTRING | MULTIPOINT | MULTIPOLYGON
    | POINT | POLYGON | POSITION | QUARTER | REGEXP | REPEAT | REPLACE | REVERSE | RIGHT | RLIKE
    | SECOND | SPACE2 | STD | STDDEV | STDDEV_SAMP | STDDEV_POP | STRUCT | SUBSTR | SUBSTRING | SUM | SYSDATE | SYSTIMESTAMP
    | TIME | TIMESTAMP | TRIM | UNIONTYPE | VARCHAR | VARCHAR2 | VARIANCE | VAR_POP | VAR_SAMP
    | WEEK | WEIGHT_STRING | WHEN | YEAR
    | {this.isDialect('mysql')}? functionNameBaseMysql
    ;

// functionNameBase来源于mysql g4文件。如果对其他方言造成影响，请将关键词移到此处
functionNameBaseMysql
    : DATABASE
    ;

functionNameBaseExtra
    : AND | NOT | OR
    ;

// Defined Identifiers
databaseName
    : uid
    | emptyElement
      {
        this.notifyErrorListeners('Please provide database name');
      }
    ;

databaseNameAllowEmpty
    : uid
    | emptyElement
    ;

// Defined Helper Rule
baseElementAlias
    : AS? uid
    ;

emptyElement: '?'?;

placeholder: '?';


// PLSQL
plsqlStatement
    : anonymousBlock SEMI?
    | createFunctionBody SEMI?
    | createProcedureBody SEMI?
    | createPackage SEMI?
    | createPackageBody SEMI?
    ;

anonymousBlock
    locals [level: number = 0]
    : (DECLARE declareBlock)?
      seqStatementBlock[false]
    ;

createFunctionBody
    : CREATE (OR REPLACE)? functionBody
    ;

functionBody
    locals [
      newlineTokens: Array<string> = ['RETURN']
      noSpaceTokens: Array<string> = ['(']
      block: any = null
    ]
    @init {
      $ctx.block = this.generateBlockContext('(', ')', {newlineAfterStart: true})
    }
    : FUNCTION fullId
      '(' (parameter (',' parameter)*)? ')'
      RETURN typeSpec isOrAs
      blockStatement2
    ;

createProcedureBody
    : CREATE (OR REPLACE)? procedureBody
    ;

procedureBody
    locals [noSpaceTokens: Array<string> = ['(']]
    : PROCEDURE fullId
      '(' (parameter (',' parameter)*)? ')'
      isOrAs
      blockStatement2
    ;

// // Package DDLs

dropPackage
    : DROP PLSQL? PACKAGE ifExists? packName
    ;

createPackage
    locals [newlineTokens: Array<string> = ['DECLARE', 'END']]
    : CREATE (OR REPLACE)? PACKAGE fullId
      isOrAs DECLARE? packageObjSpecs?
      END uid?
    ;

createPackageBody
    locals [newlineTokens: Array<string> = ['DECLARE', 'END']]
    : CREATE (OR REPLACE)? PACKAGE BODY fullId
      isOrAs DECLARE? packageObjBodys?
      packageBodyBlock?
      END labelName?
    ;

isOrAs
    locals [level: number = 0]
    : IS | AS
    ;

// Create Package Specific Clauses

packageObjSpecs
    locals [level: number = 2]
    : (packageObjSpec SEMI?)+
    ;

packageObjBodys
    locals [level: number = 2]
    : (packageObjBody SEMI?)+
    ;

packageObjSpec
    locals [level: number = 0]
    : pragmaDeclaration
    | variableDeclaration
    | cursorDeclaration
    | exceptionDeclaration
    | typeDeclaration
    | procedureSpec
    | functionSpec
    ;

packageObjBody
    locals [level: number = 0]
    : pragmaDeclaration
    | variableDeclaration
    | cursorDeclaration
    | exceptionDeclaration
    | typeDeclaration
    | procedureBody
    | functionBody
    ;

procedureSpec
    : PROCEDURE uid '(' (parameter (',' parameter)*)? ')'
    ;

functionSpec
    : FUNCTION uid '(' (parameter (',' parameter)*)? ')'
      RETURN typeSpec
    ;

// Elements Declarations

declareSpec
    locals [level: number = 0]
    : pragmaDeclaration
    | variableDeclaration
    | cursorDeclaration
    | exceptionDeclaration
    | typeDeclaration
    ;

// incorporates constantDeclaration
variableDeclaration
    : uid CONSTANT? typeSpec (NOT NULL_LITERAL)?
      defaultValuePart?
    ;

cursorDeclaration
    locals [noSpaceTokens: Array<string> = ['(']]
    : CURSOR uid ('(' cursorParameter (',' cursorParameter)* ')' )?
      (RETURN typeSpec)? (IS selectStatement)?
    ;

cursorParameter
    : uid (IN? typeSpec)? defaultValuePart?
    ;

exceptionDeclaration
    : uid EXCEPTION
    ;

pragmaDeclaration
    : PRAGMA ( SERIALLY_REUSABLE
        | AUTONOMOUS_TRANSACTION
        | EXCEPTION_INIT '(' exceptionName ',' numericNegative ')'
      )
    ;

// Record Declaration Specific Clauses

// incorporates refCursorTypeDefinition

recordTypeDef
    : RECORD '(' fieldSpec (',' fieldSpec)* ')'
    ;

fieldSpec
    : uid typeSpec? (NOT NULL_LITERAL)? defaultValuePart?
    ;

refCursorTypeDef
    : REF CURSOR (RETURN typeSpec)?
    ;

typeDeclaration
    : TYPE uid IS
      ( tableTypeDef
        | varrayTypeDef
        | recordTypeDef
        | refCursorTypeDef
      )
    ;

tableTypeDef
    : TABLE OF typeSpec tableIndexedByPart? (NOT NULL_LITERAL)?
    ;

tableIndexedByPart
    : (idx1=INDEXED | idx2=INDEX) BY typeSpec
    ;

varrayTypeDef
    : VARRAY '(' expression ')' OF typeSpec (NOT NULL_LITERAL)?
    | VARYING ARRAY '(' expression ')' OF typeSpec (NOT NULL_LITERAL)?
    ;

// Statements

seqOfStatements
    locals [level: number = 0]
    : labelOrSqlStatement+
    ;

labelOrSqlStatement
    locals [level: number = 0]
    : procedureSqlStatement2 (SEMI? | EOF) | labelDeclaration
    ;

labelDeclaration
    locals [noSpaceTokens: Array<string> = ['<', '>']]
    : ltp1= '<' '<' labelName '>' '>'
    ;

procedureSqlStatement2
    : blockStatement2
    // TODO: assignmentStatement duplicate with expression
    | continueStatement
    | exitStatement
    | gotoStatement
    | ifStatement2
    | loopStatement2
    | forallStatement
    | nullStatement
    | raiseStatement
    | returnStatement2
    | normalSqlStatement
    | assignmentStatement
    | procedureWildcard
    ;

// TODO: fullId should be leftValue expression in inceptor.g4
//       allow record etc structure
assignmentStatement
    : generalElement ':=' expression
    ;

// wildcard also include call function and procedure
procedureWildcard
    : CALL? generalElement
    ;

continueStatement
    : CONTINUE labelName? (WHEN condition)?
    ;

exitStatement
    : EXIT labelName? (WHEN condition)?
    ;

gotoStatement
    : GOTO labelName
    ;

ifStatement2
    locals [
      level: number = 1
      block: any = null
    ]
    @init {
      $ctx.block = this.generateBlockContext('IF', ['END', 'IF'],
        {expand: true, backTopRules: this.getRuleIds('elsifPart', 'elsePart')})
    }
    : IF condition THEN seqOfStatements elsifPart* elsePart? END IF
    ;

elsifPart
    locals [
      level: number = 1
      block: any = null
    ]
    @init {
      $ctx.block = this.generateBlockContext('ELSIF', null, {expand: true})
    }
    : ELSIF condition THEN seqOfStatements
    ;

elsePart
    locals [
      level: number = 1
      block: any = null
    ]
    @init {
      $ctx.block = this.generateBlockContext('ELSE', null, {expand: true, newlineAfterStart: true})
    }
    : ELSE seqOfStatements
    ;

loopStatement2
    locals [
      level: number = 1
      block: any = null
    ]
    @init {
      $ctx.block = this.generateBlockContext('LOOP', ['END', 'LOOP'], {expand: true})
    }
    : labelDeclaration? (WHILE condition | FOR cursorLoopParam)? LOOP seqOfStatements END LOOP labelName?
    ;


// Loop Specific Clause

cursorLoopParam
    : uid IN REVERSE? lowerBound rangeSeparator='..' upperBound
    | uid IN (cursorName ('(' expressions? ')')? | '(' selectStatement ')')
    ;

forallStatement
    : FORALL uid IN boundsClause (SAVE EXCEPTIONS)? normalSqlStatement
    ;

// TODO: fullId is leftValue expression in inceptorOracle
boundsClause
    : lowerBound '..' upperBound
    | INDICES OF fullId betweenBound?
    ;

betweenBound
    : BETWEEN lowerBound AND upperBound
    ;

lowerBound
    : concatenation
    ;

upperBound
    : concatenation
    ;

nullStatement
    : NULL_LITERAL
    ;

// TODO: exceptionName leftValue
raiseStatement
    : RAISE exceptionName
    ;

returnStatement2
    : RETURN expression?
    ;

// Body Specific Clause

exceptionBlock
    locals [level: number = 2]
    : EXCEPTION exceptionHandler+
    ;

exceptionHandler
    locals [level: number = 2]
    : WHEN exceptionName (OR exceptionName)* (THEN seqOfStatements)?
      {
        this.checkContextExist($seqOfStatements.ctx, 'Please provide then handler statement')
      }
    ;

blockStatement2
    locals [level: number = 0]
    : DECLARE? declareBlock?
      seqStatementBlock[true]
    ;

declareBlock
    locals [
      level: number = 2
    ]
    : (declareSpec SEMI?)+
    ;

seqStatementBlock[withLabel: boolean]
    locals [
      level: number = 0
      block: any = null
    ]
    @init {
      $ctx.block = this.generateBlockContext('BEGIN', 'END',
        {expand: true, backTopRules: this.getRuleIds('exceptionBlock')})
    }
    : BEGIN seqOfStatements
      exceptionBlock?
      END labelName?
      {
        if (!$ctx.withLabel && $labelName.ctx) {
          this.notifyErrorListeners('No label name allowed');
        }
      }
    ;

packageBodyBlock
    locals [
      level: number = 0
      block: any = null
    ]
    @init {
      $ctx.block = this.generateBlockContext('BEGIN', null,
        {expand: true, backTopRules: this.getRuleIds('exceptionBlock')})
    }
    : BEGIN seqOfStatements
      exceptionBlock?
    ;

parameter
    : uid (IN | OUT | INOUT | NOCOPY)* typeSpec? defaultValuePart?
    ;

// PL/SQL Specs

// 一般的对plsql定义的变量和变量成员的获取
generalElement
    : generalElementPart generalElementPartChain*
    ;

generalElementPart
    : idExpression generalArgument?
    ;

generalElementPartChain
    : chainedIdExpression? generalArgument
    | chainedIdExpression generalArgument?
    ;

generalArgument
    locals [noSpaceBetween: boolean = true]
    : functionArgument | arrayArgument
    ;

functionArgument
    : '(' (argument (',' argument)*)? ')'
    ;

argument
    : (uid '=' '>')? expression
    ;

arrayArgument
    : '[' expression ']'
    ;

// TODO: check datatype. uid is leftValue in inceptor.g4
typeSpec
    locals [noSpaceTokens: Array<string> = ['%']]
    : dataType
    | REF? uid dottedId*
      ('%'
        (TYPE | ROWTYPE)
      )?
    ;

defaultValuePart
    : (':=' | DEFAULT) expression
    ;

labelName
    : uid
    ;

numeric
    // : UNSIGNED_INTEGER
    // | APPROXIMATE_NUM_LIT
    : DECIMAL_LITERAL
    | REAL_LITERAL
    ;

numericNegative
    locals [noSpaceTokens: Array<string> = ['-']]
    : '-' numeric
    ;

exceptionName
    : tripleId
    | emptyElement
      {
        this.notifyErrorListeners('Please exception name');
      }
    ;

routineName
    : uid dottedId*
    ;

// move wrong syntax rule first is to make sure idExpression is parsed as whole.
// otherwise, `aaa.` will be parsed as `aaa`(generalElementPart) `.`(generalElementPartChain)
idExpression
    : uid dottedId* '.'
    {
      this.notifyErrorListeners('Please provide expression after `.`');
    }
    | uid dottedId*
    ;

chainedIdExpression
    : dottedId dottedId*
    | dottedId* '.'
    {
      this.notifyErrorListeners('Please provide expression after `.`');
    }
    ;

// TODO: cursorName should be leftValue expression in inceptor.g4
cursorName
    : fullId
    ;

partitionExtensionClause
    : (SUBPARTITION | PARTITION) FOR? '(' expressions? ')'
    ;

condition
    : expression
    ;

normalSqlStatement
    locals [level: number = 0]
    : executeImmediate
    | dmlStatement
    | cursorManipulationStatements
    | transactionStatement
    ;

executeImmediate
    : EXECUTE IMMEDIATE expression bulkCollectClause? usingClause?
    ;

bulkCollectClause
    locals [level: number = 0]
    : (BULK COLLECT)? INTO expressions
    ;

usingClause
    locals [level: number = 0]
    : USING usingClauseElement (',' usingClauseElement)*
    ;

usingClauseElement
    : (IN | OUT | INOUT | NOCOPY) expression
    ;

// Cursor Manipulation Statements

cursorManipulationStatements
    locals [level: number = 0]
    : closeStatement
    | openStatement
    | fetchStatement
    | openForStatement
    ;

closeStatement
    : CLOSE cursorName
    ;

openStatement
    locals [noSpaceTokens: Array<string> = ['(']]
    : OPEN cursorName ('(' expressions? ')')?
    ;

// TODO: fullId should be expression in inceptor.g4
fetchStatement
    locals [newlineTokens: Array<string> = ['BULK']]
    : FETCH cursorName (BULK COLLECT)? INTO tripleId (',' tripleId)* limitClause?
    ;

openForStatement
    : OPEN cursorName FOR (selectStatement | expression) usingClause?
    ;


// TODO: plsql concatenation rule is very different
concatenation
    : expression
    ;
