# svnwcrev
A "SubWCRev" look a like for Linux.
It has less features than the original, but worked fine for my needs in the last 10 years or so.

Source code saved from svnwcrev.tigris.org

These are the sources I've got from svnwcrev.tigris.org many years back.
The binaries I compiled in ~2015 still worked with Ubuntu 20.04, but now 
I've got an issue with some files that the tool tries to translate to UTF-8, 
even when they are binary files. That triggered to look for updates, just to 
find out that tigris is dead since 2020.

Looks like my copies are the latest that can be found in the net. Therefore I 
think it is just fair to share what I've got.

## Similar tools
One of these might replace svnwcrev.

- Python tool, looks very promising https://github.com/nickveys/pysubwcrev

- Python tool, good for git-svn https://github.com/eibach/subwcrev-git

- Similar tool for git, written in csharp https://github.com/realloc-dev/gitrev

- Similar tool for git, written in Rust https://github.com/kubkon/gitrev

- There is a python program used by the Freecad team internally.
Could be a good start for a new tool. Misses many keywords though.
https://github.com/FreeCAD/FreeCAD/blob/master/src/Tools/SubWCRev.py

- And I also found SvnRev, but this is quite different from SubWCRev.
https://www.compuphase.com/svnrev.htm

- This shell script might also fit your needs if you only need the revision.
Found at 
https://stackoverflow.com/questions/62160158/searching-old-code-that-was-hosted-on-tigris-org-svnwcrev-1-0-tar-gz

		printf '{"%s","%d",""}' $(svn info $1 --show-item=url) $(svn info $1 --show-item=revision)
## Build on Ubuntu (20.04)

- sudo apt install libsvn-dev (currently this is version 1.13.0-3ubuntu0.2)
- Navigate into the root of the project (were the Makefile is located).
- make
- copy the new generated svnwcrev to /usr/local/bin
- optionally create symlinks for similar names in case you share makefiles between Windows and Linux.
	(subwcrev, ...)

## Examples
Find a few examples in the directory FirstTests.

## Errors with UTF-8
These errors look like it does try to translate all files to UTF-8 first.
Fatal for binary files. I wonder why I have not seen that years ago, my projects for sure did contain binary files.
The files in question must be checked into svn. Others seem to not care.

	svnwcrev . svn_rev.tmpl svn_rev.scad
	svnwcrev : E000022: Error converting entry in directory '/xxxx/FilamentBox/DryBoxParts/Desiccant+Hexbox' to UTF-8
	svnwcrev : E000022: Can't convert string from native encoding to 'UTF-8':
	svnwcrev : E000022: {U+00A7}MF
	Last committed at revision 0
	Updated to revision 0

Similar errors occur with Freecad files:

	svnwcrev : E000022: Can't convert string from 'UTF-8' to native encoding:
	svnwcrev : E000022: /xxxx/Projects/3D/FilamentBox/DryBoxPartsFreecad/Clips-Nestabox/Hoehe.FCStd
	Last committed at revision 0
	Updated to revision 0


