import sympy as simp
from tabulate import tabulate


def mean(data:list):
    return sum(data) / len(data)


def get_data_from_file(file_name:str) -> list:
    data = []
    with open(file_name, 'r') as f:
        for line in f:
            line = line.replace('\n', "").split(' ')
            line = list(map(float, line))
            data.append([line[0], mean(line[1:])])
    return data;


def delta(data:list, func, parameters:list, parameters_error:list) -> list:
    s = 0
    delta = []
    for k in data:
        for param, param_err in zip(parameters, parameters_error):
            if (param == U and k[0] == 0):
                k[0] = param_err
            s += (func.diff(param) * param_err) ** 2
        delta.append(simp.sqrt(s.subs(U, k[0]).subs(I, k[1])))
        s = 0

    return delta




if __name__ == "__main__":
    #for i in range(0, 3):
    I, U, m =  simp.symbols("I,U, m")
    param = [I, U]
    param_error = [0.005, 0.005, 0.007, 0.015]
    m = 1.314
    phi = 24.6 * (10 ** -3)
    I_s = I / (simp.exp(U / (phi * m)) - 1)

    data = get_data_from_file(f"vac{0}.txt")

    delta = delta(data, I_s, param, param_error)
    print("{:<10} {:<10}".format("Is", "delta_Is"))
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    for i, d in zip(data, delta):
        print("{:<10}{:<10}{:<10}".format(i[1], '|', d))




