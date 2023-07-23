set dotenv-load

PHP_EXEC := if os() == "macos" { "$(brew --prefix php@8.0)/bin/php" } else { "php" }
CP_PATH := "ClassicPress-release"
CP_URL := "https://www.classicpress.net/latest.zip"
WP_LANG_URL := "https://translate.wordpress.org/projects/wp/dev/he/default/export-translations/"

setup-database:
    docker create \
        --name cp-$THEME_ID-db                  \
        -e MARIADB_USER=cp                 \
        -e MARIADB_PASSWORD=hihihihi       \
        -e MARIADB_RANDOM_ROOT_PASSWORD=1  \
        -e MARIADB_DATABASE=classicpress   \
        -p "3306:3306"                     \
        mariadb
    docker start cp-$THEME_ID-db

download-classicpress:
    wget {{CP_URL}} -O cp.zip
    unzip cp.zip
    rm cp.zip
    mv ClassicPress-release-* {{CP_PATH}}
    cp wp-config.php {{CP_PATH}}/
    ln -s "$(realpath src)" "{{CP_PATH}}/wp-content/themes/$THEME_ID"
    mkdir "{{CP_PATH}}/wp-content/languages"
    wget "{{WP_LANG_URL}}?format=po" -O "{{CP_PATH}}/wp-content/languages/wp-dev-he.po"
    wget "{{WP_LANG_URL}}?format=mo" -O "{{CP_PATH}}/wp-content/languages/wp-dev-he.mo"

watch:
    cd {{CP_PATH}} && {{PHP_EXEC}} -S localhost:51690
