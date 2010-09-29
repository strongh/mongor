library(mongor)

mc = mongoConnect()
mongoQuery(mc, list(hello='world'))
mongoQuery(mc, list(good='evening'))
mongoQuery(mc, list(better='evening'))
mongoInsert(mc, list(new='hotshit'))
mongoQuery(mc, list(new='hotshit'))
