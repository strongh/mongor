library(mongor)

mc = mongoConnect()
mongoQuery(mc, list(hello='world'))
