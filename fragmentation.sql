SELECT
  S.name as 'Schema'
  , tbl.schema_id Schemaname
, idx.name IndexName, idx.fill_factor
, CAST(Fragmentation.avg_page_space_used_in_percent AS DECIMAL(4,1)) ActualFillFactor
, CAST(Fragmentation.avg_fragmentation_in_percent AS DECIMAL(4,1)) CurrentFragmentation
, Fragmentation.fragment_count
, CAST(Fragmentation.avg_fragment_size_in_pages AS DECIMAL(8,1)) AvgFragmentSize 
FROM
  sys.tables tbl
    INNER JOIN
  sys.indexes idx ON tbl.object_id = idx.object_id
    CROSS APPLY
  sys.dm_db_index_physical_stats(DB_ID(), tbl.object_id, idx.index_id, 0, 'SAMPLED') Fragmentation
  INNER JOIN sys.schemas S on tbl.schema_id = S.schema_id
WHERE 1=1
--and  tbl.name LIKE 'Auth_CACHE'
and fragment_count > 10000
  order by CurrentFragmentation desc;
