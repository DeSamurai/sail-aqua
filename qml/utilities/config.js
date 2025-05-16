function today() {
    var day = new Date().toLocaleDateString(Qt.locale(), "yyyy-MM-dd")
    return day;
}

function yest() {
    var day = new Date(new Date() - 864e5).toLocaleDateString(Qt.locale(), "yyyy-MM-dd")
    return day;
}

function getDatabase() {
    return LocalStorage.openDatabaseSync("aqua", "1.0", "StorageDatabase", 10000000);
}

function getAmount(day) {
    var db = getDatabase();
    var amountW="";
    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT SUM(amount) as soucet FROM water WHERE day=?', [day]);
            if (rs.rows.length > 0) {
                amountW += rs.rows.item(0).soucet
            } else {
                amountW = 0
            }
        })
    } catch (err) {
        amountW = "unknown"
    }
    return amountW
}

function getStat() {
    var db = getDatabase();
    var stat="";
    var text;
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT strftime("%d.%m.%Y", day) AS den, SUM(amount) as soucet FROM water GROUP BY day ORDER BY day DESC');
        for(var i = 0; i < rs.rows.length; i++) {
            stat += rs.rows.item(i).den +" consumed " + rs.rows.item(i).soucet + " ml \n"
        }
    })
    return stat
}

function getAllData() {
    var db = getDatabase();
    var stat="";
    var text;
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT strftime("%d.%m.%Y", day) AS den, amount FROM water ORDER BY day DESC');
        for(var i = 0; i < rs.rows.length; ++i) {
            stat += rs.rows.item(i).den +" consumed " + rs.rows.item(i).amount + " ml \n"
        }
    })
    return stat
}

function getWeight() {
    var db = getDatabase();
    var amountW="";
    try {
        db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT weight FROM you');
            if (rs.rows.length > 0) {
                amountW += rs.rows.item(0).weight
            } else {
                amountW = ""
            }
        })
    } catch (err) {
        amountW = ""
    }
    return amountW
}

function addYou(weight) {
    var db = getDatabase();
    var res = ""
    var rs = ""
    db.transaction(function(tx) {
        try {
            if (getWeight() === 0) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS you(weight INTEGER)');
                rs = tx.executeSql('INSERT INTO you VALUES(?)', [weight]);
            } else {
                tx.executeSql('DROP TABLE you');
                tx.executeSql('CREATE TABLE IF NOT EXISTS you(weight INTEGER)');
                rs = tx.executeSql('INSERT INTO you VALUES(?)', [weight]);
            }
        } catch (err) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS you(weight INTEGER)');
            rs = tx.executeSql('INSERT INTO you VALUES(?)', [weight]);
        }

        if (rs.rowsAffected > 0) {
            res = "OK";
            //console.log("Saved to database - "+weight);
        } else {
            res = "Error";
            //console.log("Error of saving");
        }
    });
    return res;
}

function addAmount(day,amount) {
    var db = getDatabase();
    var res = ""
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS water(day DATE, amount INTEGER)');
        var rs = tx.executeSql('INSERT INTO water VALUES(?,?)', [day,amount]);

        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    });
    return res;
}

function delAmount(day,amount) {
    var db = getDatabase();
    var res = ""
    db.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM water WHERE day=? AND amount=?', [day,amount]);

        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    });
    return res;
}

function deleteButtons() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    tx.executeSql('DROP TABLE buttons');
                });
}
