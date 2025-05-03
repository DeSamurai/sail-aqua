function percent(targetCount, getAm) {
    var numb = getAm() / targetCount() * 100
    numb = numb.toFixed(0)
    if (numb >= 0) {
        return percentage.text = "That's "+ numb + " % of your target."
    } else {
        return percentage.text = "You must add your weight in settings."
    }
}

function targetToday(targetCount) {
    var tg = targetCount()
    if (tg >= 0) {
       target.text = "Your target is "+ tg +" ml."
       return target.text;
    } else {
       return target.text = ""
    }
}

function textToday(getAm) {
    return today.text = "Consumed today "+getAm()+" ml.";
}

function send(amountOfWater, getAm, targetCount) {
    if (choose === 0) {
        DB.addAmount(DB.today(),amountOfWater)
    } else {
        DB.addAmount(DB.yest(),amountOfWater)
    }
    textToday(getAm)
    percent(targetCount, getAm)
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
