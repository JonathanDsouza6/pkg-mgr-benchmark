# Paved Road Package Managers Benckmark

Scripts to benchmark various package managers 

# Speed Evaluation

| Title                            | Cache | Node Modules | Lockfile | Description |
| -------------------------------- | ------ | ------------ | -------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Clean Install**                | ❌     | ❌           | ❌       | A completely fresh installation where there is no existing `node_modules` directory, no cached packages, and no lockfile. This simulates installing dependencies from scratch, as if cloning a repo for the first time. |
| **With Cache, With Lockfile**     | ✅     | ❌           | ✅       | Installation is performed with a pre-existing package cache and a lockfile (`package-lock.json` or `yarn.lock`), but without `node_modules`. This scenario represents a common case when a developer clones a repo and installs dependencies while leveraging the cache for faster resolution. |
| **With Cache**                    | ✅     | ❌           | ❌       | Similar to the previous case but without a lockfile. The package manager resolves dependencies without a predefined version map, potentially leading to different versions being installed compared to a lockfile-based installation. |
| **With Lockfile (CI)**            | ❌     | ❌           | ✅       | A typical continuous integration (CI) installation where no cache or `node_modules` directory is available, but a lockfile is present. This ensures a fully reproducible install, often using commands like `npm ci` or `yarn install --frozen-lockfile`. |
| **With Cache, With Node Modules** | ✅     | ✅           | ❌       | Dependencies are reinstalled after deleting the lockfile, but with the cache and `node_modules` still intact. The package manager installs packages based on `node_modules` and available cache data rather than a strict lockfile. |
| **With Node Modules, With Lockfile** | ❌     | ✅           | ✅       | The package cache is cleared, but `node_modules` and the lockfile remain. The install command runs again, relying only on `node_modules` and the lockfile, leading to minimal network requests. |
| **With Node Modules**             | ❌     | ✅           | ❌       | Reinstalling dependencies after deleting the lockfile, without cache, but retaining `node_modules`. This can lead to version mismatches if packages are resolved differently from the previous install. |
