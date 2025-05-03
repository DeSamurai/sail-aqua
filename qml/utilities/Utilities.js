function getAm() {
    var amount = DB.getAmount(DB.today())
    if (amount >= 0) {
        return amount;
    } else {
        return amount = 0
    }
}

function targetCount() {
    return DB.getWeight() * 33
}
