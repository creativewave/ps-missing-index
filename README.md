# Prestashop missing index

Description: find and create missing Prestashop index.php file.

These index files prevent the output of a directory index. A better way of doing this is to configure the web server so that it doesn't output it, eg.:

```
  # Apache
  Options -Indexes
  # Nginx
  autoindex off;
```
See [Apache](https://httpd.apache.org/docs/2.4/mod/core.html#options), or [Nginx](http://nginx.org/en/docs/http/ngx_http_autoindex_module.html)

Usage (`ps-missing-index -h`):

```sh
ps-missing-index -i <dir_name> [-option] [-option <argument>]
```

Commands:
* -s, --silent Don't output directory names.
* -i, --input  Directory path to inspect.
* -c, --create Create index.php.
