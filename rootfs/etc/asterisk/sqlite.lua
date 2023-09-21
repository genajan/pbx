require 'luasql.sqlite3'
function opendb(dbname)
    -- Check for Settings Database and create if needed
    local dbname = "pbxdb"
    local dbenv = assert (luasql.sqlite3())
    -- connect to data source, if the file does not exist it will be created
    dbcon = assert (dbenv:connect(db))
    -- check table for page list
    checkTable(dbcon,'routing','CREATE TABLE routing(src varchar(20), dstNum varchar(20), dstName varchar(20))')
    return dbenv,dbcon
end
function checkTable(dbcon,table,createString)
    local sql = string.format([[SELECT count(name) as count FROM sqlite_master WHERE type='table' AND name='%s']],table)
    local cur = assert(dbcon:execute(sql))
    local rowcount = cur:fetch (row, "a")
    cur:close()
    if tonumber(rowcount) == 0 then
        -- Table not found create it
        res,err = assert(dbcon:execute(createString))
    end
end
function closedb(dbenv,dbcon)
    dbcon:close()
    dbenv:close()
end
function getRoute(dbcon)
    rv = {}
    local sql = "SELECT dstNum FROM routing"
    local cur,err = assert(dbcon:execute(sql))
    local row = cur:fetch({},'a')
    cur:close()
    if row then
        rv row
    end
    return rv
end
function setRoute(dbcon,route)
    local sql = string.format("insert or replace into routing (src, dstNum, dstName) values (route.src, route.dstNum, route.dstName)")
    local res = assert(dbcon:execute(sql))
end