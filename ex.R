library(mongor)

mc = mongoConnect()
mongoQuery(mc, list(hello='world'))
mongoQuery(mc, list(good='evening'))
mongoQuery(mc, list(better='evening'))
mongoInsert(mc, list(key="valley", ehat = 43))
mongoQuery(mc, list(ehat = 43))
