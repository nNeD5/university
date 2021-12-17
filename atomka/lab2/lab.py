from tabulate import tabulate
from math import sqrt


def get_data(file_name:str, number_freequency) -> list:
    data = []
    with open(file_name, 'r') as f:
        for line in f:
            if (line.find(str(number_freequency) + " ") == 0):
                data.append(float(line.split(" ")[1]))
    return data


def mean(data:list, round_value:int=4) -> float:
    return round(sum(data) / len(data), round_value)


def static_error(data:list, arguments_error:list=[]) -> float:
    mean_value = mean(data)
    result = 0
    for x in data:
        result += (x - mean_value)**2
    result /= len(data)
    for er in arguments_error:
        result += er**2
    return sqrt(result)


def print_table(data:list, fmt:str="grid"):
    s =  "енергiя збудження"
    table = [["Перша " + s, data[0]],
            ["Друга " + s, data[1]],
            ["Третя " + s, data[2]],
            ["Четверта " + s, data[3]],
            ["П'ята " + s, data[4]],
            ["Шоста " + s, data[5]],
            ["Сьома " + s, data[6]]]

    print(tabulate(table, headers=["E", "nu"], tablefmt=fmt))


if __name__ == "__main__":
    v_0 = 19
    E_0 = 42
    table = []
    nu_static_errors = []
    apparat_error = 0.005
    midle_value = 0.004
    for i in range(1, 8):
        data = get_data('frank_hertz_anal.txt', i)
        table.append(round(v_0 * E_0  / (mean(data) * 10**3) , 4))
        nu_static_errors.append(static_error(data, [midle_value, apparat_error]))

    print_table(table)
    print("nu error")
    for er in nu_static_errors:
        print("{:.5f}".format(er))

