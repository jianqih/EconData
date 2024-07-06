using ReadStat
using StatFiles
using Statistics
using DataFrames
using DataFramesMeta
df = DataFrame(load("BL_v3_MF1564.dta"))

dsc = describe(df);
dsc

mapcols(df -> sum(ismissing.(df)), df)
# dropmissing(df, :yr_sch)