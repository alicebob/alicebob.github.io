{"title":"Introducing SQLittle"}
---
<div class="date"> 
Berlin, April 2018
</div>

The last week I wrote SQLittle. SQLittle is a pure Go, low level, .sqlite file
reader library.

The low level part is that it doesn't give you access via SQL, but that it
gives you the methods to efficiently iterate and search the tables and indexes
in an .sqlite file. It also let you list and inspect the tables and indexes in
the file. And as a final piece of the puzzle there are read locks, which are
compatible with sqlite.

In theory this should be enough to build a pure Go SQL engine on top of this...

Progress was pretty smooth. The SQLite project has good documentation about the
file format and the locks, so there were not too many problems. The format is
about 20 year old, so there are some things which can be done simpler
nowadays, but nothing too weird.

Code: [alicebob/sqlittle](https://github.com/alicebob/sqlittle)
with additional tests in [alicebob/sqlittle-ci](https://github.com/alicebob/sqlittle-ci)

Docs: [godoc](https://godoc.org/github.com/alicebob/sqlittle)

Reddit: [r/golang](https://www.reddit.com/r/golang/comments/89ivkx/sqlittle_pure_go_sqlite_file_reader/)
