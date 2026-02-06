"""
The Power Module

Provides exponentiation utilities for mathematical operations.
"""


def power(base, exponent):
    """
    Calculate the power of a number.
    
    Args:
        base: The base number (int or float)
        exponent: The exponent (int or float)
    
    Returns:
        The result of base raised to the power of exponent
    
    Examples:
        >>> power(2, 3)
        8
        >>> power(5, 2)
        25
        >>> power(10, 0)
        1
    """
    return base ** exponent


def square(number):
    """
    Calculate the square of a number.
    
    Args:
        number: The number to square (int or float)
    
    Returns:
        The square of the input number
    
    Examples:
        >>> square(4)
        16
        >>> square(5)
        25
    """
    return power(number, 2)


def cube(number):
    """
    Calculate the cube of a number.
    
    Args:
        number: The number to cube (int or float)
    
    Returns:
        The cube of the input number
    
    Examples:
        >>> cube(2)
        8
        >>> cube(3)
        27
    """
    return power(number, 3)
