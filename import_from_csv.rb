require_relative './public/feature_1/db_populate'

DbPopulate.db_populate_from_csv('./public/feature_1/data.csv')

$connect_pg.close