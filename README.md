# ruby_blog
Simple Ruby api to handle four different entities. 
- user
- posts
- comments
- tags

And a job the deletes posts after 24 hours.

## How to install

To install you need docker and docker composer to be installed on your machine. 
And you need to create and .env file with the variables like `.env.erb`:
```
docker compose up --build
```