**Getting Started**

This project provides a simple guide to deploying a project structure using Docker. The structure includes two applications: a .NET application (app-dotnet) and a React application (app-react). Docker allows you to containerize these applications, making it easier to manage dependencies and deploy them consistently across different environments.

## Prerequisites

Before you begin, make sure you have the following tools installed on your system:

- Docker: [Install Docker](https://docs.docker.com/get-docker/)

## Project Structure

```
docker
├── app-dotnet
│   ├── docker-compose.yml
│   ├── Dockerfile
│   └── ... (dotnet application files)
├── app-react
│   ├── docker-compose.yml
│   ├── Dockerfile
│   └── ... (React application files)
```

The project is organized into two directories: `app-dotnet` and `app-react`. Each directory contains a `docker-compose.yml` file and a `Dockerfile`.

- **app-dotnet**
- **app-react**

## Instructions

Follow the steps below to deploy the applications using Docker:

1. **Clone the Repository**:

   ```sh
   git clone https://github.com/JhonnyPz/Tools-SRE.git
   cd docker
   ```

2. **Deploy Application**:

  | Project | Navigate | Build and Run | Access | Code |
  | --- | --- | --- | --- | --- |
  | .NET 7 | `cd app-dotnet` | ` docker-compose up -d --build` | `http://localhost:3000` | [Ver](app-dotnet/dockerfile) |
  | React 18 | `cd app-react` | ` docker-compose up -d --build` | `http://localhost:3000` | [Ver](app-react/dockerfile) |

5. **Shutdown and Cleanup**:

   To stop and remove the running containers, run the following commands in each application's directory:

   ```sh
   docker-compose down
   ```

## Conclusion

Congratulations! You've successfully deployed the .NET and React applications using Docker. This approach provides a consistent and isolated environment for your applications, making it easier to manage dependencies and deploy them across different systems. Feel free to explore the source code in each application's directory to learn more about their configurations.

For more advanced usage, consider customizing the Dockerfiles and docker-compose.yml files to meet your specific project requirements. Happy coding! 🚀