# aoc-liferay-import

## Running the Script
1. Using Liferay sync the `images` directory from www.chicagocatholic.com 

2. Using MySQLWorkbench export the result of `SELECT groupId,parentFolderId,folderId,treePath,name FROM aoc_default_portal.DLFolder;` query to `json/image_folders.json`.

3. Using MySQLWorkbench export the result of `SELECT uuid_,treePath,title FROM aoc_default_portal.DLFileEntry;` query to `json/images.json`.

4. Execute `$ rake api:all` in your terminal. (Use `$ rake --tasks` to see all options)


### Broken Objects
Broken Columns

- 408
- 411
- 444
- 445
- 510
- 526
- 634

Broken Publications

- 251
- 639
- 839
- 967