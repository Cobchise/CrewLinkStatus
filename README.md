<br />
<p align="center">
  <h3 align="center">CrewLinkUptime</h3>

  <p align="center">
    Web application that tracks the uptime of CrewLink servers 
    <br />
    <br />
    <a href="https://uptime.among-us.tech">View Site</a>
    ·
    <a href="https://github.com/Cobchise/CrewLinkUptime/issues">Report Bug</a>
    ·
    <a href="https://github.com/Cobchise/CrewLinkUptime/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

### Built With

* [Docker](https://www.docker.com/)
* [Ruby](https://www.ruby-lang.org/en/)
* [Rails](https://rubyonrails.org/)
* [Postgresql](https://www.postgresql.org/)

## Getting Started

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/Cobchise/CrewLinkUptime.git
   ```
2. Install a postgresql server on the Docker host
3. Set up a https reverse proxy (such as nginx) to redirect to port 3000 on the Docker host
3. Build and run the app with docker compose
   ```sh
   docker-compose -f docker-compose.yml -f docker-compose-production.yml build web 
   docker-compose -f docker-compose.yml -f docker-compose-production.yml up -d web
   ```
4. Pre-compile assets
   ```sh
   docker-compose -f docker-compose.yml -f docker-compose-production.uml exec web rails assets:precompile
   ```

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/Cobchise/CrewLinkUptime/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the GNU General Public License v3.0 License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Cobchise - [@cobchise_sec](https://twitter.com/cobchise_sec)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [Ottomated](https://twitch.tv/ottomated) - Creator of CrewLink
* [Innersloth](https://innersloth.com) - Creators of Among Us
