package db

import (
	"database/sql"
	"fmt"
	"os"

	config "github.com/murillomamud/api-go-postgres/configs"

	_ "github.com/lib/pq"
)

func OpenConnection() (*sql.DB, error) {
	conf := config.GetDB()

	host := os.Getenv("HOST")
	if host != "" {
		conf.Host = host
	}

	sc := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		conf.Host, conf.Port, conf.User, conf.Pass, conf.Database)

	conn, err := sql.Open("postgres", sc)
	if err != nil {
		panic(err)
	}

	err = conn.Ping()

	return conn, err

}
