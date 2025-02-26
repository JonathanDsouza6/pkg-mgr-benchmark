# pkg-mgr-benchmark
Scripts to benchmark various package managers 

# Speed Evaluation


| Title                            | Cache | Node Modules | Lockfile | Description                                                                                                             |
| -------------------------------- | ----- | ------------ | -------- | ----------------------------------------------------------------------------------------------------------------------- |
| Clean Install                    | No    | No           | No       | **How long it takes to run a totally fresh install: no lockfile present, no packages in cache, and no** `node_modules`. |
| With Cache, With Lockfile        | Yes   | No           | Yes      | **When a repo is fetched by a developer and installation is first run with cache and a lockfile.**                      |
| With Cache                       | Yes   | No           | No       | **Same as above, but the package manager doesn't have a lockfile to work from.**                                        |
| With Lockfile (CI)               | No    | No           | Yes      | **When an installation runs on a CI server (e.g., `npm ci` or `yarn install --frozen-lockfile`).**                      |
| With Cache, With Node Modules    | Yes   | Yes          | No       | **Reinstalling dependencies after deleting the lockfile while keeping cache and `node_modules`.**                       |
| With Node Modules, With Lockfile | No    | Yes          | Yes      | **The package cache is deleted, and the install command is run again.**                                                 |
| With Node Modules                | No    | Yes          | No       | **Reinstalling dependencies after deleting the lockfile, without cache.**                                               |

