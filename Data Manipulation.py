import pandas as pd

metadata = pd.read_csv('movies_metadata.csv')

#2
metadata_filtered = metadata[(metadata.original_language == 'en') & (metadata.revenue > 0) & (metadata.budget > 0)]

#3
ratings = pd.read_csv('ratings.csv')
print(ratings)
average_rating = ratings.groupby('movieId').rating.mean()
print(average_rating)

# Cleaning data
links = pd.read_csv('links.csv')
metadata_filtered.imdb_id = metadata_filtered.imdb_id.str.replace('tt0', '').str.replace('tt', '')
metadata_filtered.imdb_id = metadata_filtered.imdb_id.astype(int)

# Merging data
ratings_links = pd.merge(left=average_rating, right=links, on='movieId')

merged = pd.merge(left=ratings_links, right=metadata_filtered.rename(columns={'imdb_id':'imdbId'}), on='imdbId')
print(merged)

#4 Continued at R
merged.to_csv('merged.csv')
