Install dependencies and run server:

```bash
cd ./ims-backend
npm install
npm run dev
```

### Fundamentals

- [Prisma ORM](https://www.prisma.io/docs/getting-started/quickstart)

To add a new Prisma migration in different file, you need to run the following command:

```bash
npx prisma db push --schema <SCHEMA_FILE>

# Example

npx prisma db push --schema ./src/apps/core/prisma
