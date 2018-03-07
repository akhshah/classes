import numpy as np
import numpy.random as rn
import numpy.linalg as la
import matplotlib as plt

def grad(x, Q, b):
    grad = np.dot(Q, x) - b

    return grad

def alpha = step(x, Q, b, g):
    return -(np.inner(g, b) - np.dot(np.dot(np.transpose(g), Q), x))/(np.dot(np.dot(np.transpose(g), Q), g))

def min(x, Q, b, epsilon):
    i = 0
    x2 = 50*rn.rand(x.shape[0]. x.shape[1])
    x.append(x, x2, axis=1)
    while (la.norm(x[i,:] - x[i+1,:]) > epsilon):
        g = grad(x[i,:])
        alpha = step(x[i,:], Q, b, g)

        xn = x[i,:] - alpha*grad

        i = i + 1

    return x, i

def main():
    x = np.array([[0], [0]])
    Q = np.array([[6, 1], [1, 4]])
    b = np.array([[1], [0]])

    # error epsilon
    eps = 0.001;

    # truth
    xstar = np.dot(la.inv(Q), b)
    xn, i = min(x, Q, b, epsilon)

    #plots
    plt.clf()
    i_lin = np.linspace(0, i, num = i+1)
