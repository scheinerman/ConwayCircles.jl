using Test, ConwayCircles

(A, B, C) = (2 + 3im, 5 - 1im, 8 + 7im);
ConwayCircle(A,B,C)
@test true