## Build log
There are quite some warnings, but at least it builds.

	$ make
	
	g++ -E -MM -I/usr/include/subversion-1 -I/usr/include/apr-1.0 -MT "src/SVNWcRev.o src/SVNWcRev.d " src/SVNWcRev.cpp > src/SVNWcRev.d;
	g++ -E -MM -I/usr/include/subversion-1 -I/usr/include/apr-1.0 -MT "src/status.o src/status.d " src/status.cpp > src/status.d;
	( /bin/echo -ne "\x23define SVNWCREV_VERSION \x221.1, Build "; svnversion -n .; /bin/echo -e "\x22" )> src/version.h
	g++ -E -MM -I/usr/include/subversion-1 -I/usr/include/apr-1.0 -MT "src/SVNWcRev.o src/SVNWcRev.d " src/SVNWcRev.cpp > src/SVNWcRev.d;
	g++ -g3 -I/usr/include/subversion-1 -I/usr/include/apr-1.0  -c -o src/status.o src/status.cpp
	g++ -g3 -I/usr/include/subversion-1 -I/usr/include/apr-1.0  -c -o src/SVNWcRev.o src/SVNWcRev.cpp
	src/status.cpp: In function ‘svn_error_t* svn_status(const char*, void*, svn_boolean_t, svn_client_ctx_t*, apr_pool_t*)’:
	src/status.cpp:155:76: warning: ‘svn_wc_traversal_info_t* svn_wc_init_traversal_info(apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	155 |  svn_wc_traversal_info_t *traversal_info = svn_wc_init_traversal_info (pool);
	|                                                                            ^
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:718:1: note: declared here
	718 | svn_wc_init_traversal_info(apr_pool_t *pool);
	| ^~~~~~~~~~~~~~~~~~~~~~~~~~
	src/status.cpp:155:76: warning: ‘svn_wc_traversal_info_t* svn_wc_init_traversal_info(apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	155 |  svn_wc_traversal_info_t *traversal_info = svn_wc_init_traversal_info (pool);
	|                                                                            ^
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:718:1: note: declared here
	718 | svn_wc_init_traversal_info(apr_pool_t *pool);
	| ^~~~~~~~~~~~~~~~~~~~~~~~~~
	src/status.cpp:166:25: warning: ‘void svn_utf_initialize(apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	166 |  svn_utf_initialize(pool);
	|                         ^
	In file included from src/status.cpp:25:
	/usr/include/subversion-1/svn_utf.h:77:1: note: declared here
	77 | svn_utf_initialize(apr_pool_t *pool);
	| ^~~~~~~~~~~~~~~~~~
	src/status.cpp:166:25: warning: ‘void svn_utf_initialize(apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	166 |  svn_utf_initialize(pool);
	|                         ^
	In file included from src/status.cpp:25:
	/usr/include/subversion-1/svn_utf.h:77:1: note: declared here
	77 | svn_utf_initialize(apr_pool_t *pool);
	| ^~~~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:170:86: warning: ‘svn_error_t* svn_wc_adm_probe_open3(svn_wc_adm_access_t**, svn_wc_adm_access_t*, const char*, svn_boolean_t, int, svn_cancel_func_t, void*, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	170 |  SVN_ERR (svn_wc_adm_probe_open3 (&adm_access, NULL, path, FALSE, 0, NULL, NULL, pool));
	|                                                                                      ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:343:1: note: declared here
	343 | svn_wc_adm_probe_open3(svn_wc_adm_access_t **adm_access,
	| ^~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:170:86: warning: ‘svn_error_t* svn_wc_adm_probe_open3(svn_wc_adm_access_t**, svn_wc_adm_access_t*, const char*, svn_boolean_t, int, svn_cancel_func_t, void*, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	170 |  SVN_ERR (svn_wc_adm_probe_open3 (&adm_access, NULL, path, FALSE, 0, NULL, NULL, pool));
	|                                                                                      ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:343:1: note: declared here
	343 | svn_wc_adm_probe_open3(svn_wc_adm_access_t **adm_access,
	| ^~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:175:62: warning: ‘svn_error_t* svn_wc_entry(const svn_wc_entry_t**, const char*, svn_wc_adm_access_t*, svn_boolean_t, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	175 |  SVN_ERR (svn_wc_entry (&entry, path, adm_access, FALSE, pool));
	|                                                              ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:3172:1: note: declared here
	3172 | svn_wc_entry(const svn_wc_entry_t **entry,
	| ^~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:175:62: warning: ‘svn_error_t* svn_wc_entry(const svn_wc_entry_t**, const char*, svn_wc_adm_access_t*, svn_boolean_t, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	175 |  SVN_ERR (svn_wc_entry (&entry, path, adm_access, FALSE, pool));
	|                                                              ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:3172:1: note: declared here
	3172 | svn_wc_entry(const svn_wc_entry_t **entry,
	| ^~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:178:66: warning: ‘svn_error_t* svn_wc_get_actual_target(const char*, const char**, const char**, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	178 |   SVN_ERR (svn_wc_get_actual_target (path, &anchor, &target, pool));
	|                                                                  ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:5736:1: note: declared here
	5736 | svn_wc_get_actual_target(const char *path,
	| ^~~~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:178:66: warning: ‘svn_error_t* svn_wc_get_actual_target(const char*, const char**, const char**, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	178 |   SVN_ERR (svn_wc_get_actual_target (path, &anchor, &target, pool));
	|                                                                  ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:5736:1: note: declared here
	5736 | svn_wc_get_actual_target(const char *path,
	| ^~~~~~~~~~~~~~~~~~~~~~~~
	src/status.cpp:187:47: warning: ‘void svn_path_split(const char*, const char**, const char**, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	187 |   svn_path_split (path, &anchor, &target, pool);
	|                                               ^
	In file included from src/status.cpp:24:
	/usr/include/subversion-1/svn_path.h:243:1: note: declared here
	243 | svn_path_split(const char *path,
	| ^~~~~~~~~~~~~~
	src/status.cpp:187:47: warning: ‘void svn_path_split(const char*, const char**, const char**, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	187 |   svn_path_split (path, &anchor, &target, pool);
	|                                               ^
	In file included from src/status.cpp:24:
	/usr/include/subversion-1/svn_path.h:243:1: note: declared here
	243 | svn_path_split(const char *path,
	| ^~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:192:39: warning: ‘svn_error_t* svn_wc_adm_close(svn_wc_adm_access_t*)’ is deprecated [-Wdeprecated-declarations]
	192 |  SVN_ERR (svn_wc_adm_close (adm_access));
	|                                       ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:545:1: note: declared here
	545 | svn_wc_adm_close(svn_wc_adm_access_t *adm_access);
	| ^~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:192:39: warning: ‘svn_error_t* svn_wc_adm_close(svn_wc_adm_access_t*)’ is deprecated [-Wdeprecated-declarations]
	192 |  SVN_ERR (svn_wc_adm_close (adm_access));
	|                                       ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:545:1: note: declared here
	545 | svn_wc_adm_close(svn_wc_adm_access_t *adm_access);
	| ^~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:196:89: warning: ‘svn_error_t* svn_wc_adm_probe_open3(svn_wc_adm_access_t**, svn_wc_adm_access_t*, const char*, svn_boolean_t, int, svn_cancel_func_t, void*, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	196 |  SVN_ERR (svn_wc_adm_probe_open3 (&adm_access, NULL, anchor, FALSE, -1, NULL, NULL, pool));
	|                                                                                         ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:343:1: note: declared here
	343 | svn_wc_adm_probe_open3(svn_wc_adm_access_t **adm_access,
	| ^~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:196:89: warning: ‘svn_error_t* svn_wc_adm_probe_open3(svn_wc_adm_access_t**, svn_wc_adm_access_t*, const char*, svn_boolean_t, int, svn_cancel_func_t, void*, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	196 |  SVN_ERR (svn_wc_adm_probe_open3 (&adm_access, NULL, anchor, FALSE, -1, NULL, NULL, pool));
	|                                                                                         ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:343:1: note: declared here
	343 | svn_wc_adm_probe_open3(svn_wc_adm_access_t **adm_access,
	| ^~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:204:33: warning: ‘svn_error_t* svn_wc_get_status_editor2(const svn_delta_editor_t**, void**, void**, svn_revnum_t*, svn_wc_adm_access_t*, const char*, apr_hash_t*, svn_boolean_t, svn_boolean_t, svn_boolean_t, svn_wc_status_func2_t, void*, svn_cancel_func_t, void*, svn_wc_traversal_info_t*, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	204 |             traversal_info, pool));
	|                                 ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:4396:1: note: declared here
	4396 | svn_wc_get_status_editor2(const svn_delta_editor_t **editor,
	| ^~~~~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:204:33: warning: ‘svn_error_t* svn_wc_get_status_editor2(const svn_delta_editor_t**, void**, void**, svn_revnum_t*, svn_wc_adm_access_t*, const char*, apr_hash_t*, svn_boolean_t, svn_boolean_t, svn_boolean_t, svn_wc_status_func2_t, void*, svn_cancel_func_t, void*, svn_wc_traversal_info_t*, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	204 |             traversal_info, pool));
	|                                 ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:4396:1: note: declared here
	4396 | svn_wc_get_status_editor2(const svn_delta_editor_t **editor,
	| ^~~~~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:208:39: warning: ‘svn_error_t* svn_wc_adm_close(svn_wc_adm_access_t*)’ is deprecated [-Wdeprecated-declarations]
	208 |  SVN_ERR (svn_wc_adm_close (adm_access));
	|                                       ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:545:1: note: declared here
	545 | svn_wc_adm_close(svn_wc_adm_access_t *adm_access);
	| ^~~~~~~~~~~~~~~~
	In file included from /usr/include/subversion-1/svn_types.h:1271,
	from /usr/include/subversion-1/svn_client.h:42,
	from src/status.cpp:22:
	src/status.cpp:208:39: warning: ‘svn_error_t* svn_wc_adm_close(svn_wc_adm_access_t*)’ is deprecated [-Wdeprecated-declarations]
	208 |  SVN_ERR (svn_wc_adm_close (adm_access));
	|                                       ^
	/usr/include/subversion-1/svn_error.h:353:35: note: in definition of macro ‘SVN_ERR’
	353 |     svn_error_t *svn_err__temp = (expr);        \
	|                                   ^~~~
	In file included from /usr/include/subversion-1/svn_client.h:44,
	from src/status.cpp:22:
	/usr/include/subversion-1/svn_wc.h:545:1: note: declared here
	545 | svn_wc_adm_close(svn_wc_adm_access_t *adm_access);
	| ^~~~~~~~~~~~~~~~
	src/SVNWcRev.cpp: In function ‘int InsertRevision(char*, char*, size_t&, size_t&, size_t, long int, long int, SubWCRev_t*)’:
	src/SVNWcRev.cpp:181:28: warning: format ‘%LX’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘long int’ [-Wformat=]
	181 |        sprintf(destbuf, "%LX", (apr_int64_t)MaxRev);
	|                          ~~^   ~~~~~~~~~~~~~~~~~~~
	|                            |   |
	|                            |   long int
	|                            long long unsigned int
	|                          %lX
	src/SVNWcRev.cpp:183:29: warning: format ‘%LX’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘long int’ [-Wformat=]
	183 |        sprintf(destbuf, "%#LX", (apr_int64_t)MaxRev);
	|                          ~~~^   ~~~~~~~~~~~~~~~~~~~
	|                             |   |
	|                             |   long int
	|                             long long unsigned int
	|                          %#lX
	src/SVNWcRev.cpp:185:28: warning: format ‘%Ld’ expects argument of type ‘long long int’, but argument 3 has type ‘long int’ [-Wformat=]
	185 |        sprintf(destbuf, "%Ld", (apr_int64_t)MaxRev);
	|                          ~~^   ~~~~~~~~~~~~~~~~~~~
	|                            |   |
	|                            |   long int
	|                            long long int
	|                          %ld
	src/SVNWcRev.cpp:190:26: warning: format ‘%LX’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘long int’ [-Wformat=]
	190 |      sprintf(destbuf, "%LX:%LX", (apr_int64_t)MinRev, (apr_int64_t)MaxRev);
	|                        ~~^       ~~~~~~~~~~~~~~~~~~~
	|                          |       |
	|                          |       long int
	|                          long long unsigned int
	|                        %lX
	src/SVNWcRev.cpp:190:30: warning: format ‘%LX’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘long int’ [-Wformat=]
	190 |      sprintf(destbuf, "%LX:%LX", (apr_int64_t)MinRev, (apr_int64_t)MaxRev);
	|                            ~~^                        ~~~~~~~~~~~~~~~~~~~
	|                              |                        |
	|                              long long unsigned int   long int
	|                            %lX
	src/SVNWcRev.cpp:192:34: warning: format ‘%LX’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘long int’ [-Wformat=]
	192 |             sprintf(destbuf, "%#LX:%#LX", (apr_int64_t)MinRev, (apr_int64_t)MaxRev);
	|                               ~~~^        ~~~~~~~~~~~~~~~~~~~
	|                                  |        |
	|                                  |        long int
	|                                  long long unsigned int
	|                               %#lX
	src/SVNWcRev.cpp:192:39: warning: format ‘%LX’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘long int’ [-Wformat=]
	192 |             sprintf(destbuf, "%#LX:%#LX", (apr_int64_t)MinRev, (apr_int64_t)MaxRev);
	|                                    ~~~^                        ~~~~~~~~~~~~~~~~~~~
	|                                       |                        |
	|                                       long long unsigned int   long int
	|                                    %#lX
	src/SVNWcRev.cpp:194:26: warning: format ‘%Ld’ expects argument of type ‘long long int’, but argument 3 has type ‘long int’ [-Wformat=]
	194 |      sprintf(destbuf, "%Ld:%Ld", (apr_int64_t)MinRev, (apr_int64_t)MaxRev);
	|                        ~~^       ~~~~~~~~~~~~~~~~~~~
	|                          |       |
	|                          |       long int
	|                          long long int
	|                        %ld
	src/SVNWcRev.cpp:194:30: warning: format ‘%Ld’ expects argument of type ‘long long int’, but argument 4 has type ‘long int’ [-Wformat=]
	194 |      sprintf(destbuf, "%Ld:%Ld", (apr_int64_t)MinRev, (apr_int64_t)MaxRev);
	|                            ~~^                        ~~~~~~~~~~~~~~~~~~~
	|                              |                        |
	|                              long long int            long int
	|                            %ld
	src/SVNWcRev.cpp: In function ‘int main(int, char**)’:
	src/SVNWcRev.cpp:564:38: warning: ‘svn_error_t* svn_client_create_context(svn_client_ctx_t**, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	564 |  svn_client_create_context(&ctx, pool);
	|                                      ^
	In file included from src/SVNWcRev.cpp:27:
	/usr/include/subversion-1/svn_client.h:1117:1: note: declared here
	1117 | svn_client_create_context(svn_client_ctx_t **ctx,
	| ^~~~~~~~~~~~~~~~~~~~~~~~~
	src/SVNWcRev.cpp:564:38: warning: ‘svn_error_t* svn_client_create_context(svn_client_ctx_t**, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	564 |  svn_client_create_context(&ctx, pool);
	|                                      ^
	In file included from src/SVNWcRev.cpp:27:
	/usr/include/subversion-1/svn_client.h:1117:1: note: declared here
	1117 | svn_client_create_context(svn_client_ctx_t **ctx,
	| ^~~~~~~~~~~~~~~~~~~~~~~~~
	src/SVNWcRev.cpp:586:56: warning: ‘const char* svn_path_internal_style(const char*, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	586 |  internalpath = svn_path_internal_style (utf8Path, pool);
	|                                                        ^
	In file included from src/SVNWcRev.cpp:28:
	/usr/include/subversion-1/svn_path.h:73:1: note: declared here
	73 | svn_path_internal_style(const char *path, apr_pool_t *pool);
	| ^~~~~~~~~~~~~~~~~~~~~~~
	src/SVNWcRev.cpp:586:56: warning: ‘const char* svn_path_internal_style(const char*, apr_pool_t*)’ is deprecated [-Wdeprecated-declarations]
	586 |  internalpath = svn_path_internal_style (utf8Path, pool);
	|                                                        ^
	In file included from src/SVNWcRev.cpp:28:
	/usr/include/subversion-1/svn_path.h:73:1: note: declared here
	73 | svn_path_internal_style(const char *path, apr_pool_t *pool);
	| ^~~~~~~~~~~~~~~~~~~~~~~
	g++ -o svnwcrev src/status.o src/SVNWcRev.o -lpthread -L/usr/lib -lsvn_client-1 -lsvn_wc-1 -lsvn_subr-1 -lapr-1
