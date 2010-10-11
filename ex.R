library(mongor)

mc = mongoConnect()
mongoFind(mc, list(hello='world'))
mongoFind(mc, list(good='evening'))
mongoFind(mc, list(better='evening'))
mongoInsert(mc, list(key="valley", ehat = 43))
mongoFind(mc, list(ehat = 43))
