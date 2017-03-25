import sys
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

def zipf(x, k):
  return 1.0 * k / x


def mandelbrot(x, B, d, P):
  return 1.0 * P / ((x + d) ** B)

file = open("rankHash", "r")

ranks = []
freqs = []

for line in file:
  rank, freq = line.strip().split(':')
  ranks.append(float(rank))
  freqs.append(float(freq))
  
zipfCoef, _ = curve_fit(zipf, ranks, freqs, p0=(1.0))
mandelbrotCoef, _ = curve_fit(mandelbrot, ranks, freqs, p0=(1.0, 0.0, 1000.0))

print("Zipf fit: k=%f" % tuple(zipfCoef))
print("Mandelbrot fit: B=%f, d=%f, p=%f" % tuple(mandelbrotCoef))

plt.plot(ranks, freqs, '-', label="POTOP")
plt.plot(ranks, zipf(ranks, *zipfCoef), '-', label="Zipf")
plt.plot(ranks, mandelbrot(ranks, *mandelbrotCoef), '-', label="Mandelbrot")

plt.xlabel("Rank")
plt.ylabel("Frequency")
plt.yscale('log')

plt.legend()
plt.show()
plt.savefig("graph.png")