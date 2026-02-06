"""
Tests for the power module
"""

import pytest
from power import power, square, cube


class TestPower:
    """Test cases for the power function"""
    
    def test_power_positive_integers(self):
        """Test power with positive integers"""
        assert power(2, 3) == 8
        assert power(5, 2) == 25
        assert power(10, 3) == 1000
    
    def test_power_zero_exponent(self):
        """Test power with zero exponent"""
        assert power(5, 0) == 1
        assert power(100, 0) == 1
    
    def test_power_one_exponent(self):
        """Test power with exponent of 1"""
        assert power(7, 1) == 7
        assert power(42, 1) == 42
    
    def test_power_negative_exponent(self):
        """Test power with negative exponent"""
        assert power(2, -1) == 0.5
        assert power(10, -2) == 0.01
    
    def test_power_float_base(self):
        """Test power with float base"""
        assert power(2.5, 2) == 6.25
        assert power(1.5, 3) == 3.375


class TestSquare:
    """Test cases for the square function"""
    
    def test_square_positive(self):
        """Test square with positive numbers"""
        assert square(4) == 16
        assert square(5) == 25
        assert square(10) == 100
    
    def test_square_zero(self):
        """Test square of zero"""
        assert square(0) == 0
    
    def test_square_negative(self):
        """Test square with negative numbers"""
        assert square(-3) == 9
        assert square(-5) == 25


class TestCube:
    """Test cases for the cube function"""
    
    def test_cube_positive(self):
        """Test cube with positive numbers"""
        assert cube(2) == 8
        assert cube(3) == 27
        assert cube(5) == 125
    
    def test_cube_zero(self):
        """Test cube of zero"""
        assert cube(0) == 0
    
    def test_cube_negative(self):
        """Test cube with negative numbers"""
        assert cube(-2) == -8
        assert cube(-3) == -27
