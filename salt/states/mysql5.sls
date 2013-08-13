mysql5:
    pkg.installed:
        - pkgs:
            - mysql-client-5.5
            - mysql-server-5.5
    service:
        - name: mysql
        - running
        - require:
            - pkg: mysql5

python-mysqldb:
    pkg:
        - installed
        - require:
            - pkg: mysql5

mysql-root:
    mysql_user.present:
        - name: root
        - password: root
        - host: 192.168.200.%
        - require:
            - pkg: python-mysqldb

mysql-remote-access:
    mysql_grants.present:
        - grant: all privileges
        - database: '*.*'
        - user: root
        - host: 192.168.200.%
        - require:
            - pkg: mysql-root
