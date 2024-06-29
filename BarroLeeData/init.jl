using ReadStat
using StatFiles
using Statistics
using DataFrames
using Plots
using DataFramesMeta
using AlgebraOfGraphics
using CairoMakie
using StatsPlots
# df = read_dta("BL_v3_MF1564.dta")
df = DataFrame(load("BL_v3_MF1564.dta"))
gd_country = groupby(df,[:country]);
df_means = combine(gd_country, :yr_sch => mean, :yr_sch_pri => mean, :yr_sch_sec => mean, :yr_sch_ter => mean);

data_mean_layer = data(df_means)
dm_mapping_layer = mapping(:yr_sch_pri_mean,:yr_sch_sec_mean)
dm_visual_layer = visual(Scatter)
p_mean = data_mean_layer * dm_mapping_layer * (dm_visual_layer + linear());
draw(p_mean)


mapping_layer2 = mapping(:yr_sch_pri_mean, :yr_sch_ter_mean)
p2 = data_mean_layer * mapping_layer2 * (dm_visual_layer + linear());
draw(p2)
save("scatter_plot.png",draw(p2))

gd_year = groupby(df, [:year]);
df_year_means = combine(gd_year, :yr_sch_pri => mean, :yr_sch_sec => mean, :yr_sch_ter => mean);    
ticklabel = string.(collect('A':'L'))
groupedbar(df_year_means.year, Matrix(df_year_means[:, end:-1:2]),
    bar_position=:stack,
    bar_width=2.0,
    xticks=:year,
    title = "Mean Schooling Years",
    label=["school teritory mean" "school second mean" "school primary mean"])
savefig("mean_schooling_years.png")