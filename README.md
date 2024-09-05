# Example on how to perform high-throughput simulations with mkite

This repository contains an example project demonstrating how to use the `mkite` package for performing high-throughput simulations of materials and molecules.
Specifically, this repository shows how to set up the pipeline for an example project where the conformers for 388 molecules are generated locally.

## Repository Structure

- `data/`: Contains YAML files with the SMILES of the molecules whose conformers have to be generated.
- `workflows/`: Contains YAML files with descriptions on how to run the jobs
- `scripts/`: Contains utility scripts for database management and orchestrating the simulations.

### Data

The `data/` folder contains YAML files that describe the molecules whose conformers have to be generated.
For example:

```yaml
- smiles: "CCCCCN"
- smiles: "Cc1ccncc1"
- smiles: "NCCOCCO"
- smiles: "CCNCC"
- smiles: "CCCCN"
- smiles: "c1ccncc1"
```

The list of molecules was selected from the list of SMILES from [this paper](https://doi.org/10.1126/science.abh3350) as an example for this tutorial.

### Workflows

The `workflows/` folder contains YAML files describing the simulation workflows and the jobs that have to be created.
Because this example tutorial is very simple, we have only two jobs: importing the YAML file containing the information on the SMILES; and creating jobs that apply to all imported SMILES.

Example workflow file (`workflows/02_conformer.yaml`):

```yaml
- out_experiment: 02_conformer
  out_recipe: conformer.generation
  inputs:
    - filter:
        parentjob__experiment__name: 01_import
        parentjob__recipe__name: dbimport.MolFileImporter
  tags:
    - confgen
```

The YAML file above specifies that nodes created with experiment `01_import` and `dbimport.MolFileImporter` will be used as inputs for new jobs whose experiments are `02_conformer` and recipe `conformer.generation`. The new jobs will receive the tag `confgen`. The tag is arbitrary and can be anything chosen by the user.

### Scripts

The `scripts/` folder contains utility scripts for managing the database and running simulations:

- `create.sh`: this file loads each of the YAML files in the `workflows` folder and creates the jobs for each of them.
- `submit.sh`: this script submits jobs with status `READY` on the database to the engine. In this case, the engine has to be specified, but it can be the Redis engine or a local folder.
- `parse.sh`: this script parses jobs that have been postprocessed by `mkwind` and reside in the engine prior to being integrated into the production database.
- `backup.sh`: this script backs up the production database to a tarfile

These scripts have to be modified to contain your own paths for the files, the configuration files for the engines, and so on.
You can also specify which database configuration will be used using the `MKITE_ENV` environmental variable.

### Automate scripts with crontab

You can automate the execution of these scripts using crontab. Here's an example crontab configuration:

```
# Run submit.sh every hour
0 * * * * cd /path/to/repo/scripts && ./submit.sh

# Run parse.sh every 15 minutes
*/15 * * * * cd /path/to/repo/scripts && ./parse.sh

# Run backup.sh daily at midnight
0 0 * * * cd /path/to/repo/scripts & ./backup.sh
```

To edit your crontab, use:

```bash
crontab -e
```

Then paste the above configuration, adjusting the paths as necessary.

## Getting Started

For more detailed information about `mkite`, please refer to its official documentation.
