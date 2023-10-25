from datetime import datetime
import polars as pl

categories_df = pl.read_json("tmp/categories.json")
videos_df = pl.read_csv("tmp/videos.csv", try_parse_dates=True)

categories = (
    categories_df
    .select("items")
    .explode("items")
    .unnest("items")
    .unnest("snippet")
    .select(
        pl.col("id").cast(pl.Int64),
        pl.col("title")
    )
)

videos = (
    videos_df
    .unique(subset=["title", "channelTitle"])
    .select(
        pl.col("categoryId"),
        pl.col("title").str.replace_all("'", "\\'").str.strip_chars(),
        pl.col("channelTitle").str.replace_all("'", "\\'").str.strip_chars(),
        (pl.col("publishedAt").dt.date() - datetime(2020, 8, 6)).dt.days(),
        (pl.col("likes") / pl.col("view_count")).alias("lpv"),
    )
)

videos_with_categories = (
    videos
    .join(categories, left_on="categoryId", right_on="id", how="inner")
    .select(
        pl.all().exclude("categoryId", "title_right"),
        pl.col("title_right").alias("category"),
    )
)

categories_pl = [
    f"category('{c}')." for (c,) in (
        categories
        .select("title")
        .sort("title")
        .iter_rows()
    )
]

channels_pl = [
    f"channel('{c}')." for (c,) in (
        videos
        .select("channelTitle")
        .unique()
        .sort("channelTitle")
        .iter_rows()
    )
]

videos_pl = [
    f"video('{cat}', '{chan}', '{title}', {off}, {lpv})."
    for (cat, chan, title, off, lpv)
    in (
        videos_with_categories
        .select("category", "channelTitle", "title", "publishedAt", "lpv")
        .unique()
        .sort("category", "channelTitle", "publishedAt")
        .iter_rows()
    )
]

print("% categorias")
print("\n".join(categories_pl))
print()

print("% canais")
print("\n".join(channels_pl))
print()

print("% videos")
print("\n".join(videos_pl))
print()
