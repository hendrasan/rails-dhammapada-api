# Rails Dhammapada API

A Ruby on Rails API that serves the Dhammapada verses and chapters. This API allows you to access Buddhist teachings from the Dhammapada collection.

## Requirements

* Ruby version: 3.3.6
* Rails version: 8.0.1
* Database: PostgreSQL

## Setup

1. Clone the repository
2. Install dependencies:
    ```bash
    bundle install
    rails db:create db:migrate
    ```
3. Seed the database:
    ```bash
    rails db:seed
    ```

## Usage

Start the Rails server:
```bash
rails server
```

## Available Routes

### Health Check
- `GET /up` - Returns 200 if the app boots with no exceptions, otherwise 500.

### API Endpoints

#### Chapters
- `GET /api/v1/chapters` - List all chapters
- `GET /api/v1/chapters/:id` - Show a specific chapter, with list of its verses

#### Verses
- `GET /api/v1/verses` - List all verses
- `GET /api/v1/verses/:id` - Show a specific verse
- `GET /api/v1/verses/random` - Get a random verse

#### Search
- `GET /api/v1/search` - Search verses and chapters

## Contributing

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License.