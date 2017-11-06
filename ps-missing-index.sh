#!/bin/bash

year=`date +'%Y'`
# Template for index.php (see Tools::getDefaultIndexContent())
template="<?php
/*
 * 2007-$year PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author PrestaShop SA <contact@prestashop.com>
 *  @copyright  2007-$year PrestaShop SA
 *  @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

header(\"Expires: Mon, 26 Jul 1997 05:00:00 GMT\");
header(\"Last-Modified: \".gmdate(\"D, d M Y H:i:s\").\" GMT\");

header(\"Cache-Control: no-store, no-cache, must-revalidate\");
header(\"Cache-Control: post-check=0, pre-check=0\", false);
header(\"Pragma: no-cache\");

header(\"Location: ../\");
exit;"

# Helper
function display_help {
  cat <<EOF
Usage:
  missing-index -i <dir_path> [-option]
  missing-index -i <dir_path> -s -c

Find and create missing Prestashop index.php file.

Commands:
  -i, --input  Directory path to inspect.
  -s, --silent Don't output directory names.
  -c, --create Create missing index.php.
EOF
}

# Parse and assign given parameters.
while : ; do
  case $1 in
    -h|--help)
      display_help
      exit
      ;;
    -i|--input)
      path=$2
      shift 2
      ;;
    -s|--silent)
      silent=true
      shift
      ;;
    -c|--create)
      create=true
      shift
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "Error: unknown option \"$1\"" >&2
      exit 1
      ;;
    *)
      break
      ;;
  esac
done

# Check given parameters.
if [[ ! -e $path ]]; then
  echo "Error: $path does not exist." >&2
  exit 1
elif [[ ! -d $path ]]; then
  echo "Error: $path is not a directory." >&2
  exit 1
fi

# Find and/or create missing index.php.
for dir in `find $path -type d`
do
  if [[ ! -e $dir/index.php ]]; then
    if [[ -z $silent ]]; then
      echo $dir
    fi
    if [[ -n $create ]]; then
      echo "$template" > $dir/index.php
    fi
  fi
done
