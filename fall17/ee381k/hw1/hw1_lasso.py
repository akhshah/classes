import numpy as np
import numpy.random as rn
import numpy.linalg as la
import matplotlib.pyplot as plt


def frank_wolfe(x, A, b, t, gam):
    # update x (your code here)
    eta = 2/(t + 2)

    st = np.zeros(x.shape[0])

    # find the gradient of the objective
    grad_LS = np.dot(np.transpose(A), np.matmul(A, x) - b)
    maxInd = np.argmax(abs(grad_LS))
    st[maxInd] = -gam*np.sign(grad_LS[maxInd])

    x = x + eta*(st - x)
    return x


def subgradient(x, A, b, t, lam, c=1e-3):
    # update x (your code here), set c above
    eta = c/np.sqrt(t+1)

    Atrans = np.transpose(A)
    z = np.matmul(A, x) - b
    # gradient of the least squares objective
    grad_LS = np.dot(Atrans, z)

    # subgradient of the l1-norm
    grad_l1 = lam*np.sign(x)

    grad = grad_LS + grad_l1

    x = x - eta*grad

    return x

# add BTLS variants and include them in main/descent below
def f_sg(x, A, b, lam):
    f = la.norm(np.matmul(A, x) - b)**2 + lam*la.norm(x, ord=1)
    return f

def grad_sg(x, A, b, lam):
    g = np.dot(np.transpose(A), np.matmul(A, x) - b) + lam*np.sign(x)
    return g

def f_fw(x, A, b):
    f = la.norm(np.matmul(A,x) - b)**2
    return f

def grad_fw(x, A, b):
    g = np.dot(np.transpose(A), np.matmul(A, x) - b)
    return g

def subgradient_BTLS(x, A, b, t, lam, alpha=1e-3):
    #eta =c/np.sqrt(t+1)
    c = 1e-3
    tau = 0.5
    fxk = f_sg(x, A, b, lam)
    gxk = grad_sg(x, A, b, lam)
    while (f_sg(x - alpha*gxk, A, b, lam) <=  fxk + c*alpha*np.dot(gxk,gxk) and alpha  < 1e-10):
        alpha = tau*alpha

    eta = alpha
    Atrans = np.transpose(A)
    z = np.matmul(A, x) - b
    # gradient of the least squares objective
    grad_LS = np.dot(Atrans, z)

    # subgradient of the l1-norm
    grad_l1 = lam*np.sign(x)

    grad = grad_LS + grad_l1

    x = x - eta*grad

    return x

def fw_BTLS(x, A, b, t, gam, alpha=1e-3):
    c = 1e-3
    tau = 0.5
    fxk = f_fw(x, A, b)

    st = np.zeros(x.shape[0])

    # find the gradient of the objective
    grad_LS = np.dot(np.transpose(A), np.matmul(A, x) - b)
    maxInd = np.argmax(abs(grad_LS))
    st[maxInd] = -gam*np.sign(grad_LS[maxInd])

    while (f_fw(x - alpha*(st - x), A, b) <= fxk + c*alpha*np.dot(st-x, st-x) and alpha < 1e-10):
         alpha = tau*alpha

    eta = alpha
    x = x + eta*(st - x)

    return x


def descent(update, A, b, reg, T=int(1e4)):
    x = np.zeros(A.shape[1])
    error = []
    l1 = []
    for t in range(T):
        # update A (either subgradient or frank-wolfe)
        x = update(x, A, b, t, reg)

        # record error and l1 norm
        if (t % 1 == 0) or (t == T - 1):
            error.append(la.norm(np.dot(A, x) - b))
            l1.append(np.sum(abs(x)))

            assert not np.isnan(error[-1])

    return x, error, l1


def main(T=int(1e3)):
    A = np.load("A.npy")
    b = np.load("b.npy")

    # modify regularization parameters below
    x_sg, error_sg, l1_sg = descent(subgradient, A, b, reg=1., T=T)
    x_fw, error_fw, l1_fw = descent(frank_wolfe, A, b, reg=4., T=T)
    # add BTLS experiments
    xsg_btls, error_sgbtls, l1_sgbtls = descent(subgradient_BTLS, A, b, reg=1., T=T)
    xfw_btls, error_fwbtls, l1_fwbtls = descent(fw_BTLS, A, b, reg=4., T=T)

    # add plots for BTLS
    plt.clf()
    plt.plot(error_sg, label='Subgradient')
    plt.plot(error_fw, label='Frank-Wolfe')
    plt.plot(error_sgbtls, label="Subgradient w/ BTLS")
    plt.plot(error_fwbtls, label="Frank-Wolfe w/ BTLS")
    plt.title('Error')
    plt.legend()
    plt.savefig('error.eps')

    plt.clf()
    plt.plot(l1_sg, label='Subgradient')
    plt.plot(l1_fw, label='Frank-Wolfe')
    plt.plot(l1_sgbtls, label="Subgradient w/ BTLS")
    plt.plot(l1_fwbtls, label="Frank-Wolfe w/ BTLS")
    plt.title("$\ell^1$ Norm")
    plt.legend()
    plt.savefig('l1.eps')


if __name__ == "__main__":
    main()
