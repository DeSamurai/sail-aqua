function percent() {
    var numb = Util.getAm() / Util.targetCount() * 100
    numb = numb.toFixed(0)
    if (numb >= 0) {
        return percentage.text = "That's "+ numb + " % of your target."
    } else {
        return percentage.text = "You must add your weight in settings."
    }
}

function targetToday() {
    var tg = Util.targetCount()
    if (tg >= 0) {
       target.text = "Your target is "+ tg +" ml."
       return target.text;
    } else {
       return target.text = ""
    }
}

function textToday() {
    return today.text = "Consumed today "+Util.getAm()+" ml.";
}

function send(amountOfWater) {
    if (choose === 0) {
        DB.addAmount(DB.today(),amountOfWater)
    } else {
        DB.addAmount(DB.yest(),amountOfWater)
    }
    textToday(Util.getAm)
    percent(Util.targetCount, Util.getAm)
}

function del(amountOfWater) {
    if (choose === 0) {
        DB.delAmount(DB.today(),amountOfWater)
    } else {
        DB.delAmount(DB.yest(),amountOfWater)
    }
    textToday()
    percent()
}
