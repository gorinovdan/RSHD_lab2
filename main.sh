# ssh -J s338960@helios.cs.ifmo.ru:2222 postgres6@pg155
# Lfvy@7911
# zxEScJL.
# pg155:postgres6:zxEScJL.
# ssh postgres6@pg155
# zxEScJL.
# С узла на хелиос:
# scp postgres6@pg155:tdr49/postgresql.conf /home/studs/s338960/RSHD/lab2/config
# С хелиоса на узел:
# scp -r /home/studs/s338960/RSHD/lab2 postgres6@pg155:./

# Инициализация
mkdir -p $HOME/tdr49
initdb -D $HOME/tdr49 -E UTF8 --locale=ru_RU.UTF-8

# Настройка
rm $HOME/tdr49/postgresql.conf
cp config/postgresql.conf $HOME/tdr49/postgresql.conf
echo "host    all             all             0.0.0.0/0               password" >> $HOME/tdr49/pg_hba.conf
# Запуск сервера БД и создание DB
pg_ctl -D $HOME/tdr49 -l $HOME/tdr49/logfile.log start
createdb -h localhost -p 9150 busyblacklake -T template0 
sleep 3

# Создание директорий табличных пространств
mkdir /var/db/postgres6/oke11 /var/db/postgres6/djb5 /var/db/postgres6/ick81

psql -h localhost -p 9150 -d busyblacklake -U postgres6 -f sql/init.sql 
psql -h localhost -p 9150 -d busyblacklake -U postgres6 -f sql/create_table.sql
psql -h localhost -p 9150 -d busyblacklake -U postgres6 -f sql/create_role.sql
psql -h localhost -p 9150 -d busyblacklake -U new_user -f sql/insert.sql
psql -h localhost -p 9150 -d busyblacklake -U new_user -c '\dt'
psql -h localhost -p 9150 -d busyblacklake -U new_user -c '\du'
psql -h localhost -p 9150 -d busyblacklake -U new_user -c '\db'

