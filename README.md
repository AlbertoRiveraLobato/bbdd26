# bbdd26

## The Power Module

A Python utility module for exponentiation operations.

### Features

- **power(base, exponent)**: Calculate any base raised to any exponent
- **square(number)**: Quick calculation of squares
- **cube(number)**: Quick calculation of cubes

### Usage

```python
from power import power, square, cube

# Calculate power
result = power(2, 3)  # Returns 8

# Calculate square
result = square(5)  # Returns 25

# Calculate cube
result = cube(3)  # Returns 27
```

### Testing

Run tests with pytest:

```bash
pytest test_power.py
```