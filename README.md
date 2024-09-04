# High-Throughput Simulations with mkite

This repository contains an example project demonstrating how to use the `mkite` package for performing high-throughput simulations of materials and molecules.

## Repository Structure

- `data/`: Contains YAML files describing molecules to be generated.
- `workflows/`: Contains workflow descriptions for running simulations in sequence.
- `scripts/`: Contains utility scripts for database management and simulation execution.

## Data

The `data/` folder contains YAML files that describe the molecules to be simulated. For example:

```yaml
# Example content of data/smiles.yaml
molecules:
  - SMILES: CC(=O)O
    name: acetic_acid
  - SMILES: C1=CC=C(C=C1)O
    name: phenol
```

## Workflows

The `workflows/` folder contains YAML files describing the simulation workflows. These files define the sequence of operations to be performed on each molecule.

Example workflow (`workflows/02_conformer.yaml`):

```yaml
name: conformer_generation
steps:
  - name: generate_conformers
    method: rdkit.generate_conformers
    params:
      num_conformers: 10
  - name: optimize_conformers
    method: xtb.geometry_optimization
    params:
      level_of_theory: GFN2-xTB
```

## Scripts

The `scripts/` folder contains utility scripts for managing the database and running simulations:

### create.sh

Creates the initial database structure.

Usage:
```bash
./scripts/create.sh
```

### submit.sh

Submits jobs to the simulation queue.

Usage:
```bash
./scripts/submit.sh [workflow_file]
```

Example:
```bash
./scripts/submit.sh workflows/02_conformer.yaml
```

### parse.sh

Parses the simulation results and updates the database.

Usage:
```bash
./scripts/parse.sh
```

### backup.sh

Creates a backup of the current database state.

Usage:
```bash
./scripts/backup.sh
```

## Automation with Crontab

You can automate the execution of these scripts using crontab. Here's an example crontab configuration:

```
# Run submit.sh every hour
0 * * * * /path/to/repo/scripts/submit.sh /path/to/repo/workflows/02_conformer.yaml

# Run parse.sh every 15 minutes
*/15 * * * * /path/to/repo/scripts/parse.sh

# Run backup.sh daily at midnight
0 0 * * * /path/to/repo/scripts/backup.sh
```

To edit your crontab, use:

```bash
crontab -e
```

Then paste the above configuration, adjusting the paths as necessary.

## Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/mkite-example.git
   cd mkite-example
   ```

2. Install the required dependencies (assuming `mkite` is available):
   ```bash
   pip install mkite
   ```

3. Create the initial database:
   ```bash
   ./scripts/create.sh
   ```

4. Submit your first simulation:
   ```bash
   ./scripts/submit.sh workflows/02_conformer.yaml
   ```

5. Periodically parse results:
   ```bash
   ./scripts/parse.sh
   ```

6. Backup your data regularly:
   ```bash
   ./scripts/backup.sh
   ```

For more detailed information about `mkite`, please refer to its official documentation.
